import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_room_promotion_widget/ota_promotion_model.dart';
import 'package:ota/domain/hotel/hotel_booking_details/models/hotel_booking_detail_model_domain.dart';
import 'package:ota/modules/hotel/hotel_booking_details/helpers/hotel_booking_details_helper.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view_model/hotel_booking_detail_argument.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view_model/hotel_booking_details_room_info_view_model.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view_model/status_type_const.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_type.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/promo_code_view_model.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/public_promo_view_model.dart';

class HotelBookingDetailsViewModel {
  HotelBookingDetailsPageState pageState;
  HotelBookingDetailsData? data;
  HotelBookingDetailArgument? argument;

  HotelBookingDetailsViewModel({
    required this.pageState,
    this.data,
    this.argument,
  });
}

class HotelBookingDetailsData {
  HotelBookingStatus hotelBookingStatus;
  ActivityStatus activityStatus;
  HotelBookingType bookingType;
  String? confirmationDate;
  String bookingUrn;
  String bookingId;
  String bookingStatus;
  String referenceId;
  String bookingStatusCode;
  String? imageUrl;
  String? propertyName;
  int starRating;
  List<HotelBookingDetailsRoomDetails> roomDetailsList;
  List<HotelBookingDetailsFacilityList>? facilityMap;
  String? phoneNumber;
  String? latitude;
  String? longitude;
  String? cancellationDate;
  String? cancellationReason;
  String? address;
  String? hotelId;
  String? cityId;
  String? countryId;
  double pricePerNight;
  List<HotelBookingDetailsAddons>? addonsList;
  List<OtaCancellationPolicyListModel>? cancellationPolicyList;
  List<HotelBookingDetailsPaymentDetails>? hotelBookingDetailsPaymentDetails;
  String checkInDate;
  String checkOutDate;
  String numberOfNights;
  String numberOfRooms;
  String firstName;
  String lastName;
  double totalRoomPrice;
  double totalServicePrice;
  bool freeFoodDelivery;
  double? discountAmount;
  double grandTotal;
  double? amountAdminfee;
  double? amountCancelCharge;
  double? grandTotalWithCancellationCharges;
  double? netPrice;
  String? textWidgetHeaderText;
  String? textWidgetSubHeaderText;
  PromoCodeData? appliedPromo;
  List<OtaPromotionModel> hotelBenfits;
  List<OtaFreeFoodPromotionModel> freeFoodPromotions;
  String? paymentStatus;

  factory HotelBookingDetailsData({
    required HotelBookingStatus hotelBookingStatus,
    required ActivityStatus activityStatus,
    required HotelBookingType bookingType,
    required String bookingUrn,
    required String bookingId,
    required String bookingStatus,
    required String referenceId,
    required String bookingStatusCode,
    String? confirmationDate,
    String? imageUrl,
    String? propertyName,
    required int starRating,
    required List<HotelBookingDetailsRoomDetails> roomDetailsList,
    List<HotelBookingDetailsFacilityList>? facilityMap,
    String? phoneNumber,
    String? latitude,
    String? longitude,
    String? cancellationDate,
    String? cancellationReason,
    String? address,
    String? hotelId,
    String? cityId,
    String? countryId,
    required double pricePerNight,
    List<HotelBookingDetailsAddons>? addonsList,
    List<OtaCancellationPolicyListModel>? cancellationPolicyList,
    List<HotelBookingDetailsPaymentDetails>? hotelBookingDetailsPaymentDetails,
    required String checkInDate,
    required String checkOutDate,
    required String numberOfNights,
    required String numberOfRooms,
    required String firstName,
    required String lastName,
    required double totalRoomPrice,
    required double totalServicePrice,
    required bool freeFoodDelivery,
    required double discountAmount,
    required double grandTotal,
    double? amountAdminfee,
    double? amountCancelCharge,
    double? grandTotalWithCancellationCharges,
    double? netPrice,
    String? textWidgetHeaderText,
    String? textWidgetSubHeaderText,
    PromoCodeData? appliedPromo,
    required List<OtaPromotionModel> hotelBenfits,
    required List<OtaFreeFoodPromotionModel> freeFoodPromotions,
    String? paymentStatus
  }) {
    return HotelBookingDetailsData._named(
      addonsList: addonsList,
      address: address,
      hotelId: hotelId,
      cityId: cityId,
      countryId: countryId,
      bookingStatus: bookingStatus,
      referenceId: referenceId,
      bookingType: bookingType,
      confirmationDate: confirmationDate,
      cancellationPolicyList: cancellationPolicyList,
      checkInDate: checkInDate,
      checkOutDate: checkOutDate,
      discountAmount: discountAmount,
      facilityMap: facilityMap,
      grandTotal: grandTotal,
      hotelBookingStatus: hotelBookingStatus,
      activityStatus: activityStatus,
      imageUrl: imageUrl,
      latitude: latitude,
      longitude: longitude,
      cancellationDate: cancellationDate,
      cancellationReason: cancellationReason,
      numberOfNights: numberOfNights,
      numberOfRooms: numberOfRooms,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      pricePerNight: pricePerNight,
      propertyName: propertyName,
      bookingId: bookingId,
      bookingUrn: bookingUrn,
      roomDetailsList: roomDetailsList,
      starRating: starRating,
      totalRoomPrice: totalRoomPrice,
      totalServicePrice: totalServicePrice,
      bookingStatusCode: bookingStatusCode,
      amountAdminfee: amountAdminfee,
      amountCancelCharge: amountCancelCharge,
      grandTotalWithCancellationCharges: grandTotalWithCancellationCharges,
      hotelBookingDetailsPaymentDetails: hotelBookingDetailsPaymentDetails,
      netPrice: netPrice,
      freeFoodDelivery: freeFoodDelivery,
      textWidgetHeaderText: textWidgetHeaderText,
      textWidgetSubHeaderText: textWidgetSubHeaderText,
      appliedPromo: appliedPromo,
      hotelBenfits: hotelBenfits,
      freeFoodPromotions: freeFoodPromotions,
      paymentStatus: paymentStatus,
    );
  }

