import 'package:ota/domain/tours/review_reservation/models/pickup_point_model_domain.dart';

class PickupPointViewModel {
  List<PickupPointData>? pickUpPoints;
  PickupPointState pageState;
  PickupPointViewModel({
    this.pickUpPoints,
    required this.pageState,
  });
}

enum PickupPointState {
  none,
  success,
  failure,
}

class PickupPointData {
  PickupPointData({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory PickupPointData.fromPickUpPoint(PickupPoint pickupPoint) =>
      PickupPointData(
        id: pickupPoint.id!,
        name: pickupPoint.name!,
      );
}
