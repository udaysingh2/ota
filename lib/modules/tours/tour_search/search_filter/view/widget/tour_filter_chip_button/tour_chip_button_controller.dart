import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_view_model.dart';

class TourChipButtonController extends Bloc<TourChipButtonModel> {
  @override
  TourChipButtonModel initDefaultValue() {
    return TourChipButtonModel(isSelected: false);
  }

  void selectionToggle(TourStyleViewModel style) {
    if (state.isSelected != true) {
      state.isSelected = true;
    } else {
      state.isSelected = false;
    }
    updateSelection(style);
    emit(state);
    return;
  }

  void updateSelection(TourStyleViewModel style) {
    style.isSelected = state.isSelected;
    return;
  }
}

class TourChipButtonModel {
  bool isSelected;
  TourChipButtonModel({
    required this.isSelected,
  });
}
