import 'package:ota/core_components/bloc/bloc.dart';

class TourFilterSortController extends Bloc<TourFilterSortModel> {
  @override
  TourFilterSortModel initDefaultValue() {
    return TourFilterSortModel(chosenOption: 0);
  }

  void updateChosenOption(int chosenOption) {
    state.chosenOption = chosenOption;
    emit(state);
    return;
  }
}

class TourFilterSortModel {
  int chosenOption;
  TourFilterSortModel({required this.chosenOption});
}
