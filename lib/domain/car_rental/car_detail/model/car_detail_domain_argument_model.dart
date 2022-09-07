class CarDetailDomainArgumentModel {
  String carId;
  String pickupLocationId;
  String returnLocationId;
  String pickupDate;
  String returnDate;
  String supplierId;
  String includeDriver;
  String residenceCountry;
  String currency;
  String rentalType;
  int age;
  String pickupCounter;
  String returnCounter;

  CarDetailDomainArgumentModel({
    required this.carId,
    required this.pickupLocationId,
    required this.returnLocationId,
    required this.pickupDate,
    required this.returnDate,
    required this.supplierId,
    required this.includeDriver,
    required this.residenceCountry,
    required this.currency,
    required this.rentalType,
    required this.age,
    required this.pickupCounter,
    required this.returnCounter,
  });
}
