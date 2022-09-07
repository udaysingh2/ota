import 'package:ota/domain/car_rental/car_rental_booking_detail/model/car_booking_detail_domain_model.dart'
    as car;
import 'package:ota/domain/hotel/hotel_booking_details/models/hotel_booking_detail_model_domain.dart'
    as hotel;
import 'package:ota/domain/promo_engine/apply_promo/models/apply_promo_model_domain.dart';
import 'package:ota/domain/tickets/ticket_booking_details/models/ticket_booking_details_model_domain.dart'
    as ticket;
import 'package:ota/domain/tours/tour_booking_detail/models/tours_booking_details_model_domain.dart'
    as tour;
import 'package:ota/modules/promo_engine/search_list/view_model/public_promo_view_model.dart';

class PromoCodeViewModel {
  PromoCodeScreenState state;
  PromoCodeData? promoCodeData;

  PromoCodeViewModel({
    required this.state,
    this.promoCodeData,
  });
}

class PromoPriceViewModel {
  double effectiveDiscount;
  double orderPrice;
  double addonPrice;
  double billingAmount;
  double totalAmount;

  PromoPriceViewModel(
      {required this.effectiveDiscount,
      required this.orderPrice,
      required this.addonPrice,
      required this.billingAmount,
      required this.totalAmount});

  factory PromoPriceViewModel.mapFromDomain(PriceDetails priceDetails) =>
      PromoPriceViewModel(
        effectiveDiscount: priceDetails.effectiveDiscount!,
        orderPrice: priceDetails.orderPrice!,
        addonPrice: priceDetails.addonPrice!,
        billingAmount: priceDetails.billingAmount!,
        totalAmount: priceDetails.totalAmount!,
      );
  factory PromoPriceViewModel.mapFromHotelBookingDetails(
          hotel.PromoPriceDetails priceDetails) =>
      PromoPriceViewModel(
        effectiveDiscount: priceDetails.effectiveDiscount!,
        orderPrice: priceDetails.orderPrice!,
        addonPrice: priceDetails.addonPrice!,
        billingAmount: priceDetails.billingAmount!,
        totalAmount: priceDetails.totalAmount!,
      );
  factory PromoPriceViewModel.mapFromTourBookingDetails(
          tour.PriceDetails priceDetails) =>
      PromoPriceViewModel(
        effectiveDiscount: priceDetails.effectiveDiscount!,
        orderPrice: priceDetails.orderPrice!,
        addonPrice: priceDetails.addonPrice!,
        billingAmount: priceDetails.billingAmount!,
        totalAmount: 0.0,
      );
  factory PromoPriceViewModel.mapFromTicketBookingDetails(
          ticket.PriceDetails priceDetails) =>
      PromoPriceViewModel(
        effectiveDiscount: priceDetails.effectiveDiscount!,
        orderPrice: priceDetails.orderPrice!,
        addonPrice: priceDetails.addonPrice!,
        billingAmount: priceDetails.billingAmount!,
        totalAmount: 0.0,
      );
  factory PromoPriceViewModel.mapFromCarBookingDetails(
          car.PromoPriceDetails priceDetails) =>
      PromoPriceViewModel(
        effectiveDiscount: priceDetails.effectiveDiscount!,
        orderPrice: priceDetails.orderPrice!,
        addonPrice: priceDetails.addonPrice!,
        billingAmount: priceDetails.billingAmount!,
        totalAmount: priceDetails.totalAmount!,
      );
}

class PromoCodeData {
  PublicPromotion promotion;
  PromoPriceViewModel? priceViewModel;
  bool isPromotionApplied;
  String bookingUrn;
  String merchantId;
  String applicationKey;

  PromoCodeData({
    required this.promotion,
    this.priceViewModel,
    required this.isPromotionApplied,
    required this.bookingUrn,
    required this.merchantId,
    required this.applicationKey,
  });

  factory PromoCodeData.from(
    PriceDetails priceDetails,
    PublicPromotion promotion,
    bool isPromotionApplied,
    String bookingUrn,
    String merchantId,
    String applicationKey,
  ) =>
      PromoCodeData(
        isPromotionApplied: isPromotionApplied,
        promotion: promotion,
        priceViewModel: PromoPriceViewModel.mapFromDomain(priceDetails),
        bookingUrn: bookingUrn,
        merchantId: merchantId,
        applicationKey: applicationKey,
      );

  factory PromoCodeData.mapForBookingDetails(
    PromoPriceViewModel priceDetails,
    PublicPromotion promotion,
    bool isPromotionApplied,
    String bookingUrn,
    String merchantId,
    String applicationKey,
  ) =>
      PromoCodeData(
        isPromotionApplied: isPromotionApplied,
        promotion: promotion,
        priceViewModel: priceDetails,
        bookingUrn: bookingUrn,
        merchantId: merchantId,
        applicationKey: applicationKey,
      );
}

enum PromoCodeScreenState {
  none,
  loading,
  failure,
  success,
  internetFailure,
  failure1899,
  failure1999,
  failure3023,
  failure3024,
  failure3025,
  failure3028,
  failure3033,
  failure3034,
  failure3054,
  failure3068,
  removeSuccess,
  removeFailure,
}
