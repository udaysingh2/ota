class CarDetailArgumentModel {
  String carId;
  String pickupLocationId;
  String returnLocationId;
  DateTime pickupDate;
  DateTime returnDate;
  String? supplierId;
  String includeDriver;
  String residenceCountry;
  String currency;
  String rentalType;
  int age;
  String pickupCounter;
  String returnCounter;
  CarRentalDetailUserType userType;
  String? cityName;
  String? rateKey;
  String? refCode;

  CarDetailArgumentModel({
    required this.carId,
    required this.pickupLocationId,
    required this.returnLocationId,
    required this.pickupDate,
    required this.returnDate,
    this.supplierId,
    required this.includeDriver,
    this.residenceCountry = '',
    required this.currency,
    required this.rentalType,
    required this.age,
    this.pickupCounter = '0',
    this.returnCounter = '0',
    required this.userType,
    this.cityName,
    this.rateKey,
    this.refCode,
  });
}

enum CarRentalDetailUserType {
  guestUser,
  loggedInUser,
}
