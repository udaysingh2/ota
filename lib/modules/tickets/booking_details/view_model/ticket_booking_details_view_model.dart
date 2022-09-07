import 'package:ota/common/utils/helper.dart';
import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import 'package:ota/domain/tickets/ticket_booking_details/models/ticket_booking_details_model_domain.dart';
import 'package:ota/modules/hotel/hotel_detail/helpers/facility_helper.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_type.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/promo_code_view_model.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/public_promo_view_model.dart';
import 'package:ota/modules/tickets/booking_details/view_model/ticket_booking_detail_argument.dart';
import 'package:ota/modules/tickets/booking_details/view_model/ticket_booking_package_detail_view_model.dart';
import 'package:ota/modules/tours/booking_details/helper/tour_booking_detail_helper.dart';
import 'package:ota/modules/tours/booking_details/view_model/tour_booking_details_view_model.dart';

const double _kDefaultAmount = 0.0;
const String _kVA = "VA";

class TicketBookingDetailsViewModel {
  TicketBookingDetailsPageStates pageState;
  TicketBookingDetailsData? data;
  TicketBookingPackageDetailViewModel? packageDetail;
  TicketBookingDetailArgument? argument;

  TicketBookingDetailsViewModel({
    required this.pageState,
    this.data,
    this.packageDetail,
    this.argument,
  });
}

class TicketBookingDetailsData {
  TourAndTicketBookingStatus ticketBookingStatus;
  TourAndTicketBookingType ticketBookingType;
  String bookingType;
  String activityStatus;
  String countryId;
  String ticketId;
  String cityId;
  String bookingStatus;
  String name;
  double netPrice;
  double discount;
  double totalPrice;
  List<TicketBookingDetailsTicketTypeInfo> ticketTypes;
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
  String? noOfDays;
  String? duration;
  String? cancellationPolicy;
  String? meetingPoint;
  List<TicketBookingDetailsHighlight>? highlights;
  List<TicketBookingDetailsParticipantsInfo>? participantsInfo;
  String? providerName;
  String? supplierContact;
  String? paymentStatus;
  PaymentMethodType? paymentType;
  String? paymentMethod;
  String? cardType;
  String? cardNickname;
  String? cardNo;
  String? cancellationHeader;
  String? confirmationDate;
  TicketBookingInformation? information;
  List<OtaFreeFoodPromotionModel> promotionData;
  PromoCodeData? appliedPromo;
  TicketBookingWalletPaymentDetails? walletPaymentDetails;
  bool isCardPaymentAvailable;

  TicketBookingDetailsData({
    required this.ticketBookingStatus,
    required this.ticketBookingType,
    required this.bookingType,
    required this.activityStatus,
    required this.bookingStatus,
    required this.name,
    required this.ticketTypes,
    required this.netPrice,
    required this.discount,
    required this.totalPrice,
    required this.ticketId,
    required this.cityId,
    required this.countryId,
    this.bookingUrn,
    this.orderId,
    this.bookingId,
    this.bookingDate,
    this.imageUrl,
    this.category,
    this.cancellationDate,
    this.cancellationCharge,
    this.cancellationReason,
    this.totalRefundAmount,
    this.location,
    this.packageName,
    this.noOfDays,
    this.duration,
    this.cancellationPolicy,
    this.meetingPoint,
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
    this.information,
    this.appliedPromo,
    required this.promotionData,
    this.walletPaymentDetails,
    required this.isCardPaymentAvailable,
  });

