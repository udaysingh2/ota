import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import 'package:ota/domain/car_rental/car_rental_booking_detail/model/car_booking_detail_domain_model.dart';
import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_view_model.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/promo_code_view_model.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/public_promo_view_model.dart';

class CarBookingDetailViewModel {
  CarBookingDetailDataModel? bookingDetail;
  CarBookingDetailPageState pageState;
  CarBookingDetailViewModel({
    required this.pageState,
    this.bookingDetail,
  });
}

enum CarBookingDetailPageState {
  loading,
  success,
  failure,
  noData,
  failureNetwork
}

class CarBookingDetailDataModel {
  CarBookingDetailDataModel({
    this.displayStatus,
    this.bookingStatus = CarBookingStatus.confirmed,
    this.bookingUrn,
    this.serviceNumber,
    this.activityStatus,
    this.bookingId,
    this.bookingType,
    this.carBookingDetails,
    this.promotionList = const [],
    this.appliedPromo,
  });
  final String? displayStatus;
  final String? bookingUrn;
  final String? bookingId;
  final CarBookingStatus bookingStatus;
  final String? serviceNumber;
  final CarActivityStatus? activityStatus;
  final String? bookingType;
  final CarBookingDetailModel? carBookingDetails;
  final PromoCodeData? appliedPromo;
  final List<OtaFreeFoodPromotionModel> promotionList;

  factory CarBookingDetailDataModel.fromCarBookingDetailData(
      CarBookingDetailData data) {
    return CarBookingDetailDataModel(
      displayStatus: data.displayStatus,
      bookingStatus: data.bookingStatus == null
          ? CarBookingStatus.confirmed
          : data.bookingStatus!.getCarBookingStatus,
      bookingUrn: data.bookingUrn,
      serviceNumber: data.serviceNumber,
      activityStatus: data.activityStatus == null
          ? CarActivityStatus.success
          : data.activityStatus!.getCarActivityStatus,
      bookingId: data.bookingId,
      bookingType: data.bookingType,
      carBookingDetails: data.carBookingDetails == null
          ? null
          : CarBookingDetailModel.fromCarBookingDetailData(
              data.carBookingDetails!, data.promotion, data.promoPriceDetails),
      promotionList: getOtaFreeFoodPromotionModel(data.promotionList ?? []),
      appliedPromo: (data.promotion == null || data.promoPriceDetails == null)
          ? null
          : PromoCodeData.mapForBookingDetails(
              PromoPriceViewModel.mapFromCarBookingDetails(
                  data.promoPriceDetails!),
              PublicPromotion.mapFromCarBookingDetail(data.promotion!),
              true,
              data.bookingUrn ?? "",
              data.carBookingDetails?.car?.carId ?? "",
              OtaServiceType.carRental),
    );
  }
}

List<OtaFreeFoodPromotionModel> getOtaFreeFoodPromotionModel(
    List<PromotionList> promotionList) {
  return List<OtaFreeFoodPromotionModel>.generate(promotionList.length,
      (index) {
    return OtaFreeFoodPromotionModel(
      deepLinkUrl: promotionList.elementAt(index).web ?? "",
      headerIcon: promotionList.elementAt(index).iconImage ?? "",
      headerText: promotionList.elementAt(index).title ?? "",
      subHeaderText: promotionList.elementAt(index).description ?? "",
      promotionCode: promotionList.elementAt(index).promotionCode ?? "",
      line1: promotionList.elementAt(index).line1 ?? "",
    );
  });
}

