import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_model_domain.dart';
import 'package:ota/modules/hotel/hotel_landing/helpers/hotel_landing_helper.dart';

class HotelStaticPlayListViewModel {
  List<HotelStaticPlayListModel> playList;
  HotelStaticPlayListViewModelState hotelStaticPlayListViewModelState;
  HotelStaticPlayListViewModel({
    this.playList = const [],
    this.hotelStaticPlayListViewModelState =
        HotelStaticPlayListViewModelState.none,
  });
}

class HotelStaticPlayListModel {
  String playlistId;
  String playlistName;
  List<HotelStaticPlaylistCardModel> hotelStaticCardPlaylist;

  HotelStaticPlayListModel({
    this.playlistId = "",
    this.playlistName = "",
    this.hotelStaticCardPlaylist = const [],
  });

  factory HotelStaticPlayListModel.fromList(Playlist list) {
    return HotelStaticPlayListModel(
      playlistId: list.playlistId ?? '',
      playlistName: list.playlistName ?? '',
      hotelStaticCardPlaylist:
          HotelLandingHelper.getHotelStaticPlaylist(list.cardList ?? []),
    );
  }
}

class HotelStaticPlaylistCardModel {
  String productType;
  String id;
  String cityId;
  String countryId;
  String imageUrl;
  String rating;
  String name;
  String cityName;
  String locationName;
  String address;
  String address1;
  String promotionTextLine1;
  String promotionTextLine2;
  List<Promotions> capsulePromotion;
  List<String> infoPromotion;

  HotelStaticPlaylistCardModel(
      {this.productType = "",
      this.id = "",
      this.cityId = "",
      this.countryId = "",
      this.imageUrl = "",
      this.rating = "1",
      this.name = "",
      this.cityName = "",
      this.locationName = "",
      this.address = "",
      this.address1 = "",
      this.promotionTextLine1 = "",
      this.promotionTextLine2 = "",
      this.capsulePromotion = const [],
      this.infoPromotion = const []});

  factory HotelStaticPlaylistCardModel.fromList(CardList list) {
    return HotelStaticPlaylistCardModel(
      productType: list.productType ?? '',
      id: list.id ?? '',
      cityId: list.cityId ?? '',
      countryId: list.countryId ?? '',
      imageUrl: list.imageUrl ?? '',
      rating: HotelLandingHelper.updateStarRating(list.rating.toString()),
      name: list.name ?? '',
      cityName: list.cityName ?? '',
      address: list.address ?? '',
      address1: list.address1 ?? '',
      locationName: list.locationName ?? '',
      promotionTextLine1: list.promotionTextLine1 ?? '',
      promotionTextLine2: list.promotionTextLine2 ?? '',
      capsulePromotion: HotelLandingHelper.getCapsulePromotionList(
          list.capsulePromotion ?? []),
      infoPromotion: HotelLandingHelper.getInfoPromotionList(
          list.infopromotion ?? []),
    );
  }
}

class Promotions {
  String? name;
  String? code;
  Promotions({this.name, this.code});
}

enum HotelStaticPlayListViewModelState {
  none,
  loading,
  pullDownLoading,
  success,
  failure,
}