  factory TicketBookingDetailsData.fromDomain(
      Data data, TicketBookingDetailArgument argument) {
    return TicketBookingDetailsData(
      bookingStatus: data.bookingStatus!,
      activityStatus: data.activityStatus ?? '',
      cityId: data.ticketBookingDetail!.cityId!,
      countryId: data.ticketBookingDetail!.countryId!,
      ticketId: data.ticketBookingDetail!.ticketId!,
      name: data.ticketBookingDetail!.name!,
      ticketBookingStatus: TourAndTicketBookingDetailHelper.getBookingStatus(
          data.bookingStatus!,
          data.activityStatus,
          data.ticketBookingDetail?.bookingDate),
      ticketBookingType: TourAndTicketBookingDetailHelper.getBookingTypeValue(
          data.bookingStatus!, data.ticketBookingDetail!.bookingDate),
      bookingUrn: data.bookingUrn,
      bookingType: data.bookingType!,
      netPrice: _getNetPrice(
          data.ticketBookingDetail!.promotion,
          data.ticketBookingDetail!.priceDetails,
          data.ticketBookingDetail!.netPrice!),
      totalPrice: _getTotalPrice(
          data.ticketBookingDetail!.promotion,
          data.ticketBookingDetail!.priceDetails,
          data.ticketBookingDetail!.totalPrice!),
      discount: data.ticketBookingDetail!.discount ?? _kDefaultAmount,
      cancellationDate: Helpers.getddMMMyy(
          DateTime.tryParse(data.ticketBookingDetail!.cancellationDate ?? '') ??
              DateTime.now()),
      cancellationReason: data.ticketBookingDetail!.cancellationReason,
      cancellationCharge: data.ticketBookingDetail!.cancellationCharge,
      totalRefundAmount:
          ((data.ticketBookingDetail!.totalRefundAmount ?? 0) >= 0
              ? data.ticketBookingDetail!.totalRefundAmount
              : 0),
      orderId: data.orderId,
      bookingId: data.bookingId,
      imageUrl: data.ticketBookingDetail!.imageUrl,
      location: data.ticketBookingDetail!.location,
      category: data.ticketBookingDetail!.category,
      bookingDate: data.ticketBookingDetail!.bookingDate,
      ticketTypes:
          _getTicketTypeDetails(data.ticketBookingDetail!.ticketTypes!),
      packageName: data.ticketBookingDetail!.packageDetail?.packageName,
      noOfDays: data.ticketBookingDetail!.noOfDays,
      duration: data.ticketBookingDetail!.packageDetail?.durationText,
      cancellationPolicy:
          data.ticketBookingDetail!.packageDetail?.cancellationPolicy,
      meetingPoint: data.ticketBookingDetail!.packageDetail?.meetingPoint,
      highlights: _getHighlightsDetails(
          data.ticketBookingDetail!.packageDetail?.inclusions?.highlights),
      participantsInfo: _getParticipantsInfoDetails(
          data.ticketBookingDetail!.participantInfo),
      providerName: data.ticketBookingDetail!.providerName,
      supplierContact: data.ticketBookingDetail!.supplierContact,
      paymentStatus: data.ticketBookingDetail!.paymentStatus,
      paymentType: PaymentMethodExtension.getType(
          getPaymentMethod(data)?.cardType?.toUpperCase() ?? "",
          getPaymentMethod(data)?.type?.toUpperCase() ?? ""),
      paymentMethod: getPaymentMethod(data)?.type,
      cardType: getPaymentMethod(data)?.cardType,
      cardNickname: getPaymentMethod(data)?.cardNickName,
      cardNo: getPaymentMethod(data)?.cardNo,
      cancellationHeader: _getCancellationHeader(
          data.ticketBookingDetail!.packageDetail?.inclusions?.highlights),
      confirmationDate: data.ticketBookingDetail!.confirmationDate,
      information: data.ticketBookingDetail!.information == null
          ? null
          : TicketBookingInformation.mapFromTourInformation(
              data.ticketBookingDetail!.information,
              data.ticketBookingDetail!.providerName,
            ),
      promotionData: generatePromotion(data.promotionList),
      appliedPromo: (data.ticketBookingDetail?.promotion == null ||
              data.ticketBookingDetail?.priceDetails == null)
          ? null
          : PromoCodeData.mapForBookingDetails(
              PromoPriceViewModel.mapFromTicketBookingDetails(
                  data.ticketBookingDetail!.priceDetails!),
              PublicPromotion.mapFromTicketBookingDetail(
                  data.ticketBookingDetail!.promotion!),
              true,
              data.bookingUrn ?? "",
              data.ticketBookingDetail!.ticketId!,
              OtaServiceType.ticket),
      walletPaymentDetails:
          TicketBookingWalletPaymentDetails.getWalletFromPaymentDetails(
              getPaymentWalletMethod(data)),
      isCardPaymentAvailable: getPaymentMethod(data) != null,
    );
  }
  static PaymentDetails? getPaymentMethod(Data data) {
    List<PaymentDetails>? ticketPaymentDetails =
        data.ticketBookingDetail?.paymentDetails;
    PaymentDetails? paymentDetails;
    if (ticketPaymentDetails != null && ticketPaymentDetails.isNotEmpty) {
      for (PaymentDetails paymentDetail in ticketPaymentDetails) {
        if (paymentDetail.type != _kVA) {
          paymentDetails = paymentDetail;
        }
      }
    }

    return paymentDetails;
  }

