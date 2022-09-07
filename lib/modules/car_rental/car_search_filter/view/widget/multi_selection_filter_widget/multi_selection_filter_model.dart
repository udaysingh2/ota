class MultiSelectionFilterModel {
  List<String> selectedFilterIds;
  SelectionViewState viweState;

  MultiSelectionFilterModel({
    required this.selectedFilterIds,
    required this.viweState,
  });
}

enum SelectionViewState { expanded, collapsed, none }
