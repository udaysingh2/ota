import 'package:ota/common/utils/helper.dart';
import 'package:ota/modules/car_rental/car_supplier/view_model/car_supplier_arguments_view_model.dart';

class CarSupplierArgumentModel {
  String? pickupLocation;
  String? returnLocation;
  String? pickupDate;
  String? returnDate;
  String? carId;
  String? includeDriver;
  String? residenceCountry;
  String? currency;
  String? rentalType;
  int? age;
  String? pickupCounter;
  String? returnCounter;

  CarSupplierArgumentModel(
    this.pickupLocation,
    this.returnLocation,
    this.pickupDate,
    this.returnDate,
    this.carId,
    this.includeDriver,
    this.residenceCountry,
    this.currency,
    this.rentalType,
    this.pickupCounter,
    this.returnCounter,
    this.age,
  );

  CarSupplierArgumentModel.mapFromViewModelArgument(
      CarSupplierArgumentViewModel argument) {
    pickupLocation = argument.pickupLocationId;
    returnLocation = argument.returnLocationId;
    pickupDate = Helpers.getyyyyMMddTHHmmssFromDateTime(argument.pickupDate);
    returnDate = Helpers.getyyyyMMddTHHmmssFromDateTime(argument.returnDate);
    carId = argument.carId;
    includeDriver = argument.includeDriver;
    residenceCountry = argument.residenceCountry;
    currency = argument.currency;
    rentalType = argument.rentalType;
    age = argument.age;
    pickupCounter = argument.pickupCounter;
    returnCounter = argument.returnCounter;
  }
}
