import '../../../../domain/hotel_playlist/hotel_dynamic_playlist/models/hotel_dynamic_playlist_model_domain.dart';
import '../helpers/hotel_landing_helper.dart';

class HotelRecentPlayListViewModel {
  List<HotelRecentPlayListModel> playList;
  String playListName;

  HotelRecentPlayListViewModel({
    this.playList = const [],
    this.playListName = '',
  });
  factory HotelRecentPlayListViewModel.fromList(GetRecentViewPlaylist list) {
    return HotelRecentPlayListViewModel(
      playListName: list.listType ?? '',
    );
  }
}

class HotelRecentPlayListModel {
  String hotelId;
  String cityId;
  String countryId;
  String rating;
  String hotelName;
  String image;
  String locationName;
  List<HotelRecentPromotionList> promotionList;
  String adminPromotionLine1;
  String adminPromotionLine2;
  List<String> ammenitiesList;
  HotelRecentPlayListModel({
    this.hotelId = "",
    this.cityId = "",
    this.countryId = "",
    this.rating = "",
    this.hotelName = "",
    this.image = "",
    this.locationName = "",
    this.adminPromotionLine1 = '',
    this.adminPromotionLine2 = '',
    this.ammenitiesList = const [],
    this.promotionList = const [],
  });

  factory HotelRecentPlayListModel.fromList(RecentViewPlaylist list) {
    return HotelRecentPlayListModel(
      hotelName: list.hotelName ?? '',
      hotelId: list.hotelId ?? '',
      cityId: list.cityId ?? '',
      countryId: list.countryId ?? '',
      image: list.image ?? '',
      locationName: list.locationName ?? '',
      adminPromotionLine1:
          HotelLandingHelper.getAdminPromotionLine1(list.promotionList ?? []),
      adminPromotionLine2:
          HotelLandingHelper.getAdminPromotionLine2(list.promotionList ?? []),
      ammenitiesList:
          HotelLandingHelper.getRecentAmenityList(list.promotionList ?? []),
      rating: HotelLandingHelper.updateStarRating(list.rating.toString()),
      promotionList: HotelLandingHelper.getHotelRecentPromotionList(
          list.promotionList ?? []),
    );
  }
}

class HotelRecentPromotionList {
  String productId;
  String productType;
  String promotionType;
  String promotionCode;
  String line1;
  String line2;
  HotelRecentPromotionList({
    this.productId = "",
    this.productType = "",
    this.promotionType = "",
    this.promotionCode = "",
    this.line1 = "",
    this.line2 = "",
  });
  factory HotelRecentPromotionList.fromList(PromotionList list) {
    return HotelRecentPromotionList(
        promotionCode: list.promotionCode ?? '',
        promotionType: list.promotionType ?? '',
        productType: list.productType ?? '',
        line1: list.line1 ?? '',
        line2: list.line2 ?? '');
  }
  factory HotelRecentPromotionList.getDefault() {
    return HotelRecentPromotionList(
        promotionCode: '',
        promotionType: '',
        productType: '',
        line1: '',
        line2: '');
  }
}
