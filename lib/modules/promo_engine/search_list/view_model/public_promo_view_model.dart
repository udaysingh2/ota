import 'package:ota/domain/hotel/hotel_booking_details/models/hotel_booking_detail_model_domain.dart'
    as hotel;
import 'package:ota/domain/car_rental/car_rental_booking_detail/model/car_booking_detail_domain_model.dart'
    as car;
import 'package:ota/domain/tours/tour_booking_detail/models/tours_booking_details_model_domain.dart'
    as tour;
import 'package:ota/domain/tickets/ticket_booking_details/models/ticket_booking_details_model_domain.dart'
    as ticket;
import 'package:ota/domain/promo_engine/apply_promo/models/apply_promo_argument_domain.dart';
import 'package:ota/domain/promo_engine/promo_search/models/promo_code_search_model_domain.dart';
import 'package:ota/domain/promo_engine/public_promo/models/public_promotion_model_domain.dart';

class PublicPromotionViewModel {
  PublicPromotionScreenState state;
  List<PublicPromotion>? promotionList;
  PublicPromotionPagination? pagination;
  PublicPromotion? searchedPromotionCode;

  PublicPromotionViewModel({
    required this.state,
    this.promotionList,
    this.pagination,
    this.searchedPromotionCode,
  });
}

class PublicPromotion {
  final int promotionId;
  final String promotionName;
  final String shortDescription;
  final double discount;
  final double? maximumDiscount;
  final String discountType;
  final String discountFor;
  final String promotionLink;
  final String promotionType;
  final String? iconUrl;
  final String voucherCode;
  final String promotionCode;
  final DateTime startDate;
  final DateTime endDate;
  final String applicationKey;

  PublicPromotion({
    required this.promotionId,
    required this.promotionName,
    required this.shortDescription,
    required this.discount,
    this.maximumDiscount,
    required this.discountType,
    required this.discountFor,
    required this.promotionLink,
    required this.promotionType,
    this.iconUrl,
    required this.voucherCode,
    required this.promotionCode,
    required this.startDate,
    required this.endDate,
    required this.applicationKey,
  });

  PromotionDetailsModel toPromoDetailsModel(String merchantId) {
    return PromotionDetailsModel(
      promotionId: promotionId,
      promotionName: promotionName,
      shortDescription: shortDescription,
      merchantId: merchantId,
      discount: discount,
      discountType: discountType,
      discountFor: discountFor,
      promotionLink: promotionLink,
      promotionType: promotionType,
      voucherCode: voucherCode,
      promotionCode: promotionCode,
      startDate: startDate,
      endDate: endDate,
      applicationKey: applicationKey,
      maximumDiscount: maximumDiscount ?? 0.0,
      iconUrl: iconUrl ?? '',
    );
  }

  factory PublicPromotion.formModel(PromotionList promotion) => PublicPromotion(
        promotionId: promotion.promotionId!,
        promotionName: promotion.promotionName!,
        shortDescription: promotion.shortDescription!,
        discount: promotion.discount!,
        discountType: promotion.discountType!,
        discountFor: promotion.discountFor!,
        promotionLink: promotion.promotionLink!,
        promotionType: promotion.promotionType!,
        voucherCode: promotion.voucherCode!,
        promotionCode: promotion.promotionCode!,
        startDate: DateTime.tryParse(promotion.startDate!) ?? DateTime.now(),
        endDate: DateTime.tryParse(promotion.endDate!) ?? DateTime.now(),
        applicationKey: promotion.applicationKey!,
        maximumDiscount: promotion.maximumDiscount,
        iconUrl: promotion.iconUrl,
      );

  factory PublicPromotion.mapFromLandingModelData(PromoCodeData data) {
    return PublicPromotion(
      promotionId: data.promotionId!,
      promotionName: data.promotionName!,
      shortDescription: data.shortDescription!,
      discount: data.discount!,
      maximumDiscount: data.maximumDiscount ?? 0,
      discountType: data.discountType!,
      discountFor: data.discountFor!,
      promotionLink: data.promotionLink!,
      promotionType: data.promotionType!,
      iconUrl: data.iconUrl,
      voucherCode: data.voucherCode!,
      promotionCode: data.promotionCode!,
      startDate: DateTime.tryParse(data.startDate ?? '') ?? DateTime.now(),
      endDate: DateTime.tryParse(data.endDate ?? '') ?? DateTime.now(),
      applicationKey: data.applicationKey!,
    );
  }

