class CarDetailShareArgumentModel {
  String carId;
  String pickupLocationId;
  String returnLocationId;
  String pickupCounter;
  String returnCounter;

  CarDetailShareArgumentModel({
    required this.carId,
    required this.pickupLocationId,
    required this.returnLocationId,
    required this.pickupCounter,
    required this.returnCounter,
  });
  factory CarDetailShareArgumentModel.fromOtaPropertyChannel(
          String productId,
          String pickupLocationId,
          String returnLocationId,
          String pickupCounter,
          String returnCounter) =>
      CarDetailShareArgumentModel(
        carId: productId,
        pickupLocationId: pickupLocationId,
        returnLocationId: returnLocationId,
        pickupCounter: pickupCounter,
        returnCounter: returnCounter,
      );
}