  HotelBookingDetailsData._named({
    required this.bookingStatusCode,
    this.addonsList,
    this.address,
    this.hotelId,
    this.countryId,
    this.cityId,
    required this.bookingStatus,
    required this.referenceId,
    required this.bookingType,
    this.confirmationDate,
    this.cancellationPolicyList,
    required this.checkInDate,
    required this.checkOutDate,
    this.discountAmount,
    this.facilityMap,
    required this.grandTotal,
    required this.hotelBookingStatus,
    required this.activityStatus,
    this.imageUrl,
    this.latitude,
    this.longitude,
    this.cancellationDate,
    this.cancellationReason,
    required this.numberOfNights,
    required this.numberOfRooms,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    required this.pricePerNight,
    this.propertyName,
    required this.bookingId,
    required this.bookingUrn,
    required this.roomDetailsList,
    required this.starRating,
    required this.totalRoomPrice,
    required this.totalServicePrice,
    this.amountAdminfee,
    this.amountCancelCharge,
    this.grandTotalWithCancellationCharges,
    this.hotelBookingDetailsPaymentDetails,
    this.netPrice,
    required this.freeFoodDelivery,
    this.textWidgetHeaderText,
    this.textWidgetSubHeaderText,
    this.appliedPromo,
    required this.hotelBenfits,
    required this.freeFoodPromotions,
    this.paymentStatus
  });

