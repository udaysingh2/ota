import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_expandable_view_model.dart';

class TourExpandableController extends Bloc<TourExpandableViewModel> {
  @override
  TourExpandableViewModel initDefaultValue() {
    return TourExpandableViewModel();
  }

  void toggle() {
    if (state.state == TourExpandableModelState.collapsed) {
      state.state = TourExpandableModelState.expanded;
    } else if (state.state == TourExpandableModelState.expanded) {
      state.state = TourExpandableModelState.collapsed;
    }
    emit(state);
  }
}
