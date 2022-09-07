class FabWidgetModel {
  FabWidgetState fabWidgetState;
  FabWidgetModel({this.fabWidgetState = FabWidgetState.collapsed});
}

enum FabWidgetState { isExpanded, collapsed }
