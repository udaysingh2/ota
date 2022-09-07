import 'package:ota/common/utils/helper.dart';
import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import 'package:ota/domain/tours/tour_booking_detail/models/tours_booking_details_model_domain.dart';
import 'package:ota/modules/hotel/hotel_detail/helpers/facility_helper.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_type.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/promo_code_view_model.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/public_promo_view_model.dart';
import 'package:ota/modules/tours/booking_details/helper/tour_booking_detail_helper.dart';
import 'package:ota/modules/tours/booking_details/view_model/tour_booking_detail_argument.dart';
import 'package:ota/modules/tours/booking_details/view_model/tour_booking_package_detail_view_model.dart';

const double _kDefaultAmount = 0.0;
const String _kVA = "VA";

class TourBookingDetailsViewModel {
  TourBookingDetailsPageStates pageState;
  TourBookingDetailsData? data;
  TourBookingPackageDetailViewModel? packageDetail;
  TourBookingDetailArgument? argument;

  TourBookingDetailsViewModel({
    required this.pageState,
    this.data,
    this.argument,
    this.packageDetail,
  });
}

class TourBookingDetailsData {
  String bookingType;
  TourAndTicketBookingType tourBookingType;
  TourAndTicketBookingStatus tourBookingStatus;
  String activityStatus;
  String countryId;
  String tourId;
  String cityId;
  String bookingStatus;
  String name;
  double adultPrice;
  int noOfAdults;
  double netPrice;
  double totalPrice;
  double discount;
  String? bookingUrn;
  String? orderId;
  String? bookingId;
  String? bookingDate;
  String? cancellationDate;
  double? cancellationCharge;
  String? cancellationReason;
  double? totalRefundAmount;
  String? imageUrl;
  String? category;
  String? location;
  String? packageName;
  List<TourBookingDetailsHighlight>? highlights;
  String? cancellationPolicy;
  String? cancellationHeader;
  String? duration;
  String? meetingPoint;
  int? minAge;
  int? maxAge;
  double? childPrice;
  String? noOfDays;
  int? noOfChild;
  List<TourBookingDetailsParticipantsInfo>? participantsInfo;
  String? providerName;
  String? supplierContact;
  String? paymentStatus;
  String? paymentMethod;
  PaymentMethodType? paymentType;
  String? cardType;
  String? cardNickname;
  String? cardNo;
  String? confirmationDate;
  TourBookingInformation? informationViewModel;
  List<OtaFreeFoodPromotionModel> promotionData;
  PromoCodeData? appliedPromo;
  TourBookingWalletPaymentDetails? walletPaymentDetails;
  bool isCardPaymentAvailable;

  TourBookingDetailsData({
    required this.bookingType,
    required this.tourBookingType,
    required this.tourBookingStatus,
    required this.activityStatus,
    required this.bookingStatus,
    required this.name,
    required this.adultPrice,
    required this.noOfAdults,
    required this.cityId,
    required this.countryId,
    required this.tourId,
    required this.netPrice,
    required this.totalPrice,
    required this.discount,
    this.bookingUrn,
    this.orderId,
    this.bookingId,
    this.bookingDate,
    this.cancellationDate,
    this.cancellationCharge,
    this.cancellationReason,
    this.totalRefundAmount,
    this.imageUrl,
    this.category,
    this.location,
    this.packageName,
    this.childPrice,
    this.noOfDays,
    this.noOfChild,
    this.duration,
    this.cancellationPolicy,
    this.meetingPoint,
    this.minAge,
    this.maxAge,
    this.highlights,
    this.participantsInfo,
    this.providerName,
    this.supplierContact,
    this.paymentStatus,
    this.paymentType,
    this.paymentMethod,
    this.cardType,
    this.cardNickname,
    this.cardNo,
    this.cancellationHeader,
    this.confirmationDate,
    this.informationViewModel,
    this.appliedPromo,
    required this.promotionData,
    this.walletPaymentDetails,
    required this.isCardPaymentAvailable,
  });

