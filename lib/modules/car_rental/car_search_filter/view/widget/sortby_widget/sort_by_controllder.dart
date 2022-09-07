import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/modules/car_rental/car_search_filter/view/widget/sortby_widget/sort_by_model.dart';
import 'package:ota/modules/car_rental/car_search_filter/view_model/car_search_filter_view_model.dart';

class SortByController extends Bloc<SortByModel> {
  @override
  SortByModel initDefaultValue() {
    return SortByModel();
  }

  setInitialSort(CriterionModel info) {
    state.sortInfo = info;
    state.tempSortInfo = info;
    emit(state);
  }

  resetTemprorySort() {
    state.tempSortInfo = state.sortInfo;
    emit(state);
  }

  updateTemprorySort(CriterionModel info) {
    state.tempSortInfo = info;
    emit(state);
  }

  updateSelectedSort() {
    state.sortInfo = state.tempSortInfo;
    emit(state);
  }
}
