import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/modules/hotel/hotel_landing_playlist/view/widgets/category_list/horizontal_category_list_model.dart';

class HorizontalCategoryListBloc extends Bloc<HorizontalCategoryListModel> {
  @override
  initDefaultValue() {
    return HorizontalCategoryListModel();
  }

  void setCategories(List<String> categoryList, int? selectedIndex) {
    state.categories = categoryList;
    if (selectedIndex != null &&
        selectedIndex >= 0 &&
        state.categories.isNotEmpty &&
        selectedIndex < state.categories.length) {
      state.selectedCategoryIndex = selectedIndex;
    }
    emit(state);
  }

  void setSelectedCategory(int index) {
    if (state.categories.isNotEmpty &&
        index >= 0 &&
        index < state.categories.length) {
      state.selectedCategoryIndex = index;
      emit(state);
    }
  }
}
