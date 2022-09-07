import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_view_model.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_view_model.dart';

import '../../../../core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import '../../../../domain/car_rental/car_payment/models/car_payment_argument_model.dart';
import '../../car_reservation/view_model/car_reservation_argument_view_model.dart';
import '../helper/car_payment_helper.dart';

class CarPaymentArgumentModel {
  OtaCountDownController otaCountDownController;
  int? age;
  String? carName;
  String? brandName;
  String? serviceProvider;
  int? seatNbr;
  int? doorNbr;
  int? bagLargeNbr;
  int? bagSmallNbr;
  String? gear;
  double? totalPrice;
  String? cancellation;
  DateTime? pickupDate;
  DateTime? returnDate;
  String? pickUpPoint;
  String? droffPoint;
  int? duration;
  String? firstName;
  String? secondName;
  String? email;
  String? flightNumber;
  List<ExtraChargeData>? extraCharge;

  String? additionalServiceSubText;
  String? numberOfServices;
  String? imageUrl;
  String? driverFirstName;
  String? driverLastName;
  int? driverAge;

  String? bookingUrn;
  List<AddonDataDomain>? addonsModels;

  String? additionalNeedsText;
  CustomerInfoDataDomain? customerInfo;
  DriverInfoDataDomain? driverInfo;
  GuestInfoDataDomain? guestInfo;
  bool? bookingForSomeoneElse;
  String? rateKey;
  String? refCode;
  CarInfoDataViewModel carDetailInfoDataViewModel;

  String? logoUrl;
  String? craftType;
  String? noOfSmallBag;
  String? noOfDoors;
  String? noOfSeats;
  String? noOfLargeBags;
  CarReservationViewArgumentModel? carReservationViewArgumentModel;
  double? pricePerDay;
  String? meetingPointDescription;
  String? pickUpaddress;
  String? pickUpOpenTime;
  String? pickUpCloseTime;
  String? returnPointDescription;
  String? returnAddress;
  String? returnOpenTime;
  String? returnCloseTime;
  String? fuelType;
  String? engine;
  int? year;
  List<String>? facilities;
  List<OtaFreeFoodPromotionModel>? promotionModelList;
  int? allowLateReturn;

  CarPaymentDomainArgumentModel mapToDomainArgument(context) {
    return CarPaymentDomainArgumentModel(
      addOnServices: CarPaymentHelper.getCarSupplierList(extraCharge, context),
      additionalNeedsText: additionalNeedsText,
      guestInfo: guestInfo,
      customerInfo: CustomerInfoDataDomain(
        firstName: firstName.toString(),
        lastName: secondName.toString(),
      ),
      driverInfo: DriverInfoDataDomain(
        middleName: '',
        nationalityId: '',
        lastName: driverLastName.toString(),
        age: driverAge.toString(),
        firstName: driverFirstName.toString(),
        prefixId: '',
        dateOfBirth: '',
        email: email ?? '',
        telephone: '',
        flightNumber: flightNumber ?? '',
        driverLicenseNumber: '',
      ),
      bookingUrn: bookingUrn,
      rateKey: rateKey,
      refCode: refCode,
      totalPrice: totalPrice,
    );
  }