  factory TourBookingDetailsData.fromDomain(Data data) {
    return TourBookingDetailsData(
      bookingStatus: data.bookingStatus!,
      bookingUrn: data.bookingUrn,
      activityStatus: data.activityStatus ?? '',
      cityId: data.tourBookingDetail!.cityId!,
      countryId: data.tourBookingDetail!.countryId!,
      tourId: data.tourBookingDetail!.tourId!,
      name: data.tourBookingDetail!.name!,
      bookingType: data.bookingType!,
      category: data.tourBookingDetail!.category,
      adultPrice: data.tourBookingDetail!.price!.adultPrice ?? _kDefaultAmount,
      noOfAdults: data.tourBookingDetail!.adults!,
      netPrice: _getNetPrice(
          data.tourBookingDetail!.promotion,
          data.tourBookingDetail!.priceDetails,
          data.tourBookingDetail!.netPrice!),
      totalPrice: _getTotalPrice(
          data.tourBookingDetail!.promotion,
          data.tourBookingDetail!.priceDetails,
          data.tourBookingDetail!.totalPrice!),
      orderId: data.orderId,
      bookingId: data.bookingId,
      imageUrl: data.tourBookingDetail!.imageUrl,
      location: data.tourBookingDetail!.location,
      tourBookingType: TourAndTicketBookingDetailHelper.getBookingTypeValue(
          data.bookingStatus!, data.tourBookingDetail!.bookingDate),
      tourBookingStatus: TourAndTicketBookingDetailHelper.getBookingStatus(
          data.bookingStatus!,
          data.activityStatus,
          data.tourBookingDetail?.bookingDate),
      bookingDate: data.tourBookingDetail!.bookingDate,
      cancellationDate: Helpers.getddMMMyy(
          DateTime.tryParse(data.tourBookingDetail!.cancellationDate ?? '') ??
              DateTime.now()),
      cancellationCharge: data.tourBookingDetail!.cancellationCharge,
      cancellationReason: data.tourBookingDetail!.cancellationReason,
      totalRefundAmount: ((data.tourBookingDetail!.totalRefundAmount ?? 0) >= 0
          ? data.tourBookingDetail!.totalRefundAmount
          : 0),
      packageName: data.tourBookingDetail!.packageDetail?.packageName,
      childPrice: data.tourBookingDetail!.price?.childPrice,
      noOfDays: data.tourBookingDetail!.noOfDays,
      noOfChild: data.tourBookingDetail!.child,
      duration: data.tourBookingDetail!.packageDetail?.durationText,
      discount: data.tourBookingDetail!.discount ?? _kDefaultAmount,
      cancellationPolicy:
          data.tourBookingDetail!.packageDetail?.cancellationPolicy,
      meetingPoint: data.tourBookingDetail!.packageDetail?.meetingPoint,
      minAge: data.tourBookingDetail!.packageDetail?.childInfo?.minAge,
      maxAge: data.tourBookingDetail!.packageDetail?.childInfo?.maxAge,
      highlights: _getHighlightsDetails(
          data.tourBookingDetail!.packageDetail?.inclusions?.highlights),
      participantsInfo:
          _getParticipantsInfoDetails(data.tourBookingDetail!.participantInfo),
      providerName: data.tourBookingDetail!.providerName,
      supplierContact: data.tourBookingDetail!.supplierContact,
      paymentStatus: data.tourBookingDetail!.paymentStatus,
      paymentType: PaymentMethodExtension.getType(
          getPaymentMethod(data)?.cardType?.toUpperCase() ?? "",
          getPaymentMethod(data)?.type?.toUpperCase() ?? ""),
      paymentMethod: getPaymentMethod(data)?.type,
      cardType: getPaymentMethod(data)?.cardType,
      cardNickname: getPaymentMethod(data)?.nickName,
      cardNo: getPaymentMethod(data)?.cardNo,
      cancellationHeader: _getCancellationHeader(
          data.tourBookingDetail!.packageDetail?.inclusions?.highlights),
      confirmationDate: data.tourBookingDetail!.confirmationDate,
      informationViewModel: data.tourBookingDetail!.information == null
          ? null
          : TourBookingInformation.mapFromTourInformation(
              data.tourBookingDetail!.information,
              data.tourBookingDetail!.providerName,
            ),
      promotionData: data.promotionList != null
          ? List.generate(
              data.promotionList!.length,
              (index) => OtaFreeFoodPromotionModel(
                deepLinkUrl: data.promotionList![index].web ?? "",
                headerText: data.promotionList![index].title ?? "",
                subHeaderText: data.promotionList![index].description ?? "",
                headerIcon: data.promotionList![index].iconImage ?? "",
                promotionCode: data.promotionList![index].promotionCode ?? "",
                line1: data.promotionList![index].line1 ?? "",
              ),
            )
          : [],
      appliedPromo: (data.tourBookingDetail?.promotion == null ||
              data.tourBookingDetail?.priceDetails == null)
          ? null
          : PromoCodeData.mapForBookingDetails(
              PromoPriceViewModel.mapFromTourBookingDetails(
                  data.tourBookingDetail!.priceDetails!),
              PublicPromotion.mapFromTourBookingDetail(
                  data.tourBookingDetail!.promotion!),
              true,
              data.bookingUrn ?? "",
              data.tourBookingDetail!.tourId!,
              OtaServiceType.tour),
      walletPaymentDetails:
          TourBookingWalletPaymentDetails.getWalletFromPaymentDetails(
              getPaymentWalletMethod(data)),
      isCardPaymentAvailable: getPaymentMethod(data) != null,
    );
  }
  static PaymentDetails? getPaymentMethod(Data data) {
    List<PaymentDetails>? tourPaymentDetails =
        data.tourBookingDetail?.paymentDetails;
    PaymentDetails? paymentDetails;
    if (tourPaymentDetails != null && tourPaymentDetails.isNotEmpty) {
      for (PaymentDetails paymentDetail in tourPaymentDetails) {
        if (paymentDetail.type != _kVA) {
          paymentDetails = paymentDetail;
        }
      }
    }

    return paymentDetails;
  }

