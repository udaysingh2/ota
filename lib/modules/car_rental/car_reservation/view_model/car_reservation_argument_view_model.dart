import 'package:ota/domain/car_rental/car_reservation/models/car_reservation_argument_model.dart';

import '../../../../common/utils/helper.dart';

class CarReservationViewArgumentModel {
  String? carId;
  String? pickupLocationId;
  String? returnLocationId;
  DateTime? pickupDate;
  DateTime? returnDate;
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
  String? driverFirstName;
  String? driverLastName;
  int? driverAge;

  CarReservationViewArgumentModel({
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
    this.driverLastName,
    this.driverAge,
    this.driverFirstName,
  });
  CarReservationDomainArgumentModel toCarReservationDomainArgumentModel() {
    return CarReservationDomainArgumentModel(
      carId: carId,
      pickupLocationId: pickupLocationId,
      returnLocationId: returnLocationId,
      pickupDate: Helpers.getyyyyMMddTHHmmssFromDateTime(pickupDate),
      returnDate: Helpers.getyyyyMMddTHHmmssFromDateTime(returnDate),
      supplierId: supplierId,
      includeDriver: includeDriver,
      currency: currency,
      rentalType: rentalType,
      age: age,
      pickupCounter: pickupCounter,
      returnCounter: returnCounter,
      rateKey: rateKey,
      refCode: refCode,
      lastPrice: lastPrice,
    );
  }
}
