class CarReservationDomainArgumentModel {
  String? carId;
  String? pickupLocationId;
  String? returnLocationId;
  String? pickupDate;
  String? returnDate;
  String? supplierId;
  String? includeDriver;
  String? residenceCountry;
  String? currency;
  String? rentalType;
  int? age;
  String? pickupCounter;
  String? returnCounter;
  String? rateKey;
  String? refCode;
  double? lastPrice;

  CarReservationDomainArgumentModel({
    this.carId,
    this.pickupLocationId,
    this.returnLocationId,
    this.pickupDate,
    this.returnDate,
    this.supplierId,
    this.includeDriver,
    this.residenceCountry,
    this.currency,
    this.rentalType,
    this.age,
    this.pickupCounter,
    this.returnCounter,
    this.rateKey,
    this.refCode,
    this.lastPrice,
  });
}
