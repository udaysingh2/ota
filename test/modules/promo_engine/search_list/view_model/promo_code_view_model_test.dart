import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/promo_engine/apply_promo/models/apply_promo_model_domain.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/promo_code_view_model.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/public_promo_view_model.dart';
import 'package:ota/domain/car_rental/car_rental_booking_detail/model/car_booking_detail_domain_model.dart'
    as car;
import 'package:ota/domain/hotel/hotel_booking_details/models/hotel_booking_detail_model_domain.dart'
    as hotel;

import 'package:ota/domain/tickets/ticket_booking_details/models/ticket_booking_details_model_domain.dart'
    as ticket;
import 'package:ota/domain/tours/tour_booking_detail/models/tours_booking_details_model_domain.dart'
    as tour;

void main() {
  tour.PriceDetails tourPrices = tour.PriceDetails(
      addonPrice: 22,
      billingAmount: 220,
      effectiveDiscount: 20,
      orderPrice: 200,
      totalAmount: 400);
  ticket.PriceDetails ticketPrices = ticket.PriceDetails(
      addonPrice: 22,
      billingAmount: 220,
      effectiveDiscount: 20,
      orderPrice: 200,
      totalAmount: 400);
  hotel.PromoPriceDetails hotelPrices = hotel.PromoPriceDetails(
      addonPrice: 22,
      billingAmount: 220,
      effectiveDiscount: 20,
      orderPrice: 200,
      totalAmount: 400);
  car.PromoPriceDetails carPrices = car.PromoPriceDetails(
      addonPrice: 22,
      billingAmount: 220,
      effectiveDiscount: 20,
      orderPrice: 200,
      totalAmount: 400);
  test("Promo Code View Model Test", () {
    PublicPromotion publicPromotion = PublicPromotion(
        promotionId: 1,
        promotionName: '',
        shortDescription: '',
        discount: 0,
        maximumDiscount: 0,
        discountType: '',
        discountFor: '',
        promotionLink: '',
        promotionType: '',
        iconUrl: '',
        voucherCode: '',
        promotionCode: '',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        applicationKey: '');
    PromoPriceViewModel promoPriceViewModel = PromoPriceViewModel(
        addonPrice: 22,
        billingAmount: 40,
        orderPrice: 24,
        effectiveDiscount: 25,
        totalAmount: 100);
    PriceDetails priceDetailsMap = PriceDetails(
        addonPrice: 22.4,
        billingAmount: 23.3,
        effectiveDiscount: 22.2,
        orderPrice: 23,
        totalAmount: 25);
    PromoCodeData promoCodeData = PromoCodeData(
        applicationKey: 'HOTEL',
        bookingUrn: 'bookingUrn',
        isPromotionApplied: true,
        merchantId: 'merchantId',
        promotion: publicPromotion,
        priceViewModel: promoPriceViewModel);
    PromoPriceViewModel.mapFromDomain(priceDetailsMap);
    PromoPriceViewModel.mapFromCarBookingDetails(carPrices);
    PromoPriceViewModel.mapFromHotelBookingDetails(hotelPrices);
    PromoPriceViewModel.mapFromTicketBookingDetails(ticketPrices);
    PromoPriceViewModel.mapFromTourBookingDetails(tourPrices);

    final data = PromoCodeData.mapForBookingDetails(promoPriceViewModel,
        publicPromotion, true, 'bookingUrn', 'merchantId', 'applicationKey');
    PromoCodeViewModel promoCodeViewModel = PromoCodeViewModel(
        state: PromoCodeScreenState.success, promoCodeData: data);
    final dataFromPromoCodeData = PromoCodeData.from(priceDetailsMap,
        publicPromotion, true, 'bookingUrn', 'merchantId', 'applicationKey');
    expect(promoCodeData.applicationKey, 'HOTEL');
    expect(promoCodeViewModel.promoCodeData, data);
    expect(dataFromPromoCodeData.bookingUrn, 'bookingUrn');
  });
}
