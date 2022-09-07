class AddonsViewModel {
  List<AddonsModel> addonsSelected;
  List<AddonsModel> addonsServices;
  AddonsNetworkState addonsNetworkState;

  AddonsViewModel._name(
      this.addonsSelected, this.addonsServices, this.addonsNetworkState);
  factory AddonsViewModel() {
    return AddonsViewModel._name([], [], AddonsNetworkState.initial);
  }
}

class AddonsModel {
  String serviceName;
  String imageUrl;
  String quantity;
  DateTime? selectedDate;
  String cost;
  String uniqueId;
  String description;
  bool isFlight;

  AddonsModel({
    this.imageUrl = "",
    this.quantity = "",
    this.cost = "",
    this.selectedDate,
    this.serviceName = "",
    this.uniqueId = "",
    this.description = "",
    required this.isFlight,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddonsModel &&
          runtimeType == other.runtimeType &&
          uniqueId == other.uniqueId;

  @override
  int get hashCode => uniqueId.hashCode;
}

enum AddonsNetworkState {
  initial,
  loading,
  loaded,
  failed,
}