class CarBookingDetailModel {
  CarBookingDetailModel(
      {this.car,
      this.pickupCounter,
      this.returnCounter,
      this.paymentDetails,
      this.supplier,
      this.driverName,
      this.flightNumber,
      this.includesInfo,
      this.carRentalConditionsInfo,
      this.pickupConditionsInfo,
      this.extraCharges,
      this.cancellationPolicy,
      this.cancellationPolicyDescription,
      this.paymentStatus = CarBookingPaymentStatus.inprogress,
      this.netPrice,
      this.totalPrice,
      this.grandTotal,
      this.totalPayablePrice,
      this.extrasOnlinePrice,
      this.extrasCounterPrice,
      this.processingFee,
      this.discount,
      this.confirmationDate,
      this.cancellationDate,
      this.cancellationCharge,
      this.cancellationReason,
      this.totalRefundAmount,
      this.pickUpDate,
      this.dropOffDate,
      this.rentalDays,
      this.allowLateReturn,
      this.returnExtraCharge});
  final CarModel? car;
  final CounterModel? pickupCounter;
  final CounterModel? returnCounter;
  final List<PaymentDetailsModel>? paymentDetails;
  final SupplierModel? supplier;
  final List<ExtraChargesModel>? extraCharges;
  final List<CancellationPolicyModel>? cancellationPolicy;
  final String? cancellationPolicyDescription;
  final String? driverName;
  final String? flightNumber;
  final String? includesInfo;
  final String? carRentalConditionsInfo;
  final String? pickupConditionsInfo;
  final CarBookingPaymentStatus paymentStatus;
  final String? cancellationReason;
  final double? netPrice;
  final double? totalPrice;
  final double? grandTotal;
  final double? totalPayablePrice;
  final double? extrasOnlinePrice;
  final double? extrasCounterPrice;
  final double? discount;
  final double? cancellationCharge;
  final double? processingFee;
  final double? totalRefundAmount;
  final int? rentalDays;
  final int? allowLateReturn;
  final DateTime? confirmationDate;
  final DateTime? cancellationDate;
  final DateTime? pickUpDate;
  final DateTime? dropOffDate;
  final double? returnExtraCharge;

  factory CarBookingDetailModel.fromCarBookingDetailData(CarBookingDetails data,
      Promotion? promotion, PromoPriceDetails? priceDetails) {
    return CarBookingDetailModel(
        car: data.car == null ? null : CarModel.fromCar(data.car!),
        pickupCounter: data.pickupCounter == null
            ? null
            : CounterModel.fromCounter(data.pickupCounter!),
        returnCounter: data.returnCounter == null
            ? null
            : CounterModel.fromCounter(data.returnCounter!),
        paymentDetails: data.paymentDetails == null
            ? null
            : List<PaymentDetailsModel>.from(data.paymentDetails!
                .map((extraCharge) => PaymentDetailsModel.fromPaymentDetails(
                      extraCharge,
                    ))),
        supplier: data.supplier == null
            ? null
            : SupplierModel.fromSupplier(data.supplier!),
        extraCharges: data.extraCharges == null
            ? null
            : List<ExtraChargesModel>.from(data.extraCharges!
                .map((extraCharge) => ExtraChargesModel.fromExtraCharges(
                      extraCharge,
                      data.rentalDays ?? 0,
                    ))),
        cancellationPolicy: data.cancellationPolicy == null
            ? null
            : List<CancellationPolicyModel>.from(data.cancellationPolicy!.map(
                (policy) =>
                    CancellationPolicyModel.fromCancellationPolicy(policy))),
        driverName: data.driverName,
        flightNumber: data.flightNumber,
        includesInfo: data.includesInfo,
        carRentalConditionsInfo: data.carRentalConditionsInfo,
        pickupConditionsInfo: data.pickupConditionsInfo,
        paymentStatus: data.paymentStatus == null
            ? CarBookingPaymentStatus.initiated
            : data.paymentStatus!.getCarBookingPaymentStatus,
        cancellationReason: data.cancellationReason,
        cancellationCharge: data.cancellationCharge,
        processingFee: data.processingFee,
        totalRefundAmount:
            ((data.totalRefundAmount ?? 0) >= 0 ? data.totalRefundAmount : 0.0),
        netPrice: data.netPrice,
        totalPrice: data.totalPrice,
        totalPayablePrice: data.totalPayablePrice,
        extrasOnlinePrice: data.extrasOnlinePrice,
        extrasCounterPrice: data.extrasCounterPrice,
        discount: data.discount,
        confirmationDate: data.confirmationDate,
        cancellationDate: data.cancellationDate,
        pickUpDate: data.pickUpDate,
        dropOffDate: data.dropOffDate,
        rentalDays: data.rentalDays,
        allowLateReturn: data.allowLateReturn,
        returnExtraCharge: data.returnExtraCharge,
        grandTotal:
            _getGrandTotalPrice(promotion, priceDetails, data.totalPrice));
  }
  static double? _getGrandTotalPrice(
      Promotion? promotion, PromoPriceDetails? priceDetails, double? netPrice) {
    if (promotion != null && priceDetails != null && netPrice != null) {
      double totalAmount = netPrice - priceDetails.effectiveDiscount!;
      return totalAmount > 0 ? totalAmount : 0.0;
    } else {
      return netPrice;
    }
  }
}

class CancellationPolicyModel {
  CancellationPolicyModel({
    this.cancelDays,
    this.message,
  });

