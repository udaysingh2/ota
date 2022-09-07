import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_view_model.dart';
import 'package:ota/modules/car_rental/car_payment/view_model/car_payment_argument_view_model.dart';

import '../../../../domain/car_rental/car_reservation/models/car_reservation_domain_model.dart';
import '../helpers/car_reservation_helper.dart';

class CarReservationViewModel {
  CarDetailInfoModel? carDetailInfoModel;
  CarReservationPageState pageState;
  ExtraChargeData? extraChargeData;
  CarReservationViewModel({
    required this.pageState,
    this.carDetailInfoModel,
    this.extraChargeData,
  });
}

class CarDetailInfoModel {
  String? bookingUrn;
  String? imageUrl;
  String? price;
  String? logoUrl;
  String? name;
  int? id;
  String? brand;
  String? crafttype;
  int? seatNbr;
  int? doorNbr;
  int? bagLargeNbr;
  int? bagSmallNbr;
  String? gear;
  int? year;
  bool isCarAvailable;
  double? lastPrice;
  double? totalPrice;
  List<ExtraChargeData>? extraCharges;
  String? pickUpLocation;
  DateTime? pickUpDate;
  String? returnLocation;
  DateTime? returnDate;
  int? numberofDays;
  double? pricePerDay;
  String? pickUpaddress;
  String? meetingPointDescription;
  String? returnPointDescription;
  String? pickUpOpenTime;
  String? pickUpCloseTime;
  String? returnAddress;
  String? returnOpenTime;
  String? returnCloseTime;
  String? fuelType;
  String? engine;
  List<String>? facilities;
  String? serviceProvider;
  String? pickUpLatitude;
  String? pickUpLongitude;
  String? returnLatitude;
  String? returnLongitude;
  List<CancellationPolicyListData>? cancellationPolicyList;
  List<OtaFreeFoodPromotionModel>? promotionList;
  String? cancellationPolicyDescription;
  int? allowLateReturn;
  String? maxAge;
  String? minAge;
  int? returnExtraCharge;

  CarDetailInfoModel(
      {this.bookingUrn,
      this.imageUrl,
      this.price,
      this.logoUrl,
      this.id,
      this.name,
      this.brand,
      this.crafttype,
      this.seatNbr,
      this.doorNbr,
      this.bagLargeNbr,
      this.bagSmallNbr,
      this.gear,
      this.year,
      this.totalPrice,
      this.lastPrice,
      this.pickUpLocation,
      this.pickUpDate,
      this.returnLocation,
      this.returnDate,
      this.numberofDays,
      this.serviceProvider,
      this.pricePerDay,
      this.pickUpaddress,
      this.meetingPointDescription,
      this.returnPointDescription,
      this.pickUpOpenTime,
      this.pickUpCloseTime,
      this.returnAddress,
      this.returnOpenTime,
      this.returnCloseTime,
      this.fuelType,
      this.engine,
      this.facilities,
      required this.isCarAvailable,
      this.extraCharges,
      this.pickUpLatitude,
      this.pickUpLongitude,
      this.returnLatitude,
      this.returnLongitude,
      this.cancellationPolicyList,
      this.promotionList,
      this.cancellationPolicyDescription,
      this.allowLateReturn,
      this.minAge,
      this.maxAge,
      this.returnExtraCharge});