  factory CarPaymentArgumentModel({
    required OtaCountDownController otaCountDownController,
    String? carName,
    String? brandName,
    String? serviceProvider,
    int? seatNbr,
    int? doorNbr,
    int? bagLargeNbr,
    int? bagSmallNbr,
    String? gear,
    double? totalPrice,
    String? cancellation,
    DateTime? pickupDate,
    DateTime? returnDate,
    String? pickUpPoint,
    String? droffPoint,
    int? duration,
    String? firstName,
    String? secondName,
    String? flightNumber,
    List<ExtraChargeData>? extraCharge,
    String? additionalServiceSubText,
    String? numberOfServices,
    String? imageUrl,
    String? bookingUrn,
    String? rateKey,
    String? refCode,
    String? email,
    int? age,
    String? driverFirstName,
    String? driverLastName,
    int? driverAge,
    List<AddonDataDomain>? addonsModels,
    String? logoUrl,
    String? craftType,
    String? noOfSmallBag,
    String? noOfDoors,
    String? noOfSeats,
    String? noOfLargeBags,
    CarReservationViewArgumentModel? carReservationViewArgumentModel,
    double? pricePerDay,
    String? meetingPointDescription,
    String? pickUpaddress,
    String? pickUpOpenTime,
    String? pickUpCloseTime,
    String? returnPointDescription,
    String? returnAddress,
    String? returnOpenTime,
    String? returnCloseTime,
    String? fuelType,
    String? engine,
    int? year,
    List<String>? facilities,
    List<OtaFreeFoodPromotionModel>? promotionModelList,
    int? allowLateReturn,
    required CarInfoDataViewModel carDetailInfoDataViewModel,
  }) {
    return CarPaymentArgumentModel._named(
      otaCountDownController: otaCountDownController,
      carName: carName,
      brandName: brandName,
      serviceProvider: serviceProvider,
      bagLargeNbr: bagLargeNbr,
      seatNbr: seatNbr,
      gear: gear,
      doorNbr: doorNbr,
      bagSmallNbr: bagSmallNbr,
      totalPrice: totalPrice,
      returnDate: returnDate,
      pickupDate: pickupDate,
      cancellation: cancellation,
      pickUpPoint: pickUpPoint,
      droffPoint: droffPoint,
      duration: duration,
      firstName: firstName,
      secondName: secondName,
      flightNumber: flightNumber,
      extraCharge: extraCharge,
      additionalServiceSubText: additionalServiceSubText,
      numberOfServices: numberOfServices,
      imageUrl: imageUrl,
      bookingUrn: bookingUrn,
      rateKey: rateKey,
      refCode: refCode,
      email: email,
      age: age,
      driverFirstName: driverFirstName,
      driverLastName: driverLastName,
      driverAge: driverAge,
      addonsModels: addonsModels,
      logoUrl: logoUrl,
      craftType: craftType,
      noOfSmallBag: noOfSmallBag,
      noOfDoors: noOfDoors,
      noOfSeats: noOfSeats,
      noOfLargeBags: noOfLargeBags,
      carReservationViewArgumentModel: carReservationViewArgumentModel,
      pricePerDay: pricePerDay,
      meetingPointDescription: meetingPointDescription,
      pickUpaddress: pickUpaddress,
      pickUpOpenTime: pickUpOpenTime,
      pickUpCloseTime: pickUpCloseTime,
      returnPointDescription: returnPointDescription,
      returnAddress: returnAddress,
      returnOpenTime: returnOpenTime,
      returnCloseTime: returnCloseTime,
      fuelType: fuelType,
      engine: engine,
      year: year,
      facilities: facilities,
      carDetailInfoDataViewModel: carDetailInfoDataViewModel,
      promotionModelList: promotionModelList,
      allowLateReturn: allowLateReturn,
    );
  }
  CarPaymentArgumentModel._named({
    required this.otaCountDownController,
    this.carName,
    this.brandName,
    this.serviceProvider,
    this.bagLargeNbr,
    this.seatNbr,
    this.gear,
    this.doorNbr,
    this.bagSmallNbr,
    this.totalPrice,
    this.cancellation,
    this.pickupDate,
    this.returnDate,
    this.pickUpPoint,
    this.droffPoint,
    this.duration,
    this.firstName,
    this.secondName,
    this.flightNumber,
    this.extraCharge,
    this.additionalServiceSubText,
    this.numberOfServices,
    this.imageUrl,
    this.bookingUrn,
    this.rateKey,
    this.refCode,
    this.email,
    this.age,
    this.driverFirstName,
    this.driverLastName,
    this.driverAge,
    this.addonsModels,
    this.logoUrl,
    this.craftType,
    this.noOfSmallBag,
    this.noOfDoors,
    this.noOfSeats,
    this.noOfLargeBags,
    this.carReservationViewArgumentModel,
    this.pricePerDay,
    this.meetingPointDescription,
    this.pickUpaddress,
    this.pickUpOpenTime,
    this.pickUpCloseTime,
    this.returnPointDescription,
    this.returnAddress,
    this.returnOpenTime,
    this.returnCloseTime,
    this.fuelType,
    this.engine,
    this.year,
    this.facilities,
    required this.carDetailInfoDataViewModel,
    this.promotionModelList,
    this.allowLateReturn,
  });
}

class CarInfoDataViewModel {
  List<CarDetailInfoCell> carDetailsPickUp;
  List<CarDetailInfoCell> carDetailsDropOff;
  List<CarDetailInfoCell> carDetails;
  CarDetailInfoCarMainData carInfo;
  CarDetailInfoPricing pricing;
  List<String> facilities;
  LocationsModelData? pickupLocation;
  LocationsModelData? dropOffLocation;

  CarInfoDataViewModel({
    required this.carDetailsPickUp,
    required this.carDetailsDropOff,
    required this.carDetails,
    required this.carInfo,
    required this.pricing,
    required this.facilities,
    this.pickupLocation,
    this.dropOffLocation,
  });
}

class LocationsModelData {
  String? lattitude;
  String? longitude;
  LocationsModelData({this.lattitude, this.longitude});
}