  factory HotelBookingDetailsData.fromDomain(
      BookingDetailsData data, HotelBookingDetailArgument argument) {
    return HotelBookingDetailsData(
      referenceId: data.referenceId ?? '',
      bookingStatus: data.bookingStatus ?? '',
      bookingStatusCode: data.bookingStatusCode ?? '',
      confirmationDate: data.hotelBookingDetail?.confirmationDate ?? '',
      bookingUrn: data.bookingUrn ?? '',
      bookingId: data.bookingId ?? '',
      imageUrl: data.hotelBookingDetail?.hotelDetails?.imageUrl ?? '',
      propertyName: data.hotelBookingDetail?.hotelDetails?.name ?? '',
      address: data.hotelBookingDetail?.hotelDetails?.address ?? '',
      hotelId: data.hotelBookingDetail?.hotelDetails?.hotelId ?? '',
      cityId: data.hotelBookingDetail?.hotelDetails?.cityId ?? '',
      countryId: data.hotelBookingDetail?.hotelDetails?.countryId ?? '',
      phoneNumber: data.hotelBookingDetail?.hotelDetails?.phoneNumber ?? '',
      starRating:
          double.tryParse(data.hotelBookingDetail?.hotelDetails?.rating ?? "0")
                  ?.round() ??
              0,
      latitude: data.hotelBookingDetail?.hotelDetails?.latitude ?? '',
      longitude: data.hotelBookingDetail?.hotelDetails?.longitude ?? '',
      cancellationDate: data.hotelBookingDetail?.cancellationDate ?? '',
      cancellationReason: data.hotelBookingDetail?.cancellationReason ?? '',
      facilityMap: HotelBookingDetailHelper.getFacilityList(
          data.hotelBookingDetail?.hotelDetails?.facilities ?? []),
      pricePerNight: data.hotelBookingDetail?.perNightPrice ?? 0.0,
      roomDetailsList: _getRoomDetails(
          data.hotelBookingDetail?.hotelDetails?.roomDetails ?? []),
      checkInDate: data.hotelBookingDetail?.hotelDetails?.checkInDate ?? '',
      checkOutDate: data.hotelBookingDetail?.hotelDetails?.checkOutDate ?? '',
      numberOfNights: data.hotelBookingDetail?.hotelDetails?.totalNights ?? '',
      numberOfRooms: data.hotelBookingDetail?.hotelDetails?.totalRooms ?? '1',
      firstName:
          data.hotelBookingDetail?.hotelDetails?.guestInfo?.first.firstName ??
              '',
      lastName:
          data.hotelBookingDetail?.hotelDetails?.guestInfo?.first.lastName ??
              '',
      addonsList: _getAddonsList(
          data.hotelBookingDetail?.hotelDetails?.addOnServices ?? []),
      cancellationPolicyList: _getCancellationPolicy(
          data.hotelBookingDetail?.hotelDetails?.cancellationPolicy ?? []),
      discountAmount: data.hotelBookingDetail?.discount ?? 0,
      totalServicePrice: _getAddonsPrice(data.promotion, data.promoPriceDetails,
          data.hotelBookingDetail?.addonPrice ?? 0),
      totalRoomPrice: _getTotalRoomPrice(data.promotion, data.promoPriceDetails,
          data.hotelBookingDetail?.netPrice ?? 0),
      grandTotal: _getGrandTotalPrice(data.promotion, data.promoPriceDetails,
          data.hotelBookingDetail?.totalPrice ?? 0),
      amountAdminfee: data.hotelBookingDetail?.amountAdminfee ?? 0.0,
      amountCancelCharge: data.hotelBookingDetail?.amountCancelCharge ?? 0.0,
      grandTotalWithCancellationCharges:
          _getGrandTotalWithCancellationCharges(data),
      bookingType: _getBookingType(_getBookingTypeValue(data.bookingStatus,
          data.hotelBookingDetail?.hotelDetails?.checkOutDate)),
      hotelBookingStatus: _getHotelBookingStatus(data.bookingStatus),
      activityStatus: _getActivityStatus(data.activityStatus),
      hotelBookingDetailsPaymentDetails: _getHotelBookingPaymentDetails(
          data.hotelBookingDetail?.paymentDetails),
      netPrice: data.hotelBookingDetail?.netPrice ?? 0.0,
      freeFoodDelivery:
          data.hotelBookingDetail?.hotelDetails?.freeFoodDelivery ?? false,
      textWidgetHeaderText: HotelBookingDetailHelper.getAdminPromotionLine1(
          data.hotelBookingDetail?.hotelDetails?.promotion ?? []),
      textWidgetSubHeaderText: HotelBookingDetailHelper.getAdminPromotionLine2(
          data.hotelBookingDetail?.hotelDetails?.promotion ?? []),
      appliedPromo: (data.promotion == null || data.promoPriceDetails == null)
          ? null
          : PromoCodeData.mapForBookingDetails(
              PromoPriceViewModel.mapFromHotelBookingDetails(
                  data.promoPriceDetails!),
              PublicPromotion.mapFromHotelBookingDetail(data.promotion!),
              true,
              data.bookingUrn ?? "",
              data.hotelBookingDetail?.hotelDetails?.hotelId ?? "",
              OtaServiceType.hotel),
      hotelBenfits: HotelBookingDetailHelper.getHotelBenefits(
          data.hotelBookingDetail?.hotelDetails?.hotelBenefits ?? []),
      freeFoodPromotions:
          HotelBookingDetailHelper.generateFreeFoodPromotionList(
              data.promotionList ?? []),
        paymentStatus: data.hotelBookingDetail?.paymentStatus ?? ''
    );
  }

