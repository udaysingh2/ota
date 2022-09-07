
class SuggetionViewModel {
  String? headerText;
  String? ratingText;
  String? addressText;
  String? ratingTitle;
  String? reviewText;
  String? offerPercent;
  String? discount;
  String? imageUrl;
  String? adminPromotionLine1;
  String? adminPromotionLine2;
  String? hotelId;
  String? countryCode;
  String? cityId;
  List<String> amenitiesList;

  SuggetionViewModel({
    this.headerText,
    this.ratingText,
    this.addressText,
    this.ratingTitle,
    this.reviewText,
    this.offerPercent,
    this.discount,
    this.imageUrl,
    this.adminPromotionLine1,
    this.adminPromotionLine2,
    this.hotelId,
    this.cityId,
    this.countryCode,
    this.amenitiesList = const [],
  });
}
