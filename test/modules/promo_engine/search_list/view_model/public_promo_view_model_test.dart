import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/promo_engine/promo_search/models/promo_code_search_model_domain.dart';
import 'package:ota/domain/promo_engine/public_promo/models/public_promotion_model_domain.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/public_promo_view_model.dart';
import 'package:ota/domain/hotel/hotel_booking_details/models/hotel_booking_detail_model_domain.dart'
    as hotel;
import 'package:ota/domain/car_rental/car_rental_booking_detail/model/car_booking_detail_domain_model.dart'
    as car;
import 'package:ota/domain/tours/tour_booking_detail/models/tours_booking_details_model_domain.dart'
    as tour;
import 'package:ota/domain/tickets/ticket_booking_details/models/ticket_booking_details_model_domain.dart'
    as ticket;

void main() {
  PromotionList promotionListMap = PromotionList(
      promotionId: 1,
      promotionName: 'promotionName',
      shortDescription: 'shortDescription',
      discount: 0,
      maximumDiscount: 0,
      discountType: 'discountType',
      discountFor: 'discountFor',
      promotionLink: 'promotionLink',
      promotionType: 'promotionType',
      iconUrl: 'iconUrl',
      voucherCode: 'voucherCode',
      promotionCode: 'promotionCode',
      startDate: 'startDate',
      endDate: 'endDate',
      applicationKey: 'applicationKey');
  PromoCodeData promoCodeData = PromoCodeData(
      promotionId: 1,
      promotionName: 'promotionName',
      shortDescription: 'shortDescription',
      discount: 0,
      maximumDiscount: 0,
      discountType: 'discountType',
      discountFor: 'discountFor',
      promotionLink: 'promotionLink',
      promotionType: 'promotionType',
      iconUrl: 'iconUrl',
      voucherCode: 'voucherCode',
      promotionCode: 'promotionCode',
      startDate: 'startDate',
      endDate: 'endDate',
      applicationKey: 'applicationKey');
  car.Promotion carPromotion = car.Promotion(
      promotionId: 1,
      promotionName: 'promotionName',
      shortDescription: 'shortDescription',
      discount: 0,
      maximumDiscount: 0,
      discountType: 'discountType',
      discountFor: 'discountFor',
      promotionLink: 'promotionLink',
      promotionType: 'promotionType',
      iconUrl: 'iconUrl',
      voucherCode: 'voucherCode',
      promotionCode: 'promotionCode',
      startDate: 'startDate',
      endDate: 'endDate',
      applicationKey: 'applicationKey');
  hotel.Promotion hotelPromotion = hotel.Promotion(
      promotionId: 1,
      promotionName: 'promotionName',
      shortDescription: 'shortDescription',
      discount: 0,
      maximumDiscount: 0,
      discountType: 'discountType',
      discountFor: 'discountFor',
      promotionLink: 'promotionLink',
      promotionType: 'promotionType',
      iconUrl: 'iconUrl',
      voucherCode: 'voucherCode',
      promotionCode: 'promotionCode',
      startDate: 'startDate',
      endDate: 'endDate',
      applicationKey: 'applicationKey');
  tour.Promotion tourPromotion = tour.Promotion(
      promotionId: 1,
      promotionName: 'promotionName',
      shortDescription: 'shortDescription',
      discount: 0,
      maximumDiscount: 0,
      discountType: 'discountType',
      discountFor: 'discountFor',
      promotionLink: 'promotionLink',
      promotionType: 'promotionType',
      iconUrl: 'iconUrl',
      voucherCode: 'voucherCode',
      promotionCode: 'promotionCode',
      startDate: 'startDate',
      endDate: 'endDate',
      applicationKey: 'applicationKey');
  ticket.Promotion ticketPromotion = ticket.Promotion(
      promotionId: 1,
      promotionName: 'promotionName',
      shortDescription: 'shortDescription',
      discount: 0,
      maximumDiscount: 0,
      discountType: 'discountType',
      discountFor: 'discountFor',
      promotionLink: 'promotionLink',
      promotionType: 'promotionType',
      iconUrl: 'iconUrl',
      voucherCode: 'voucherCode',
      promotionCode: 'promotionCode',
      startDate: 'startDate',
      endDate: 'endDate',
      applicationKey: 'applicationKey');

  test("Public Promo View Model Test", () {
    PublicPromotion publicPromotion = PublicPromotion(
        promotionId: 1,
        promotionName: 'promotionName',
        shortDescription: 'shortDescription',
        discount: 0,
        maximumDiscount: 0,
        discountType: 'discountType',
        discountFor: 'discountFor',
        promotionLink: 'promotionLink',
        promotionType: 'promotionType',
        iconUrl: 'iconUrl',
        voucherCode: 'voucherCode',
        promotionCode: 'promotionCode',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        applicationKey: 'applicationKey');
    PublicPromotionViewModel publicPromotionViewModel =
        PublicPromotionViewModel(
            state: PublicPromotionScreenState.searchSuccess,
            promotionList: [publicPromotion]);
    PublicPromotion.formModel(promotionListMap);
    PublicPromotion.mapFromLandingModelData(promoCodeData);
    PublicPromotion.mapFromCarBookingDetail(carPromotion);
    PublicPromotion.mapFromHotelBookingDetail(hotelPromotion);
    PublicPromotion.mapFromTourBookingDetail(tourPromotion);
    PublicPromotion.mapFromTicketBookingDetail(ticketPromotion);
    publicPromotion.toPromoDetailsModel('merchantId');
    PublicPromotionPagination.fromPagination(Pagination(
        currentPage: 1, hasNextPage: true, hasPreviousPage: true, pageSize: 2));
    expect(publicPromotionViewModel.state,
        PublicPromotionScreenState.searchSuccess);
    expect(publicPromotionViewModel.promotionList, [publicPromotion]);
  });
}