  static int _getBookingTypeValue(String? bookingStatus, String? checkOutDate) {
    if (bookingStatus == BookingStatusType.cancelled) {
      return 2;
    } else {
      if (checkOutDate != null) {
        var now = Helpers.getOnlyDateFromDateTime(DateTime.now());
        DateTime dt = DateTime.parse(checkOutDate);
// 0 denotes being equal positive value greater and negative value being less
        if (dt.compareTo(now) >= 0) {
          return 0;
        } else {
          return 1;
        }
      }
    }
    return 0;
  }

  static List<HotelBookingDetailsRoomDetails> _getRoomDetails(
      List<RoomDetail> roomDetails) {
    List<HotelBookingDetailsRoomDetails> result = [];
    for (RoomDetail data in roomDetails) {
      result.add(
        HotelBookingDetailsRoomDetails(
          category: data.name,
          roomType: data.type,
          numberOfRooms: int.tryParse(data.noOfRoom ?? '0') ?? 1,
          adultCount: int.parse(
              data.noOfAdult ?? "${AppConfig().configModel.defaultAdultCount}"),
          childrenCount: int.parse(
              data.noOfChild ?? "${AppConfig().configModel.defaultChildCount}"),
          roomCode: data.roomCode,
          roomCatName: data.roomCatName,
        ),
      );
    }
    return result;
  }

  static double _getGrandTotalWithCancellationCharges(BookingDetailsData data) {
    double totalCancellationCharge =
        (data.hotelBookingDetail?.amountAdminfee ?? 0.0) +
            (data.hotelBookingDetail?.amountCancelCharge ?? 0.0);
    if (data.promotion != null && data.promoPriceDetails != null) {
      double result = data.promoPriceDetails!.billingAmount ??
          0.0 - totalCancellationCharge;
      return result;
    } else {
      double result =
          data.hotelBookingDetail?.totalPrice ?? 0.0 - totalCancellationCharge;
      return result;
    }
  }

  static List<HotelBookingDetailsAddons> _getAddonsList(
      List<AddOnServices> addonService) {
    List<HotelBookingDetailsAddons> result = [];
    for (AddOnServices data in addonService) {
      result.add(HotelBookingDetailsAddons(
        serviceName: data.serviceName,
        cost: data.price,
        quantity: data.noOfItem,
        selectedDate: data.serviceDate,
      ));
    }
    return result;
  }

  static List<OtaCancellationPolicyListModel> _getCancellationPolicy(
      List<CancellationPolicy> cancellationPolicy) {
    List<OtaCancellationPolicyListModel> result = [];
    for (CancellationPolicy data in cancellationPolicy) {
      result.add(OtaCancellationPolicyListModel(
        cancellationChargeDescription: data.cancellationChargeDescription,
        cancellationDaysDescription: data.cancellationDaysDescription,
        cancellationPolicyState: data.cancellationStatus,
      ));
    }
    return result;
  }

  static double _getGrandTotalPrice(
      Promotion? promotion, PromoPriceDetails? priceDetails, double netPrice) {
    if (promotion != null && priceDetails != null) {
      return priceDetails.billingAmount!;
    } else {
      return netPrice;
    }
  }

  static double _getTotalRoomPrice(Promotion? promotion,
      PromoPriceDetails? priceDetails, double orderPrice) {
    if (promotion != null && priceDetails != null) {
      return priceDetails.orderPrice!;
    } else {
      return orderPrice;
    }
  }

  static double _getAddonsPrice(Promotion? promotion,
      PromoPriceDetails? priceDetails, double totalPrice) {
    if (promotion != null && priceDetails != null) {
      return priceDetails.addonPrice!;
    } else {
      return totalPrice;
    }
  }

  double getTotalRefund() {
    double amount = 0.0;
    if (grandTotal > 0.0) {
      amount = grandTotal - (amountCancelCharge! + amountAdminfee!);
    }
    return amount > 0.0 ? amount : 0.0;
  }

  int getRoomCount() {
    int count = 0;
    for (HotelBookingDetailsRoomDetails room in roomDetailsList) {
      count += room.numberOfRooms;
    }
    return count;
  }

  int getAdultCount() {
    int count = 0;
    for (HotelBookingDetailsRoomDetails room in roomDetailsList) {
      count += room.adultCount!;
    }
    return count;
  }

  int getChildCount() {
    int count = 0;
    for (HotelBookingDetailsRoomDetails room in roomDetailsList) {
      count += room.childrenCount!;
    }
    return count;
  }

  String getOfferName() {
    String name = "";
    for (HotelBookingDetailsRoomDetails room in roomDetailsList) {
      name = (name + room.category!).addTrailingSpace();
    }
    return name;
  }

