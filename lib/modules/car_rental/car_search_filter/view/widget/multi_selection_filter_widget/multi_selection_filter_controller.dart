import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/modules/car_rental/car_search_filter/view/widget/multi_selection_filter_widget/multi_selection_filter_model.dart';

class MultiSelectionFilterController extends Bloc<MultiSelectionFilterModel> {
  @override
  MultiSelectionFilterModel initDefaultValue() {
    return MultiSelectionFilterModel(
      selectedFilterIds: [],
      viweState: SelectionViewState.none,
    );
  }

  updateIdsState(String filterId) {
    if (state.selectedFilterIds.contains(filterId)) {
      state.selectedFilterIds.remove(filterId);
    } else {
      state.selectedFilterIds.add(filterId);
    }
    emit(state);
  }

  resetState() {
    state.selectedFilterIds.clear();
    emit(state);
  }

  updateViewState() {
    if (state.viweState == SelectionViewState.collapsed) {
      state.viweState = SelectionViewState.expanded;
    } else {
      state.viweState = SelectionViewState.collapsed;
    }
    emit(state);
  }
}
