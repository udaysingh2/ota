import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_model.dart';
import 'package:ota/domain/hotel/booking_initiate/models/argument_data_model.dart';
import 'package:ota/domain/hotel/booking_initiate/models/booking_data_model.dart';
import 'package:ota/domain/hotel/booking_initiate/usecases/reservation_room_usecases.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/bloc/filter_view_bloc.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/helpers/reservation_helper.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/reservation_argument_model.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/reservation_room_info_view_model.dart'
    as v_model;
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/your_list_view_model.dart';

class YourListBloc extends Bloc<YourListViewModel> {
  ReservationRoomUseCase reservationRoomUseCasesImpl =
      ReservationRoomUseCasesImpl();

  @override
  YourListViewModel initDefaultValue() {
    return YourListViewModel();
  }

  Future<void> reloadFromRefresh(FilterViewBloc filterViewBloc,
      ReservationArgumentModel? reservationArgumentModel) async {
    await processApi(filterViewBloc, reservationArgumentModel, isRefresh: true);
  }

  void getFromApiCall(FilterViewBloc filterViewBloc,
      ReservationArgumentModel? reservationArgumentModel) async {
    processApi(filterViewBloc, reservationArgumentModel);
  }

  Future<void> processApi(FilterViewBloc filterViewBloc,
      ReservationArgumentModel? reservationArgumentModel,
      {isRefresh = false}) async {
    if (reservationArgumentModel == null) {
      state.yourListViewModelState = YourListViewModelState.failed;
      emit(state);
      return;
    }
    if (!isRefresh) {
      state.yourListViewModelState = YourListViewModelState.loading;
      emit(state);
    }

    Either<Failure, BookingData?>? data =
        await reservationRoomUseCasesImpl.getRoomDetail(ReservationDataArgument(
      hotelId: reservationArgumentModel.hotelId,
      cityId: reservationArgumentModel.cityId,
      checkInDate:
          Helpers.getYYYYmmddFromDateTime(reservationArgumentModel.fromDate),
      checkOutDate:
          Helpers.getYYYYmmddFromDateTime(reservationArgumentModel.toDate),
      room: reservationArgumentModel
          .getRoomDataList(reservationArgumentModel.rooms),
      currency: reservationArgumentModel.currency,
      countryId: reservationArgumentModel.countryId,
      roomCode: reservationArgumentModel.roomCode,
      roomCategory: reservationArgumentModel.roomCategory,
      price: reservationArgumentModel.price,
      supplierId: reservationArgumentModel.supplierId,
      supplierName: reservationArgumentModel.supplierName,
      mealCode: reservationArgumentModel.mealCode ?? '',
    ));
    if (data?.isLeft ?? true) {
      if (data?.left is InternetFailure) {
        state.yourListViewModelState = YourListViewModelState.internetFailure;
      } else {
        state.yourListViewModelState = YourListViewModelState.failed;
      }
      emit(state);
      return;
    }
    if (data?.right?.data != null) {
      state.hotelName = data?.right?.data?.hotelName ?? "";
      state.bookingUrn = data!.right!.data!.bookingUrn!;
      state.nights =
          int.tryParse(data.right?.data?.roomDetails?.numberOfNights ?? "") ??
              1;
      state.price =
          data.right?.data?.roomDetails?.perNightPrice?.toString() ?? "0";
      state.totalPrice =
          data.right?.data?.roomDetails?.totalPrice?.toString() ?? "0";
      state.roomTitle = data.right?.data?.roomDetails?.mealType ?? "";
      state.imageUrl = data.right?.data?.hotelImage ?? "";
      state.address = reservationArgumentModel.address;
      state.rating = reservationArgumentModel.rating;
      state.categoriesList = getCategoriesListHelper(
          data.right?.data?.roomDetails?.roomCategories);
      state.facilitiesList = ReservationHelper.getFacilityListHelper(
          data.right?.data?.roomDetails?.facilities);
      state.cancellationPolicy = data.right?.data?.roomDetails
              ?.cancellationPolicy?[0].cancellationStatus ??
          "";
      state.cancellationPolicyList = getCancellationPolicyListListHelper(
          data.right?.data?.roomDetails?.cancellationPolicy);
      state.yourListViewModelState = YourListViewModelState.loaded;
      state.specialPromotionDetailList =
          ReservationHelper.generatePromotionList(
              data.right?.data?.roomDetails?.specialPromotions);
      state.freeFoodPromotions =
          ReservationHelper.generateFreeFoodPromotionList(
              data.right?.data?.promotionList);
      //Todo : Testing Data
      state.isRoomAvailable = true;
      filterViewBloc.updateNightCountFromServer(state.nights.toString());
      emit(state);
    } else {
      state.yourListViewModelState = YourListViewModelState.failed;
      emit(state);
    }
  }

  List<v_model.RoomDetails> getCategoriesListHelper(
      List<RoomCategory>? categories) {
    List<v_model.RoomDetails> details = [];
    if (categories == null) return details;
    for (RoomCategory category in categories) {
      details.add(v_model.RoomDetails(
        category: category.roomName ?? "",
        numberOfRooms: category.noOfRooms,
        roomType: category.roomType ?? "",
        noOfRoomsAndName: category.noOfRoomsAndName ?? "",
      ));
    }
    return details;
  }

  List<OtaCancellationPolicyListModel> getCancellationPolicyListListHelper(
      List<CancellationPolicy>? categories) {
    if (categories == null) return [];
    List<OtaCancellationPolicyListModel> details = [];
    for (CancellationPolicy category in categories) {
      details.add(OtaCancellationPolicyListModel(
        cancellationChargeDescription: category.cancellationChargeDescription,
        cancellationDaysDescription: category.cancellationDaysDescription,
        cancellationPolicyState: category.cancellationStatus,
      ));
    }
    return details;
  }
}
