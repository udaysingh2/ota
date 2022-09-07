import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_data_argument.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_result_model.dart';
import 'package:ota/domain/hotel/hotel_addon_service/usecases/hotel_reservation_use_cases.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/hotel_payment_main_argument_model.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/adons_view_model.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/reservation_argument_model.dart';

const _kOffset = 0;
const _kLimit = 20;

class AddonsListBloc extends Bloc<AddonsViewModel> {
  HotelReservationUseCasesImpl hotelReservationUseCasesImpl =
      HotelReservationUseCasesImpl();

  @override
  AddonsViewModel initDefaultValue() {
    return AddonsViewModel();
  }

  void getFromApiCall(
      ReservationArgumentModel? reservationArgumentModel) async {
    state.addonsNetworkState = AddonsNetworkState.loading;
    emit(state);
    if (reservationArgumentModel == null) return;
    Either<Failure, HotelServiceResultModel>? data =
        await hotelReservationUseCasesImpl
            .getHotelAddonServiceData(HotelServiceDataArgument(
      hotelId: reservationArgumentModel.hotelId,
      checkInDate:
          Helpers.getYYYYmmddFromDateTime(reservationArgumentModel.fromDate),
      checkOutDate:
          Helpers.getYYYYmmddFromDateTime(reservationArgumentModel.toDate),
      currency: reservationArgumentModel.currency,
      limit: _kLimit,
      offset: _kOffset,
    ));
    if (data?.isRight ?? false) {
      state.addonsNetworkState = AddonsNetworkState.loaded;
      state.addonsServices =
          apiCallParse(data?.right.getAddonServices?.data?.hotelEnhancements);
      emit(state);
    } else {
      state.addonsNetworkState = AddonsNetworkState.failed;
      emit(state);
    }
  }

  List<AddonsModel> apiCallParse(List<HotelEnhancement>? hotelsHens) {
    if (hotelsHens == null) return [];
    List<AddonsModel> data = [];
    for (HotelEnhancement hotelsHen in hotelsHens) {
      if (hotelsHen.hotelEnhancementId?.isEmpty ?? true) continue;
      if (double.tryParse(hotelsHen.price ?? "") == null) continue;
      if (hotelsHen.hotelEnhancementName?.isEmpty ?? true) continue;
      AddonsModel addon = AddonsModel(
        imageUrl: hotelsHen.image ?? "",
        cost: hotelsHen.price ?? "",
        uniqueId: hotelsHen.hotelEnhancementId ?? "",
        serviceName: hotelsHen.hotelEnhancementName ?? "",
        description: hotelsHen.description ?? "",
        isFlight: hotelsHen.isFlight ?? false,
      );
      if (data.contains(addon)) continue;
      data.add(addon);
    }
    return data;
  }

  double getTotalAmount(double totalPrice) {
    List<AddonsModel> addons = getSelectedAddons();
    for (AddonsModel addonsModel in addons) {
      totalPrice += ((double.tryParse(addonsModel.cost) ?? 0) *
          (int.tryParse(addonsModel.quantity) ?? 0));
    }
    return totalPrice;
  }

  List<AddonsModel> getSelectedAddons() {
    return state.addonsSelected;
  }

  List<AddonsModel> getUnselectedAddons() {
    return state.addonsServices
        .where((element) => !state.addonsSelected.contains(element))
        .toList();
  }

  int getAddonIndex(AddonsModel addonsModel) {
    return state.addonsServices.indexOf(addonsModel);
  }

  void setSelected(AddonsModel model) {
    state.addonsSelected.add(model);
    emit(state);
  }

  List<HotelPaymentAddonsModel> getSelectedForArgument() {
    List<HotelPaymentAddonsModel> result = [];
    for (AddonsModel data in state.addonsSelected) {
      result.add(HotelPaymentAddonsModel(
        quantity: data.quantity,
        selectedDate: data.selectedDate,
        uniqueId: data.uniqueId,
        cost: data.cost,
        serviceName: data.serviceName,
        description: data.description,
        imageUrl: data.imageUrl,
      ));
    }
    return result;
  }

  List<DateTime>? getListOfSelectedDateTime(AddonsModel model) {
    List<DateTime> dateTimes = [];
    for (AddonsModel addonsModel in state.addonsSelected) {
      if (addonsModel.uniqueId == model.uniqueId &&
          model.selectedDate != addonsModel.selectedDate) {
        dateTimes.add(addonsModel.selectedDate!);
      }
    }
    return dateTimes;
  }

  void clearAddons() {
    state.addonsSelected.clear();
    emit(state);
  }

  void setUnSelected(AddonsModel model) {
    final index = state.addonsSelected.indexWhere((element) =>
        (model.selectedDate == element.selectedDate &&
            model.uniqueId == element.uniqueId));
    state.addonsSelected.removeAt(index);
    emit(state);
  }
}
