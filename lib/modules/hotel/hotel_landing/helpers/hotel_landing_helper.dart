import 'package:ota/domain/hotel/hotel_recommended_location/models/recommended_location_model_domain.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_model_domain.dart';
import 'package:ota/modules/hotel/hotel_landing/view_model/hotel_playlist_view_model.dart';
import 'package:ota/modules/hotel/hotel_landing/view_model/recommended_location_view_model.dart';

import '../../../../domain/hotel_playlist/hotel_dynamic_playlist/models/hotel_dynamic_playlist_model_domain.dart'
    as hotel_dynamic_playlist;
import '../view_model/hotel_recentviewplaylist_view_model.dart';

const int _kDefaultStarRating = 1;
const int _kMaxStarRating = 5;

const String _kCapsule = "CAPSULE";
const String _kOverlay = "OVERLAY";

class HotelLandingHelper {
  static List<RecommendedLocationModel>? getHotelRecommendationViewModel(
      List<LocationList>? locations) {
    List<RecommendedLocationModel>? recommendedLocationList;
    if (locations == null || locations.isEmpty) {
      return recommendedLocationList;
    }
    recommendedLocationList = List<RecommendedLocationModel>.generate(
        locations.length,
        (index) => RecommendedLocationModel.mapFromModel(locations[index]));
    return recommendedLocationList;
  }

  static List<Promotions> getCapsulePromotionList(
      List<CapsulePromotion> capsulePromotion) {
    List<Promotions> list = [];
    for (int i = 0; i < capsulePromotion.length; i++) {
      list.add(Promotions(
        name: capsulePromotion[i].name ?? '',
        code: capsulePromotion[i].code ?? '',
      ));
    }
    return list;
  }

  static List<String> getInfoPromotionList(List<InfoPromotion> infoPromotion) {
    List<String> list = [];

    for (int i = 0; i < infoPromotion.length; i++) {
      list.add(
        infoPromotion[i].promotionText ?? '',
      );
    }
    return list;
  }

  static String updateStarRating(String? ratingText) {
    final double rating = double.tryParse(ratingText ?? '0') ?? 0;
    if (rating <= _kDefaultStarRating) {
      return _kDefaultStarRating.toString();
    } else if (rating >= _kMaxStarRating) {
      return _kMaxStarRating.toString();
    } else {
      return rating.toString();
    }
  }

  static List<HotelStaticPlaylistCardModel> getHotelStaticPlaylist(
      List<CardList> cardList) {
    List<HotelStaticPlaylistCardModel> list = [];
    for (int i = 0; i < cardList.length; i++) {
      list.add(HotelStaticPlaylistCardModel(
          name: cardList[i].name ?? '',
          productType: cardList[i].productType ?? '',
          id: cardList[i].id ?? '',
          cityId: cardList[i].cityId ?? '',
          countryId: cardList[i].countryId ?? '',
          imageUrl: cardList[i].imageUrl ?? '',
          rating: updateStarRating(cardList[i].rating.toString()),
          locationName: cardList[i].locationName ?? '',
          cityName: cardList[i].cityName ?? '',
          address: cardList[i].address ?? '',
          address1: cardList[i].address1 ?? '',
          promotionTextLine1: cardList[i].promotionTextLine1 ?? '',
          promotionTextLine2: cardList[i].promotionTextLine2 ?? '',
          capsulePromotion: HotelLandingHelper.getCapsulePromotionList(
              cardList[i].capsulePromotion ?? [])));
    }
    return list;
  }

  static List<String> getAmenitiesList(List<Promotions> capsulePromotion,
      List<String> infoPromotion, bool isStatic) {
    List<String> list = [];
    for (int i = 0; i < capsulePromotion.length; i++) {
      list.add(capsulePromotion[i].name ?? '');
    }
    if (!isStatic) list.addAll(infoPromotion);
    return list;
  }

  static List<Promotions> getDynamicCapsulePromotionList(
      List<hotel_dynamic_playlist.CapsulePromotion> capsulePromotion) {
    List<Promotions> list = [];
    for (int i = 0; i < capsulePromotion.length; i++) {
      list.add(Promotions(
        name: capsulePromotion[i].name ?? '',
        code: capsulePromotion[i].code ?? '',
      ));
    }
    return list;
  }

