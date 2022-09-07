class PopupViewModel {
  PopupDataModel data;
  PopupViewModelState popupViewModelState;
  PopupViewModel(
      {required this.data,
      this.popupViewModelState = PopupViewModelState.none});
}

class PopupDataModel {
  String id;
  String imageUrl;
  String deepLinkUrl;
  String startDate;
  String endDate;
  String priority;
  PopupDataModel({
    this.id = "",
    this.imageUrl = "",
    this.deepLinkUrl = "",
    this.endDate = "",
    this.priority = "",
    this.startDate = "",
  });

  factory PopupDataModel.setDefault() {
    return PopupDataModel(
      id: "",
      imageUrl: "",
      deepLinkUrl: "",
      endDate: "",
      priority: "",
      startDate: "",
    );
  }
}

enum PopupViewModelState {
  none,
  loading,
  success,
  failure,
}
