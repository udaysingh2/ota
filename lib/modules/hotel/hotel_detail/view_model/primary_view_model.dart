import 'package:ota/modules/hotel/hotel_detail/view_model/secondary_view_model.dart';

class PrimaryViewModel {
  String roomName;
  // String supplierId;
  // String supplierName;
  double nightPrice;
  SecondaryViewState secondaryViewState;
  List<SecondaryViewModel> children;
  String imageUrl;
  List<FacilityViewModel> facilitiesList;
  PrimaryViewModel(
      {required this.roomName,
      // required this.supplierId,
      // required this.supplierName,
      required this.nightPrice,
      required this.children,
      this.imageUrl = "",
      this.facilitiesList = const [],
      this.secondaryViewState = SecondaryViewState.initial});
}

class FacilityViewModel {
  String key;
  String value;

  FacilityViewModel(this.key, this.value);
}

enum SecondaryViewState { initial, expanded, collapsed }
