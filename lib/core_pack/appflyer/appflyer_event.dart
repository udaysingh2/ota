class AppFlyerEvent {
  //car rental events
  static const String carDetailEvent = 'af_content_view_car';
  static const String carViewReservationEvent = 'af_basket_review_car';
  static const String carCancellationEvent = 'af_cancellation_car_request';
  static const String carClickReservationEvent = 'af_payment_review_car';
  static const String carClickPaymentEvent = 'af_initiated_checkout_car';
  static const String carFirstOrderPaymentSuccessEvent = 'af_first_order_car';
  static const String carPurchasePaymentSuccessEvent = 'af_purchase_car';

  //tour & activities
  static const String tourReservationEvent = 'af_basket_review_tour';
  static const String tourPaymentEvent = 'af_initiated_checkout_tour';
  static const String tourPaymentSuccessEvent = 'af_purchase_tour';
  static const String tourPaymentSuccessFirstBookingEvent =
      'af_first_order_tour';
  static const String tourDetailEvent = 'af_content_view_tour';
  static const String tourReservationClickEvent = 'af_payment_review_tour';
  static const String tourCancellationEvent = 'af_cancellation_tour_request';
  static const String ticketDetailEvent = 'af_content_view_ticket';
  static const String ticketReservationEvent = 'af_basket_review_ticket';
  static const String ticketPaymentEvent = 'af_initiated_checkout_ticket';
  static const String ticketPaymentSuccessEvent = 'af_purchase_ticket';
  static const String ticketReservationClickEvent = 'af_payment_review_ticket';
  static const String ticketCancellationEvent =
      'af_cancellation_ticket_request';
  static const String ticketPaymentSuccessFirstBookingEvent =
      'af_first_order_ticket';

  //hotels
  static const String hotelReservationEvent = 'af_basket_review_hotel';
  static const String hotelPaymentEvent = 'af_initiated_checkout_hotel';
  static const String hotelPaymentSuccessEvent = 'af_purchase_hotel';
  static const String hotelPaymentSuccessFirstBookingEvent =
      'af_first_order_hotel';
  static const String hotelLandingEvent = 'af_search_hotel';
  static const String hoteldetailViewEvent = 'af_content_view_hotel';
  static const String hoteldetailClickEvent = 'af_add_to_cart_hotel';
  static const String hotelPaymentInfoEvent = 'af_add_payment_info';
  static const String hotelcancellationRequestEvent =
      'af_cancellation_hotel_request';
  static const String promoAddEvent = 'af_promo_add';
  static const String hotelPaymentViewEvent = 'af_payment_review_hotel';
}