  final int? cancelDays;
  final String? message;

  factory CancellationPolicyModel.fromCancellationPolicy(
      CancellationPolicy data) {
    return CancellationPolicyModel(
      cancelDays: data.cancelDays,
      message: data.message,
    );
  }
}

class PromotionListModel {
  PromotionListModel({
    this.productType,
    this.promotionCode,
    this.title,
    this.description,
    this.web,
  });

  final String? productType;
  final String? promotionCode;
  final String? title;
  final String? description;
  final String? web;
  factory PromotionListModel.fromPromotionList(PromotionList data) {
    return PromotionListModel(
      productType: data.productType,
      promotionCode: data.promotionCode,
      title: data.title,
      description: data.description,
      web: data.web,
    );
  }
}

class CarModel {
  CarModel({
    this.carId,
    this.name,
    this.brand,
    this.crafttype,
    this.seatNbr,
    this.doorNbr,
    this.bagLargeNbr,
    this.bagSmallNbr,
    this.engine,
    this.gear,
    this.facilities,
    this.year,
    this.includesInfo,
    this.images,
    this.fuelType,
  });

  final String? carId;
  final String? name;
  final String? brand;
  final String? crafttype;
  final String? seatNbr;
  final String? doorNbr;
  final String? bagLargeNbr;
  final String? bagSmallNbr;
  final String? engine;
  final String? fuelType;
  final String? gear;
  final String? year;
  final String? includesInfo;
  final List<String>? facilities;
  ImagesModel? images;

  factory CarModel.fromCar(Car data) {
    return CarModel(
      carId: data.carId,
      name: data.name,
      brand: data.brand,
      crafttype: data.crafttype,
      seatNbr: data.seatNbr,
      doorNbr: data.doorNbr,
      bagLargeNbr: data.bagLargeNbr,
      bagSmallNbr: data.bagSmallNbr,
      engine: data.engine,
      gear: data.gear,
      year: data.year,
      includesInfo: data.includesInfo,
      facilities: data.facilities,
      fuelType: data.fuelType,
      images: data.images == null ? null : ImagesModel.fromImages(data.images!),
    );
  }
}

class ImagesModel {
  ImagesModel({
    this.thumb,
    this.full,
  });

  String? thumb;
  String? full;

  factory ImagesModel.fromImages(Images data) {
    return ImagesModel(
      thumb: data.thumb,
      full: data.full,
    );
  }
}

class ExtraChargesModel {
  ExtraChargesModel({
    this.serviceId,
    this.chargeType,
    this.description,
    this.isCompulsory,
    this.name,
    this.price,
    this.quantity,
  });

  final int? serviceId;
  final int? chargeType;
  final double? price;
  final int? quantity;
  final String? description;
  final String? name;
  final bool? isCompulsory;

  factory ExtraChargesModel.fromExtraCharges(
      ExtraCharges data, int rentalDays) {
    return ExtraChargesModel(
      serviceId: data.serviceId,
      chargeType: data.chargeType,
      quantity: data.quantity,
      description: data.description,
      name: data.name,
      isCompulsory: data.isCompulsory,
      price: data.price,
    );
  }
}

class PaymentDetailsModel {
  PaymentDetailsModel(
      {this.cardType,
      this.cardNo,
      this.cardNickName,
      this.type,
      this.amount,
      this.name});

  final String? type;
  final String? name;
  final String? amount;
  final CarPaymentMethodType? cardType;
  final String? cardNo;
  final String? cardNickName;

  factory PaymentDetailsModel.fromPaymentDetails(PaymentDetails data) {
    return PaymentDetailsModel(
      type: data.type,
      name: data.name,
      amount: data.amount,
      cardNo: data.cardNo,
      cardType:
          (data.cardType ?? '').getCarBookingPaymentMethodType(data.type ?? ''),
      cardNickName: data.cardNickName,
    );
  }
}

class CounterModel {
  CounterModel({
    this.locationId,
    this.name,
    this.address,
    this.locationName,
    this.latitude,
    this.longitude,
    this.opentime,
    this.closetime,
    this.description,
    this.id,
  });

  final String? locationId;
  final String? name;
  final String? address;
  final String? locationName;
  final String? latitude;
  final String? longitude;
  final String? opentime;
  final String? closetime;
  final String? description;
  final String? id;