  factory CarDetailInfoModel.fromCarDetailInforModel(
      GetCarInitiateBookingResponseData? data) {
    return CarDetailInfoModel(
        bookingUrn: data?.bookingUrn ?? "",
        logoUrl: data?.supplier?.logo?.url ?? "",
        name: data?.car?.name ?? "",
        imageUrl: data?.image ?? "",
        brand: data?.car?.brand ?? "",
        seatNbr: data?.car?.seatNbr,
        doorNbr: data?.car?.doorNbr,
        bagLargeNbr: data?.car?.bagLargeNbr,
        bagSmallNbr: data?.car?.bagSmallNbr,
        gear: data?.car?.gear ?? "",
        pickUpLocation: data?.pickupCounter?.locationName ?? "",
        pickUpDate: data?.fromDate ?? DateTime.now(),
        returnLocation: data?.returnCounter?.locationName ?? "",
        returnDate: data?.toDate ?? DateTime.now(),
        numberofDays: data?.rentalDays,
        serviceProvider: data?.supplier?.name ?? "",
        isCarAvailable: true,
        totalPrice: data?.ratePerDays?.totalDays,
        pricePerDay: data?.ratePerDays?.ratePerDay,
        pickUpaddress: data?.pickupCounter?.address ?? "",
        meetingPointDescription: data?.pickupCounter?.description ?? "",
        returnPointDescription: data?.returnCounter?.description ?? "",
        pickUpOpenTime: data?.pickupCounter?.opentime ?? "",
        pickUpCloseTime: data?.pickupCounter?.closetime ?? "",
        returnAddress: data?.returnCounter?.address ?? "",
        returnOpenTime: data?.returnCounter?.opentime ?? "",
        returnCloseTime: data?.returnCounter?.closetime ?? "",
        fuelType: data?.car?.fuelType ?? "",
        year: data?.car?.year,
        crafttype: data?.car?.crafttype ?? "",
        engine: data?.car?.engine ?? "",
        facilities: data?.car?.facilities,
        extraCharges: _getExtraChargeList(
            data?.extraCharges ?? [], data?.rentalDays ?? 0),
        pickUpLatitude: data?.pickupCounter?.latitude,
        pickUpLongitude: data?.pickupCounter?.longitude,
        returnLatitude: data?.returnCounter?.latitude,
        returnLongitude: data?.returnCounter?.longitude,
        cancellationPolicyList:
            _getCancellationPolicyList(data?.cancellationPolicy ?? []),
        promotionList:
            CarReservationHelper.generatePromotion(data?.promotionList ?? []),
        allowLateReturn: data?.allowLateReturn ?? 0,
        minAge: data?.ratePerDays?.minAge,
        maxAge: data?.ratePerDays?.maxAge,
        returnExtraCharge: data?.ratePerDays?.returnExtraCharge);
  }

  static List<CancellationPolicyListData> _getCancellationPolicyList(
      List<CancellationPolicy> list) {
    List<CancellationPolicyListData> result = [];
    for (CancellationPolicy data in list) {
      result.add(CancellationPolicyListData(
          cancellationDays: data.cancelDays,
          cancellationMessage: data.message));
    }
    return result;
  }

  static List<ExtraChargeData> _getExtraChargeList(
      List<ExtraCharge> extraCharge, int rentalDays) {
    List<ExtraChargeData> result = [];
    for (ExtraCharge item in extraCharge) {
      result.add(ExtraChargeData(
        id: item.id,
        isCompulsory: item.isCompulsory,
        carRateId: item.carRateId,
        fromDate: item.fromDate,
        toDate: item.toDate,
        addonPriceToDisplay: item.price,
        price: item.price,
        description: item.description,
        chargeType: item.chargeType,
        extraChargeGroup: _getExtraChargeGroupData(item.extraChargeGroup),
      ));
    }
    return result;
  }

  static ExtraChargeGroupData _getExtraChargeGroupData(
      ExtraChargeGroup? extraChargeGroup) {
    return ExtraChargeGroupData(
      id: extraChargeGroup?.id,
      description: extraChargeGroup?.description,
      name: extraChargeGroup?.name,
    );
  }
}

class CancellationPolicyListData {
  int? cancellationDays;
  String? cancellationMessage;
  CancellationPolicyListModelState state;
  CancellationPolicyListData({
    this.cancellationDays,
    this.cancellationMessage,
    this.state = CancellationPolicyListModelState.collapsed,
  });
}

class ExtraChargeData {
  int? id;
  int? carRateId;
  DateTime? fromDate;
  DateTime? toDate;
  ExtraChargeGroupData? extraChargeGroup;
  int? price;
  int? addonPriceToDisplay;
  bool? isCompulsory;
  int? chargeType;
  String? description;
  ExtraChargeData({
    this.id,
    this.carRateId,
    this.fromDate,
    this.toDate,
    this.extraChargeGroup,
    this.price,
    this.isCompulsory,
    this.chargeType,
    this.description,
    this.addonPriceToDisplay,
  });
}

class ExtraChargeGroupData {
  int? id;
  String? name;
  String? description;

  ExtraChargeGroupData({
    this.id,
    this.name,
    this.description,
  });
}

enum CancellationPolicyListModelState { expanded, collapsed }
enum CarReservationPageState {
  initial,
  none,
  loading,
  success,
  failure,
  loaded,
  failureUnAvailable,
  failureNetwork
}

class CarDetailInfoDataViewModel {
  List<CarDetailInfoCell> carDetailsPickUp;
  List<CarDetailInfoCell> carDetailsDropOff;
  List<CarDetailInfoCell> carDetails;
  CarDetailInfoCarMainData carInfo;
  CarDetailInfoPricing pricing;
  LocationsModelData? pickupLocation;
  LocationsModelData? dropOffLocation;

  CarDetailInfoDataViewModel({
    required this.carDetailsPickUp,
    required this.carDetailsDropOff,
    required this.carDetails,
    required this.carInfo,
    required this.pricing,
    this.pickupLocation,
    this.dropOffLocation,
  });
}