  static PaymentDetails? getPaymentWalletMethod(Data data) {
    if (data.ticketBookingDetail != null &&
        data.ticketBookingDetail!.paymentDetails != null &&
        data.ticketBookingDetail!.paymentDetails!.isNotEmpty) {
      for (PaymentDetails item in data.ticketBookingDetail!.paymentDetails!) {
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

  static List<OtaFreeFoodPromotionModel> generatePromotion(
      List<TicketBookingDetailPromotionList>? promotions) {
    List<OtaFreeFoodPromotionModel> freeFoodPromotionList = [];
    if (promotions == null || promotions.isEmpty) {
      return freeFoodPromotionList;
    }
    for (int i = 0; i < promotions.length; i++) {
      freeFoodPromotionList.add(OtaFreeFoodPromotionModel(
        headerText: promotions[i].title ?? "",
        subHeaderText: promotions[i].description ?? "",
        headerIcon: promotions[i].iconImage ?? "",
        deepLinkUrl: promotions[i].web ?? "",
        line1: promotions[i].line1 ?? "",
      ));
    }
    return freeFoodPromotionList;
  }

  static double _getTotalPrice(
      Promotion? promotion, PriceDetails? priceDetails, double totalPrice) {
    if (promotion != null && priceDetails != null) {
      return priceDetails.totalAmount!;
    } else {
      return totalPrice;
    }
  }

  static List<TicketBookingDetailsTicketTypeInfo> _getTicketTypeDetails(
      List<TicketType> ticketTypes) {
    return List.generate(
      ticketTypes.length,
      (index) => TicketBookingDetailsTicketTypeInfo.mapfromTicketType(
          ticketTypes[index]),
    );
  }

  static List<TicketBookingDetailsParticipantsInfo>?
      _getParticipantsInfoDetails(List<ParticipantInfo>? participantInfo) {
    if (participantInfo != null && participantInfo.isNotEmpty) {
      return List.generate(
          participantInfo.length,
          (index) =>
              TicketBookingDetailsParticipantsInfo.mapFromParticipantInfo(
                  participantInfo[index]));
    }
    return null;
  }

  static List<TicketBookingDetailsHighlight>? _getHighlightsDetails(
      List<Highlight>? highlight) {
    if (highlight != null && highlight.isNotEmpty) {
      return List.generate(
        highlight.length,
        (index) =>
            TicketBookingDetailsHighlight.mapFromHighlight(highlight[index]),
      );
    }
    return null;
  }

  static String? _getCancellationHeader(List<Highlight>? highlight) {
    List<TicketBookingDetailsHighlight>? tourHighlight =
        _getHighlightsDetails(highlight);
    String? cancellationHeader;
    if (tourHighlight != null) {
      for (TicketBookingDetailsHighlight highlight in tourHighlight) {
        if (highlight.key == kRefundType) {
          cancellationHeader = highlight.value;
        }
      }
    }
    return cancellationHeader;
  }
}

class TicketBookingDetailsTicketTypeInfo {
  final String paxId;
  final String name;
  final double price;
  final int noOfTickets;

  TicketBookingDetailsTicketTypeInfo({
    required this.paxId,
    required this.name,
    required this.price,
    required this.noOfTickets,
  });

  factory TicketBookingDetailsTicketTypeInfo.mapfromTicketType(
          TicketType ticketType) =>
      TicketBookingDetailsTicketTypeInfo(
        paxId: ticketType.paxId ?? '',
        name: ticketType.name!,
        price: ticketType.price ?? _kDefaultAmount,
        noOfTickets: ticketType.noOfTickets ?? 0,
      );
}

class TicketBookingDetailsParticipantsInfo {
  String name;
  String surname;
  String? weight;
  String? dateOfBirth;
  String? passportNumber;
  String? passportCountry;
  String? passportCountryIssue;
  String? expiryDate;

  TicketBookingDetailsParticipantsInfo({
    required this.name,
    required this.surname,
    this.weight,
    this.dateOfBirth,
    this.passportCountry,
    this.passportNumber,
    this.passportCountryIssue,
    this.expiryDate,
  });

  factory TicketBookingDetailsParticipantsInfo.mapFromParticipantInfo(
          ParticipantInfo participantInfo) =>
      TicketBookingDetailsParticipantsInfo(
        name: participantInfo.name!,
        surname: participantInfo.surname!,
        weight: participantInfo.weight,
        passportCountry: participantInfo.passportCountry,
        passportNumber: participantInfo.passportNumber,
        passportCountryIssue: participantInfo.passportCountryIssue,
        dateOfBirth:
            DateTime.tryParse(participantInfo.dateOfBirth ?? '') == null
                ? null
                : Helpers.getddMMyyyy(
                    DateTime.tryParse(participantInfo.dateOfBirth ?? '')!),
        expiryDate: DateTime.tryParse(participantInfo.expiryDate ?? '') == null
            ? null
            : Helpers.getddMMyyyy(
                DateTime.tryParse(participantInfo.expiryDate ?? '')!),
      );
}

class TicketBookingInformation {
  String? description;
  String? conditions;
  String? howToUse;
  String? providerName;
  String? openTime;
  String? closeTime;

  TicketBookingInformation({
    this.description,
    this.conditions,
    this.howToUse,
    this.closeTime,
    this.openTime,
    this.providerName,
  });

  factory TicketBookingInformation.mapFromTourInformation(
          Information? information, String? providerName) =>
      TicketBookingInformation(
        description: information?.description,
        conditions: information?.conditions,
        howToUse: information?.howToUse,
        providerName: providerName,
        openTime: information?.openTime,
        closeTime: information?.closeTime,
      );
}

class TicketBookingDetailsHighlight {
  String? key;
  String? value;

  TicketBookingDetailsHighlight({
    this.key,
    this.value,
  });

  factory TicketBookingDetailsHighlight.mapFromHighlight(Highlight highlight) =>
      TicketBookingDetailsHighlight(
        key: highlight.key,
        value: highlight.value,
      );
}

class TicketBookingWalletPaymentDetails {
  String name;
  String amount;

  TicketBookingWalletPaymentDetails({
    required this.name,
    required this.amount,
  });
  static TicketBookingWalletPaymentDetails? getWalletFromPaymentDetails(
          PaymentDetails? paymentDetails) =>
      paymentDetails != null && paymentDetails.amount != null
          ? TicketBookingWalletPaymentDetails(
              amount: paymentDetails.amount ?? '0',
              name: paymentDetails.name ?? '')
          : null;
}

enum TicketBookingDetailsPageStates {
  initial,
  loading,
  failure,
  success,
  internetFailure,
}
