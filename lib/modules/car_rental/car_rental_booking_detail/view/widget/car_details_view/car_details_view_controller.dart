import 'package:ota/core_components/bloc/bloc.dart';

class CarDetailsViewController extends Bloc<CarDetailsViewModel> {
  bool get isViewOpen => state.viewState == CardetailViewState.expanded;

  @override
  CarDetailsViewModel initDefaultValue() {
    return CarDetailsViewModel(
      viewState: CardetailViewState.collapsed,
    );
  }

  updateState() {
    if (state.viewState == CardetailViewState.collapsed) {
      state.viewState = CardetailViewState.expanded;
    } else {
      state.viewState = CardetailViewState.collapsed;
    }
    emit(state);
  }
}

class CarDetailsViewModel {
  CardetailViewState viewState;

  CarDetailsViewModel({
    this.viewState = CardetailViewState.collapsed,
  });
}

enum CardetailViewState { expanded, collapsed }
