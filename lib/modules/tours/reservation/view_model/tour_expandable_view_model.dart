class TourExpandableViewModel {
  TourExpandableModelState state;

  TourExpandableViewModel({
    this.state = TourExpandableModelState.collapsed,
  });
}

enum TourExpandableModelState { expanded, collapsed }