  static PaymentDetails? getPaymentWalletMethod(Data data) {
    if (data.tourBookingDetail != null &&
        data.tourBookingDetail!.paymentDetails != null &&
        data.tourBookingDetail!.paymentDetails!.isNotEmpty) {
      for (PaymentDetails item in data.tourBookingDetail!.paymentDetails!) {
        if (item.type == _kVA) {
          return item;
        }
      }
    }
    return null;
  }

  static double _getNetPrice(
      Promotion? promotion, PriceDetails? priceDetails, double netPrice) {
    if (promotion != null && priceDetails != null) {
      return priceDetails.billingAmount!;
    } else {
      return netPrice;
    }
  }

  static double _getTotalPrice(
      Promotion? promotion, PriceDetails? priceDetails, double totalPrice) {
    if (promotion != null && priceDetails != null) {
      return priceDetails.totalAmount ?? 0.0;
    } else {
      return totalPrice;
    }
  }

  static List<TourBookingDetailsParticipantsInfo>? _getParticipantsInfoDetails(
      List<ParticipantInfo>? participantInfo) {
    if (participantInfo != null && participantInfo.isNotEmpty) {
      return List.generate(
          participantInfo.length,
          (index) => TourBookingDetailsParticipantsInfo.mapFromParticipantInfo(
              participantInfo[index]));
    }
    return null;
  }

  static List<TourBookingDetailsHighlight>? _getHighlightsDetails(
      List<Highlight>? highlight) {
    if (highlight != null && highlight.isNotEmpty) {
      return List.generate(
        highlight.length,
        (index) =>
            TourBookingDetailsHighlight.mapFromHighLight(highlight[index]),
      );
    }
    return null;
  }