  static ActivityStatus _getActivityStatus(String? activityStatus) {
    switch (activityStatus) {
      case ActivityStatusType.success:
        return ActivityStatus.bookingSuccess;
      case ActivityStatusType.checkedOut:
        return ActivityStatus.completed;
      case ActivityStatusType.userCancelled:
        return ActivityStatus.userCancelled;
      case ActivityStatusType.paymentFailed:
        return ActivityStatus.paymentFailed;
      case ActivityStatusType.hotelRejected:
        return ActivityStatus.hotelRejected;
      case ActivityStatusType.paymentPending:
        return ActivityStatus.paymentPending;
      case ActivityStatusType.awaitingCancellation:
        return ActivityStatus.awaitingCancellation;
      case ActivityStatusType.awaitingConfirmation:
        return ActivityStatus.awaitingConfirmation;
      default:
        return ActivityStatus.none;
    }
  }

  static HotelBookingStatus _getHotelBookingStatus(String? bookingStatus) {
    switch (bookingStatus) {
      case BookingStatusType.confirmed:
        return HotelBookingStatus.bookingConfirmed;
      case BookingStatusType.cancelled:
        return HotelBookingStatus.bookingCancelled;
      default:
        return HotelBookingStatus.bookingPending;
    }
  }

  static HotelBookingType _getBookingType(int bookingType) {
    switch (bookingType) {
      case 0:
        return HotelBookingType.ongoingBooking;
      case 1:
        return HotelBookingType.completedBooking;
      case 2:
        return HotelBookingType.canceledBookings;
      default:
        return HotelBookingType.ongoingBooking;
    }
  }

  static List<HotelBookingDetailsPaymentDetails> _getHotelBookingPaymentDetails(
      List<PaymentDetails>? paymentDetail) {
    List<HotelBookingDetailsPaymentDetails> result = [];
    if (paymentDetail != null) {
      for (PaymentDetails data in paymentDetail) {
        result.add(HotelBookingDetailsPaymentDetails(
            type: data.type,
            name: data.name,
            amount: data.amount,
            paymentMethodType: PaymentMethodExtension.getType(
                data.cardType ?? '', data.type ?? ""),
            cardNickName: data.cardNickName,
            cardNumber: data.cardNumber,
            cardType: data.cardType));
      }
    }
    return result;
  }
}

class HotelBookingDetailsAddons {
  String? serviceName;
  String? imageUrl;
  String? quantity;
  DateTime? selectedDate;
  String? cost;
  String? uniqueId;
  String? description;

  HotelBookingDetailsAddons({
    this.imageUrl,
    this.quantity,
    this.cost,
    this.selectedDate,
    this.serviceName,
    this.uniqueId,
    this.description,
  });
}

class HotelBookingDetailsPaymentDetails {
  String? type;
  String? name;
  String? amount;
  PaymentMethodType? paymentMethodType;
  String? paymentStatus;
  String? cardType;
  String? cardNumber;
  String? cardNickName;

  HotelBookingDetailsPaymentDetails({
    this.type,
    this.name,
    this.amount,
    this.paymentStatus,
    this.cardType,
    this.cardNumber,
    this.cardNickName,
    this.paymentMethodType,
  });
}

class PromotionsHotelList {
  String productId;
  String productType;
  String promotionType;
  String promotionCode;
  String line1;
  String line2;

  PromotionsHotelList({
    this.productId = "",
    this.productType = "",
    this.promotionType = "",
    this.promotionCode = "",
    this.line1 = "",
    this.line2 = "",
  });

  factory PromotionsHotelList.fromList(PromotionsHotelList list) {
    return PromotionsHotelList(
        promotionCode: list.promotionCode,
        promotionType: list.promotionType,
        productType: list.productType,
        line1: list.line1,
        line2: list.line2);
  }

  factory PromotionsHotelList.getDefault() {
    return PromotionsHotelList(
        promotionCode: '',
        promotionType: '',
        productType: '',
        line1: '',
        line2: '');
  }
}

enum HotelBookingStatus { bookingConfirmed, bookingCancelled, bookingPending }

enum ActivityStatus {
  bookingSuccess,
  completed,
  userCancelled,
  paymentFailed,
  hotelRejected,
  paymentPending,
  awaitingCancellation,
  awaitingConfirmation,
  none,
}

enum HotelBookingType {
  ongoingBooking,
  completedBooking,
  canceledBookings,
}

enum HotelBookingDetailsPageState {
  initial,
  loading,
  failure,
  success,
  internetFailure,
}
