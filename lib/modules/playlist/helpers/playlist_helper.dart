import 'package:flutter/cupertino.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/domain/playlist/models/playlist_result_model_domain.dart';
import 'package:ota/domain/static_playlist/models/static_playlist_model_domain.dart';
import 'package:ota/modules/landing/view_model/car_card_view_model.dart';
import 'package:ota/modules/landing/view_model/hotel_card_view_model.dart';
import 'package:ota/modules/landing/view_model/tour_card_view_model.dart';
import 'package:ota/modules/playlist/view_model/car_vertical_card_view_model.dart';
import 'package:ota/modules/playlist/view_model/full_playlist_card_view_model.dart';
import 'package:ota/modules/playlist/view_model/hotel_vertical_card_view_model.dart';
import 'package:ota/modules/playlist/view_model/tour_vertical_card_view_model.dart';

const int _kDefaultStarRating = 1;
const int _kMaxStarRating = 5;

class PlaylistHelper {
  static List<FullPlaylistCardViewModel>? getPlaylistCardViewModelList(
      List<CardList>? list) {
    List<FullPlaylistCardViewModel>? playlistCardViewModelList;
    if (list == null || list.isEmpty) return playlistCardViewModelList;

    playlistCardViewModelList = List<FullPlaylistCardViewModel>.generate(
      list.length,
      (index) => FullPlaylistCardViewModel.fromList(list[index]),
    );
    return playlistCardViewModelList;
  }

  static String updateStarRating(int rating) {
    if (rating <= _kDefaultStarRating) {
      return _kDefaultStarRating.toString();
    } else if (rating >= _kMaxStarRating) {
      return _kMaxStarRating.toString();
    } else {
      return rating.toString();
    }
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

  static List<String> getInfoPromotionList(List<Infopromotion> infoPromotion) {
    List<String> list = [];
    for (int i = 0; i < infoPromotion.length; i++) {
      list.add(
        infoPromotion[i].promotionText ?? '',
      );
    }
    return list;
  }

  static List<String> getAmenitiesList(
      List<Promotions> capsulePromotion, List<String> infoPromotion) {
    List<String> list = [];
    for (int i = 0; i < capsulePromotion.length; i++) {
      list.add(capsulePromotion[i].name ?? '');
    }
    list.addAll(infoPromotion);
    return list;
  }

  static List<HotelVerticalCardPromotions> getHotelCapsulePromotionList(
      List<CardCapsulePromotion>? capsulePromotion) {
    List<HotelVerticalCardPromotions> list = [];
    if (capsulePromotion == null || capsulePromotion.isEmpty) {
      return [];
    }
    for (int i = 0; i < capsulePromotion.length; i++) {
      list.add(HotelVerticalCardPromotions(
        name: capsulePromotion[i].name ?? '',
        code: capsulePromotion[i].code ?? '',
      ));
    }
    return list;
  }

  static List<String> getHotelInfoPromotionList(
      List<InfoPromotion>? infoPromotion) {
    List<String> list = [];
    if (infoPromotion == null || infoPromotion.isEmpty) {
      return [];
    }
    for (int i = 0; i < infoPromotion.length; i++) {
      list.add(
        infoPromotion[i].promotionText ?? '',
      );
    }
    return list;
  }

  static List<HotelVerticalCardPromotions> getHotelCardPromotionList(
      List<HotelCardPromotions>? capsulePromotion) {
    List<HotelVerticalCardPromotions> list = [];
    if (capsulePromotion == null || capsulePromotion.isEmpty) {
      return [];
    }
    for (int i = 0; i < capsulePromotion.length; i++) {
      list.add(HotelVerticalCardPromotions(
        name: capsulePromotion[i].name ?? '',
        code: capsulePromotion[i].code ?? '',
      ));
    }
    return list;
  }

  static List<TourVerticalCardPromotions> getTourCardPromotionList(
      List<CardCapsulePromotion>? capsulePromotion) {
    if (capsulePromotion == null || capsulePromotion.isEmpty) {
      return [];
    }
    List<TourVerticalCardPromotions> list = [];
    for (int i = 0; i < capsulePromotion.length; i++) {
      list.add(TourVerticalCardPromotions(
        name: capsulePromotion[i].name ?? '',
        code: capsulePromotion[i].code ?? '',
      ));
    }
    return list;
  }

  static List<CarVerticalCardPromotions> getCarCardPromotionList(
      List<CardCapsulePromotion>? capsulePromotion) {
    if (capsulePromotion == null || capsulePromotion.isEmpty) {
      return [];
    }

    List<CarVerticalCardPromotions> list = [];

    for (int i = 0; i < capsulePromotion.length; i++) {
      list.add(CarVerticalCardPromotions(
        name: capsulePromotion[i].name ?? '',
        code: capsulePromotion[i].code ?? '',
      ));
    }

    return list;
  }

  static List<TourVerticalCardPromotions> getCardPromotionList(
      List<TourCardPromotions>? capsulePromotion) {
    if (capsulePromotion == null || capsulePromotion.isEmpty) {
      return [];
    }
    List<TourVerticalCardPromotions> list = [];
    for (int i = 0; i < capsulePromotion.length; i++) {
      list.add(TourVerticalCardPromotions(
        name: capsulePromotion[i].name ?? '',
        code: capsulePromotion[i].code ?? '',
      ));
    }
    return list;
  }

  static List<CarVerticalCardPromotions> getCardCarPromotionList(
      List<CarCardPromotions>? capsulePromotion) {
    if (capsulePromotion == null || capsulePromotion.isEmpty) {
      return [];
    }

    List<CarVerticalCardPromotions> list = [];

    for (int i = 0; i < capsulePromotion.length; i++) {
      list.add(CarVerticalCardPromotions(
        name: capsulePromotion[i].name ?? '',
        code: capsulePromotion[i].code ?? '',
      ));
    }

    return list;
  }

  static List<String> getCategoryName(BuildContext context) {
    List<String> list = [];
    list.add(getTranslated(context, AppLocalizationsStrings.all));
    list.add(getTranslated(
        context, AppLocalizationsStrings.allServicesAccommodation));
    list.add(getTranslated(context, AppLocalizationsStrings.allServicesTour));
    list.add(getTranslated(context, AppLocalizationsStrings.allServicesTicket));
    return list;
  }
}
