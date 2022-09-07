const List<String> _defaultCategories = [];

class HorizontalCategoryListModel {
  int selectedCategoryIndex;
  List<String> categories;

  HorizontalCategoryListModel({
    this.selectedCategoryIndex = 0,
    this.categories = _defaultCategories,
  });
}