  factory PublicPromotion.mapFromHotelBookingDetail(hotel.Promotion promotion) {
    return PublicPromotion(
      promotionId: promotion.promotionId!,
      promotionName: promotion.promotionName!,
      shortDescription: promotion.shortDescription!,
      discount: promotion.discount!,
      discountType: promotion.discountType!,
      discountFor: promotion.discountFor!,
      promotionLink: promotion.promotionLink!,
      promotionType: promotion.promotionType!,
      voucherCode: promotion.voucherCode!,
      promotionCode: promotion.promotionCode!,
      startDate: DateTime.tryParse(promotion.startDate!) ?? DateTime.now(),
      endDate: DateTime.tryParse(promotion.endDate!) ?? DateTime.now(),
      applicationKey: promotion.applicationKey!,
      maximumDiscount: promotion.maximumDiscount,
      iconUrl: promotion.iconUrl,
    );
  }

  factory PublicPromotion.mapFromCarBookingDetail(car.Promotion promotion) {
    return PublicPromotion(
      promotionId: promotion.promotionId!,
      promotionName: promotion.promotionName!,
      shortDescription: promotion.shortDescription!,
      discount: promotion.discount!,
      discountType: promotion.discountType!,
      discountFor: promotion.discountFor!,
      promotionLink: promotion.promotionLink!,
      promotionType: promotion.promotionType!,
      voucherCode: promotion.voucherCode!,
      promotionCode: promotion.promotionCode!,
      startDate: DateTime.tryParse(promotion.startDate!) ?? DateTime.now(),
      endDate: DateTime.tryParse(promotion.endDate!) ?? DateTime.now(),
      applicationKey: promotion.applicationKey!,
      maximumDiscount: promotion.maximumDiscount,
      iconUrl: promotion.iconUrl,
    );
  }
  factory PublicPromotion.mapFromTourBookingDetail(tour.Promotion promotion) {
    return PublicPromotion(
      promotionId: promotion.promotionId!,
      promotionName: promotion.promotionName!,
      shortDescription: promotion.shortDescription!,
      discount: promotion.discount!,
      discountType: promotion.discountType!,
      discountFor: promotion.discountFor!,
      promotionLink: promotion.promotionLink!,
      promotionType: promotion.promotionType!,
      voucherCode: promotion.voucherCode!,
      promotionCode: promotion.promotionCode!,
      startDate: DateTime.tryParse(promotion.startDate!) ?? DateTime.now(),
      endDate: DateTime.tryParse(promotion.endDate!) ?? DateTime.now(),
      applicationKey: promotion.applicationKey!,
      maximumDiscount: promotion.maximumDiscount,
      iconUrl: promotion.iconUrl,
    );
  }
  factory PublicPromotion.mapFromTicketBookingDetail(
      ticket.Promotion promotion) {
    return PublicPromotion(
      promotionId: promotion.promotionId!,
      promotionName: promotion.promotionName!,
      shortDescription: promotion.shortDescription!,
      discount: promotion.discount!,
      discountType: promotion.discountType!,
      discountFor: promotion.discountFor!,
      promotionLink: promotion.promotionLink!,
      promotionType: promotion.promotionType!,
      voucherCode: promotion.voucherCode!,
      promotionCode: promotion.promotionCode!,
      startDate: DateTime.tryParse(promotion.startDate!) ?? DateTime.now(),
      endDate: DateTime.tryParse(promotion.endDate!) ?? DateTime.now(),
      applicationKey: promotion.applicationKey!,
      maximumDiscount: promotion.maximumDiscount,
      iconUrl: promotion.iconUrl,
    );
  }
}

class PublicPromotionPagination {
  int? currentPage;
  int? pageSize;
  bool hasNext;
  bool hasPrevious;

  PublicPromotionPagination({
    this.currentPage,
    this.pageSize,
    this.hasNext = false,
    this.hasPrevious = false,
  });

  factory PublicPromotionPagination.fromPagination(Pagination pagination) =>
      PublicPromotionPagination(
        currentPage: pagination.currentPage,
        pageSize: pagination.pageSize,
        hasNext: pagination.hasNextPage ?? false,
        hasPrevious: pagination.hasPreviousPage ?? false,
      );
}

enum PublicPromotionScreenState {
  none,
  loading,
  empty,
  failure,
  success,
  internetFailure,
  searchEmptyListLoading,
  searchSuccessLoading,
  searchListLoading,
  searchFailureLoading,
  searchInternetFailure,
  searchEmptyListInternetFailure,
  searchErrorInternetFailure,
  searchSuccessInternetFailure,
  searchSuccess,
  searchFailure,
}
