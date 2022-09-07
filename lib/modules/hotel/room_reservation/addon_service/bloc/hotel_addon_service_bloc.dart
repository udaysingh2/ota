import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_data_argument.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_result_model.dart';
import 'package:ota/domain/hotel/hotel_addon_service/usecases/hotel_service_use_cases.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service/helpers/hotel_addon_service_helper.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service/view_model/hotel_service_view_argument.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service/view_model/hotel_service_view_model.dart';

const int _kAddonServiceLimit = 20;

class HotelAddonServiceBloc extends Bloc<HotelServiceViewModel> {
  HotelServiceUseCases hotelServiceUseCases = HotelServiceUseCasesImpl();
  int _addonServiceOffset = 0;

  @override
  HotelServiceViewModel initDefaultValue() {
    return HotelServiceViewModel(addonServiceList: []);
  }

  void getHotelAddonServiceData(
      {required HotelServiceViewArgument? viewArgument,
      bool isPullToRefresh = false}) async {
    if (viewArgument == null) {
      state.addonServiceState = HotelServiceViewModelState.failure;
      emit(state);
      return;
    }

    state.addonServiceState = isPullToRefresh
        ? HotelServiceViewModelState.pullDownLoading
        : HotelServiceViewModelState.loading;
    emit(state);

    if (isPullToRefresh) _addonServiceOffset = 0;

    Either<Failure, HotelServiceResultModel>? result =
        await hotelServiceUseCases.getHotelAddonServiceData(
            HotelServiceDataArgument.fromViewArgument(
                viewArgument, _kAddonServiceLimit, _addonServiceOffset));

    if (result != null && result.isRight) {
      List<AddonServiceViewModel> addonServiceList =
          HotelAddonServiceHelper.getAddonServiceViewModelList(
                  result.right.getAddonServices?.data?.hotelEnhancements) ??
              [];

      /// setting the offset
      _addonServiceOffset += _kAddonServiceLimit;

      if (isPullToRefresh) {
        _addonServiceOffset = 0;
        state.addonServiceList.clear();
        emit(state);
      }

      if (state.addonServiceList.isEmpty) {
        state.addonServiceList = addonServiceList;
        state.addonServiceState = HotelServiceViewModelState.success;
        emit(state);
        return;
      }

      if (state.addonServiceList.isNotEmpty) {
        state.addonServiceState = HotelServiceViewModelState.success;
        state.addonServiceList.addAll(addonServiceList);
        emit(state);
      }
    } else {
      state.addonServiceState = HotelServiceViewModelState.failure;
      emit(state);
    }
  }

  bool get isLoading =>
      state.addonServiceState == HotelServiceViewModelState.loading &&
      state.addonServiceList.isEmpty;

  bool get isLazyLoading =>
      state.addonServiceState == HotelServiceViewModelState.loading &&
      state.addonServiceList.isNotEmpty;

  bool get isFailure =>
      state.addonServiceState == HotelServiceViewModelState.failure &&
      state.addonServiceList.isEmpty;

  bool get isSuccessEmpty =>
      state.addonServiceState == HotelServiceViewModelState.success &&
      state.addonServiceList.isEmpty;

  bool get pullDownLoading =>
      state.addonServiceState == HotelServiceViewModelState.pullDownLoading &&
      state.addonServiceList.isNotEmpty;
}