  static List<String> getDynamicInfoPromotionList(
      List<hotel_dynamic_playlist.InfoPromotion> infoPromotion) {
    List<String> list = [];
    for (int i = 0; i < infoPromotion.length; i++) {
      list.add(
        infoPromotion[i].promotionText ?? '',
      );
    }
    return list;
  }

  static List<HotelStaticPlaylistCardModel> getDynamicPlaylist(
      List<hotel_dynamic_playlist.CardList> cardList) {
    List<HotelStaticPlaylistCardModel> list = [];
    for (int i = 0; i < cardList.length; i++) {
      list.add(
        HotelStaticPlaylistCardModel(
          name: cardList[i].name ?? '',
          productType: cardList[i].productType ?? '',
          id: cardList[i].id ?? '',
          cityId: cardList[i].cityId ?? '',
          countryId: cardList[i].countryId ?? '',
          imageUrl: cardList[i].imageUrl ?? '',
          rating: updateStarRating(cardList[i].rating.toString()),
          locationName: cardList[i].locationName ?? '',
          cityName: cardList[i].cityName ?? '',
          address: cardList[i].address ?? '',
          promotionTextLine1: cardList[i].promotionText1 ?? '',
          promotionTextLine2: cardList[i].promotionText2 ?? '',
          capsulePromotion: HotelLandingHelper.getDynamicCapsulePromotionList(
              cardList[i].capsulePromotion ?? []),
          infoPromotion: HotelLandingHelper.getDynamicInfoPromotionList(
              cardList[i].infopromotion ?? []),
        ),
      );
    }
    return list;
  }

  static List<HotelStaticPlayListModel> getdynamicPlayList(
      List<hotel_dynamic_playlist.Playlist> playlist) {
    List<HotelStaticPlayListModel> list = [];
    for (int i = 0; i < playlist.length; i++) {
      list.add(HotelStaticPlayListModel(
          playlistName: playlist[i].playlistName ?? '',
          playlistId: playlist[i].playlistId ?? '',
          hotelStaticCardPlaylist: getDynamicPlaylist(
            playlist[i].cardList ?? [],
          )));
    }
    return list;
  }

  static List<HotelRecentPromotionList> getHotelRecentPromotionList(
      List<hotel_dynamic_playlist.PromotionList> promotionList) {
    List<HotelRecentPromotionList> list = [];
    for (int i = 0; i < promotionList.length; i++) {
      list.add(HotelRecentPromotionList(
        promotionCode: promotionList[i].promotionCode ?? '',
        productId: promotionList[i].productId ?? '',
        productType: promotionList[i].productType ?? '',
        line1: promotionList[i].line1 ?? '',
        line2: promotionList[i].line2 ?? '',
        promotionType: promotionList[i].promotionType ?? '',
      ));
    }
    return list;
  }

  static List<String> getRecentAmenityList(
      List<hotel_dynamic_playlist.PromotionList> promotionList) {
    List<String> list = [];
    for (int i = 0; i < promotionList.length; i++) {
      if (promotionList[i].promotionType == _kCapsule &&
          promotionList[i].line1 != null &&
          promotionList[i].line1!.isNotEmpty) {
        list.add(promotionList[i].line1!);
      }
    }
    return list;
  }

  static String getAdminPromotionLine1(
      List<hotel_dynamic_playlist.PromotionList> promotionList) {
    for (int i = 0; i < promotionList.length; i++) {
      if (promotionList[i].promotionType == _kOverlay) {
        return promotionList[i].line1 ?? '';
      }
    }
    return '';
  }

  static String getAdminPromotionLine2(
      List<hotel_dynamic_playlist.PromotionList> promotionList) {
    for (int i = 0; i < promotionList.length; i++) {
      if (promotionList[i].promotionType == _kOverlay) {
        return promotionList[i].line2 ?? '';
      }
    }
    return '';
  }
}
