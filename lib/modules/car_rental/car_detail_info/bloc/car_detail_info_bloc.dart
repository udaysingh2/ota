import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_argument_model.dart';
import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_view_model.dart';

class CarDetailInfoBloc extends Bloc<CarDetailInfoViewModel> {
  @override
  CarDetailInfoViewModel initDefaultValue() {
    return CarDetailInfoViewModel.empty();
  }

  void updateViewModelFromArgument(
      CarDetailInfoArgumentModel carDetailInfoArgumentModel) {
    state.carDetailInfoDropOff =
        carDetailInfoArgumentModel.carDetailInfoDropOff;
    state.carDetailInfoCarInfo =
        carDetailInfoArgumentModel.carDetailInfoCarInfo;
    state.carDetailInfoPickup = carDetailInfoArgumentModel.carDetailInfoPickup;
    state.carDetailInfoPickType =
        carDetailInfoArgumentModel.carDetailInfoPickType;
    state.carDetailInfoViewModelType = CarDetailInfoViewModelType.loaded;
    state.pickupLocation = carDetailInfoArgumentModel.pickupLocation;
    state.dropOffLocation = carDetailInfoArgumentModel.dropOffLocation;

    emit(state);
  }

  CarDetailInfoPricing getPriceBasedOnState() {
    switch (state.carDetailInfoPickType) {
      case CarDetailInfoPickType.carDetailInfoPickup:
        return state.carDetailInfoPickup.pricing;
      case CarDetailInfoPickType.carDetailInfoDropOff:
        return state.carDetailInfoDropOff.pricing;
      case CarDetailInfoPickType.carDetailInfoCarInfo:
        return state.carDetailInfoCarInfo.pricing;
    }
  }

  List<CarDetailInfoCell> getListBasedOnState() {
    switch (state.carDetailInfoPickType) {
      case CarDetailInfoPickType.carDetailInfoPickup:
        return state.carDetailInfoPickup.carDetails;
      case CarDetailInfoPickType.carDetailInfoDropOff:
        return state.carDetailInfoDropOff.carDetails;
      case CarDetailInfoPickType.carDetailInfoCarInfo:
        return state.carDetailInfoCarInfo.carDetails;
    }
  }

  CarDetailInfoCarMainData? getCarInfoState() {
    switch (state.carDetailInfoPickType) {
      case CarDetailInfoPickType.carDetailInfoPickup:
        return state.carDetailInfoPickup.carInfo;
      case CarDetailInfoPickType.carDetailInfoDropOff:
        return state.carDetailInfoDropOff.carInfo;
      case CarDetailInfoPickType.carDetailInfoCarInfo:
        return null;
    }
  }

  void onTappedByIndex(int index) {
    switch (index) {
      case 0:
        state.carDetailInfoPickType = CarDetailInfoPickType.carDetailInfoPickup;
        break;
      case 1:
        state.carDetailInfoPickType =
            CarDetailInfoPickType.carDetailInfoDropOff;
        break;
      case 2:
        state.carDetailInfoPickType =
            CarDetailInfoPickType.carDetailInfoCarInfo;
        break;
    }
    emit(state);
  }

  bool canShowCarDetailInfo() {
    return (state.carDetailInfoPickType !=
        CarDetailInfoPickType.carDetailInfoCarInfo);
  }

  int getSelectedIndex() {
    switch (state.carDetailInfoPickType) {
      case CarDetailInfoPickType.carDetailInfoPickup:
        return 0;
      case CarDetailInfoPickType.carDetailInfoDropOff:
        return 1;
      case CarDetailInfoPickType.carDetailInfoCarInfo:
        return 2;
    }
  }
}