  factory CounterModel.fromCounter(Counter data) {
    return CounterModel(
      id: data.id,
      name: data.name,
      locationId: data.locationId,
      address: data.address,
      locationName: data.locationName,
      latitude: data.latitude,
      longitude: data.longitude,
      opentime: data.opentime,
      closetime: data.closetime,
      description: data.description,
    );
  }
}

class SupplierModel {
  SupplierModel({
    this.id,
    this.name,
    this.logo,
  });

  final String? id;
  final String? name;
  final String? logo;

  factory SupplierModel.fromSupplier(Supplier data) {
    return SupplierModel(
      id: data.id,
      name: data.name,
      logo: data.logo?.url,
    );
  }
}

enum CarBookingStatus {
  confirmed,
  completed,
  cancelled,
}

enum CarActivityStatus {
  awatingConfirmation,
  paymentPending,
  awatingCancellation,
  success,
  userCancelled,
  paymentFailed,
  rejected,
}

extension CarBookingStatusExtension on CarBookingStatus {
  int get getCarBookingStatusValue {
    switch (this) {
      case CarBookingStatus.completed:
        return 1;
      case CarBookingStatus.cancelled:
        return 2;
      default:
        return 0;
    }
  }
}

enum CarBookingPaymentStatus {
  inprogress,
  success,
  failed,
  completed,
  initiated,
  confirmed,
  voidStatus,
}

enum CarPaymentMethodType {
  scb,
  visa,
  jcb,
  master,
  unknown,
  unionpay,
}

extension _CarBookingStatusStringExtension on String {
  CarActivityStatus get getCarActivityStatus {
    switch (this) {
      case "PAYMENT_PENDING":
        return CarActivityStatus.paymentPending;
      case "AWAITING_RESERVATION":
        return CarActivityStatus.awatingConfirmation;
      case "SUCCESS":
        return CarActivityStatus.success;
      case "AWAITING_CANCELLATION":
        return CarActivityStatus.awatingCancellation;
      case "REJECTED":
        return CarActivityStatus.rejected;
      case "USER_CANCELLED":
        return CarActivityStatus.userCancelled;
      case "PAYMENT_FAILED":
        return CarActivityStatus.paymentFailed;
      default:
        return CarActivityStatus.success;
    }
  }

  CarPaymentMethodType getCarBookingPaymentMethodType(String paymentMenthod) {
    switch (paymentMenthod.toUpperCase()) {
      case "CARD":
        switch (toUpperCase()) {
          case "VISA":
            return CarPaymentMethodType.visa;
          case "MASTER":
            return CarPaymentMethodType.master;
          case "JCB":
            return CarPaymentMethodType.jcb;
          case "UNION_PAY":
            return CarPaymentMethodType.unionpay;
          default:
            return CarPaymentMethodType.unknown;
        }
      case "SCB":
      case "PAYWISE":
        return CarPaymentMethodType.scb;
      default:
        return CarPaymentMethodType.unknown;
    }
  }

  CarBookingStatus get getCarBookingStatus {
    switch (this) {
      case "CONFIRMED":
        return CarBookingStatus.confirmed;
      case "COMPLETED":
        return CarBookingStatus.completed;
      case "CANCELLED":
        return CarBookingStatus.cancelled;
      default:
        return CarBookingStatus.confirmed;
    }
  }

  CarBookingPaymentStatus get getCarBookingPaymentStatus {
    switch (this) {
      case "INPROGRESS":
        return CarBookingPaymentStatus.inprogress;
      case "SUCCESS":
        return CarBookingPaymentStatus.success;
      case "FAILED":
        return CarBookingPaymentStatus.failed;
      case "COMPLETED":
        return CarBookingPaymentStatus.completed;
      case "INITIATED":
        return CarBookingPaymentStatus.initiated;
      case "CONFIRMED":
        return CarBookingPaymentStatus.confirmed;
      case "VOID":
        return CarBookingPaymentStatus.voidStatus;
      default:
        return CarBookingPaymentStatus.inprogress;
    }
  }
}

class CarDetailInfoDataViewModel {
  List<CarDetailInfoCell> carDetailsPickUp;
  List<CarDetailInfoCell> carDetailsDropOff;
  List<CarDetailInfoCell> carDetails;
  CarDetailInfoCarMainData carInfo;
  CarDetailInfoPricing pricing;
  LocationModel? pickupLocation;
  LocationModel? dropOffLocation;

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

class LocationModel {
  String? lattitude;
  String? longitude;
  LocationModel({this.lattitude, this.longitude});
}
