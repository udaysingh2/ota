class FilterViewModel {
  DateTime fromDate;
  DateTime toDate;
  String nightsCount;
  String roomCount;
  String adultsCount;
  String childCount;
  FilterViewModelDataState filterViewModelDataState;

  FilterViewModel._name(
      this.fromDate,
      this.toDate,
      this.nightsCount,
      this.roomCount,
      this.adultsCount,
      this.childCount,
      this.filterViewModelDataState);

  factory FilterViewModel() {
    return FilterViewModel._name(
      DateTime.now(),
      DateTime.now(),
      "",
      "0",
      "0",
      "0",
      FilterViewModelDataState.initial,
    );
  }
}

enum FilterViewModelDataState {
  initial,
  loading,
  loadedFromServer,
  loadedFromArgument
}