  static String? _getCancellationHeader(List<Highlight>? highlight) {
    List<TourBookingDetailsHighlight>? tourHighlight =
        _getHighlightsDetails(highlight);
    String? cancellationHeader;
    if (tourHighlight != null) {
      for (TourBookingDetailsHighlight highlight in tourHighlight) {
        if (highlight.key == kRefundType) {
          cancellationHeader = highlight.value;
        }
      }
    }
    return cancellationHeader;
  }
}

class TourBookingDetailsParticipantsInfo {
  String name;
  String surname;
  String? weight;
  String? dateOfBirth;
  String? passportNumber;
  String? passportCountry;
  String? passportCountryIssue;
  String? expiryDate;

  TourBookingDetailsParticipantsInfo({
    required this.name,
    required this.surname,
    this.weight,
    this.dateOfBirth,
    this.passportCountry,
    this.passportNumber,
    this.passportCountryIssue,
    this.expiryDate,
  });

  factory TourBookingDetailsParticipantsInfo.mapFromParticipantInfo(
          ParticipantInfo participantInfo) =>
      TourBookingDetailsParticipantsInfo(
        name: participantInfo.name!,
        surname: participantInfo.surname!,
        dateOfBirth:
            DateTime.tryParse(participantInfo.dateOfBirth ?? '') == null
                ? null
                : Helpers.getddMMyyyy(
                    DateTime.tryParse(participantInfo.dateOfBirth ?? '')!),
        expiryDate: DateTime.tryParse(participantInfo.expiryDate ?? '') == null
            ? null
            : Helpers.getddMMyyyy(
                DateTime.tryParse(participantInfo.expiryDate ?? '')!),
        passportCountry: participantInfo.passportCountry,
        passportCountryIssue: participantInfo.passportCountryIssue,
        passportNumber: participantInfo.passportNumber,
        weight: participantInfo.weight,
      );
}

class TourBookingInformation {
  String? description;
  String? conditions;
  String? howToUse;
  String? providerName;
  String? openTime;
  String? closeTime;

  TourBookingInformation({
    this.description,
    this.conditions,
    this.howToUse,
    this.closeTime,
    this.openTime,
    this.providerName,
  });

  factory TourBookingInformation.mapFromTourInformation(
          Information? information, String? providerName) =>
      TourBookingInformation(
        description: information?.description,
        conditions: information?.conditions,
        howToUse: information?.howToUse,
        providerName: providerName,
        openTime: information?.openTime,
        closeTime: information?.closeTime,
      );
}

class TourBookingDetailsHighlight {
  String? key;
  String? value;

  TourBookingDetailsHighlight({
    this.key,
    this.value,
  });

  factory TourBookingDetailsHighlight.mapFromHighLight(Highlight highlight) =>
      TourBookingDetailsHighlight(
        key: highlight.key,
        value: highlight.value,
      );
}

class TourBookingWalletPaymentDetails {
  String name;
  String amount;

  TourBookingWalletPaymentDetails({
    required this.name,
    required this.amount,
  });
  static TourBookingWalletPaymentDetails? getWalletFromPaymentDetails(
          PaymentDetails? paymentDetails) =>
      paymentDetails != null && paymentDetails.amount != null
          ? TourBookingWalletPaymentDetails(
              amount: paymentDetails.amount ?? '0',
              name: paymentDetails.name ?? '')
          : null;
}

enum TourAndTicketBookingStatus {
  bookingConfirmed,
  paymentPending,
  cancellationPending,
  bookingPending,
  bookingCancelled,
  unsuccessfulReservation,
  unsuccessfulPayment,
  bookingCompleted,
}

enum TourAndTicketBookingType {
  ongoingBooking,
  completedBooking,
  canceledBookings,
}

enum TourBookingDetailsPageStates {
  initial,
  loading,
  failure,
  success,
  internetFailure,
}
