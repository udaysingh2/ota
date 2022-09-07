import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/modules/car_rental/car_detail_more_info/view_model/car_detail_more_info_argument_model.dart';
import 'package:ota/modules/car_rental/car_detail_more_info/view_model/car_detail_more_info_view_model.dart';

class CarDetailMoreInfoBloc extends Bloc<CarDetailMoreInfoViewModel> {
  @override
  CarDetailMoreInfoViewModel initDefaultValue() {
    return CarDetailMoreInfoViewModel.empty();
  }

  void updateFromArgument(
      CarDetailMoreInfoArgumentModel carDetailMoreInfoArgumentModel) {
    state.carDetailMoreInfoCarRentalCondition.description =
        carDetailMoreInfoArgumentModel.carRentalConditionHtmlText;
    state.carDetailMoreInfoIncludedInRentalPrice.description =
        carDetailMoreInfoArgumentModel.includedInRentalPriceHtmlText;
    state.carDetailMoreInfoPickUp.description =
        carDetailMoreInfoArgumentModel.pickUpHtmlText;
    state.carDetailInfoPickType =
        carDetailMoreInfoArgumentModel.carDetailMoreInfoPickType;
    state.carDetailInfoViewModelType = CarDetailMoreInfoViewModelType.loaded;
    emit(state);
  }

  String getHtmlData() {
    switch (state.carDetailInfoPickType) {
      case CarDetailMoreInfoPickType.includedInRentalPrice:
        return state.carDetailMoreInfoIncludedInRentalPrice.description;
      case CarDetailMoreInfoPickType.pickUp:
        return state.carDetailMoreInfoPickUp.description;
      case CarDetailMoreInfoPickType.carRentalCondition:
        return state.carDetailMoreInfoCarRentalCondition.description;
    }
  }

  int getSelectedIndex() {
    switch (state.carDetailInfoPickType) {
      case CarDetailMoreInfoPickType.includedInRentalPrice:
        return 0;
      case CarDetailMoreInfoPickType.pickUp:
        return 2;
      case CarDetailMoreInfoPickType.carRentalCondition:
        return 1;
    }
  }

  void onTappedByIndex(int index) {
    switch (index) {
      case 0:
        includedInTheRentalPriceTapped();
        break;
      case 1:
        carRentalConditionTapped();
        break;
      case 2:
        pickUpTapped();
        break;
    }
  }

  void includedInTheRentalPriceTapped() {
    state.carDetailInfoPickType =
        CarDetailMoreInfoPickType.includedInRentalPrice;
    emit(state);
  }

  void carRentalConditionTapped() {
    state.carDetailInfoPickType = CarDetailMoreInfoPickType.carRentalCondition;
    emit(state);
  }

  void pickUpTapped() {
    state.carDetailInfoPickType = CarDetailMoreInfoPickType.pickUp;
    emit(state);
  }
}
