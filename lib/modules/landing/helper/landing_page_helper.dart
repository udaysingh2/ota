import 'package:ota/common/utils/helper.dart';
import 'package:ota/domain/landing/banner/models/banner_models.dart'
    as banner_model;
import 'package:ota/domain/landing/service_card/models/service_card_model_domain.dart';
import 'package:ota/domain/playlist/models/playlist_result_model_domain.dart';
import 'package:ota/domain/popup/models/popup_models.dart' as popup_model;
import 'package:ota/domain/preference_questions/models/preference_questions_model_domain.dart';
import 'package:ota/domain/static_playlist/models/static_playlist_model_domain.dart';
import 'package:ota/modules/landing/view_model/banner_view_model.dart';
import 'package:ota/modules/landing/view_model/car_card_view_model.dart';
import 'package:ota/modules/landing/view_model/hotel_card_view_model.dart';
import 'package:ota/modules/landing/view_model/landing_static_playlist_card_view_model.dart';
import 'package:ota/modules/landing/view_model/playlist_card_view_model.dart';
import 'package:ota/modules/landing/view_model/popup_view_model.dart';
import 'package:ota/modules/landing/view_model/preferences_view_model.dart';
import 'package:ota/modules/landing/view_model/service_card_view_model.dart';
import 'package:ota/modules/landing/view_model/tour_card_view_model.dart';
import 'package:ota/modules/playlist/view_model/static_playlist_type.dart';

const String _kBlock = "BLOCK";
const String _kSeen = "SEEN";

const _kHotelType = "HOTEL";
const _kTourType = "TOUR";
const _kTicketType = "TICKET";
const _kCarRentalType = "CARRENTAL";

const _kMinNum = 1;

class LandingPageHelper {
  static List<BannerDataModel>? generateBannerList(
      banner_model.GetBannersData? bannersData) {
    List<BannerDataModel>? bannerList;
    if (bannersData?.banner != null && bannersData!.banner!.isNotEmpty) {
      bannerList =
          List<BannerDataModel>.generate(bannersData.banner!.length, (index) {
        return BannerDataModel(
          bannerId: bannersData.banner![index].bannerId ?? "",
          deepLinkUrl: bannersData.banner![index].deeplinkUrl ?? "",
          imageUrl: bannersData.banner![index].imageFilename ?? "",
          function: bannersData.banner![index].function ?? "",
        );
      });
    }
    return bannerList;
  }

  static List<PopupDataModel>? generatePopupList(
      popup_model.GetPopupsData? popupsData) {
    List<PopupDataModel>? popupList;
    if (popupsData?.popups != null && popupsData!.popups!.isNotEmpty) {
      popupList =
          List<PopupDataModel>.generate(popupsData.popups!.length, (index) {
        return PopupDataModel(
          id: popupsData.popups![index].popupId ?? "",
          deepLinkUrl: popupsData.popups![index].deeplinkUrl ?? "",
          imageUrl: popupsData.popups![index].imageFilename ?? "",
          priority: popupsData.popups![index].priority ?? "",
          endDate: Helpers.getYYYYmmddFromDateTime(
              popupsData.popups![index].endDate),
          startDate: Helpers.getYYYYmmddFromDateTime(
              popupsData.popups![index].startDate),
        );
      });
    }
    return popupList;
  }

  static List<PreferencesViewModel>? generatePreferencesList(
      List<Preference>? preferences) {
    List<PreferencesViewModel> preferenceList = [];
    if (preferences != null && preferences.isNotEmpty) {
      preferenceList =
          List<PreferencesViewModel>.generate(preferences.length, (index) {
        return PreferencesViewModel(
            questionId: preferences[index].questionId ?? "",
            description1: preferences[index].description1 ?? "",
            description2: preferences[index].description2 ?? "",
            backgroundImageUrl: preferences[index].backgroundImageUrl ?? "",
            multiChoice: preferences[index].multiChoice ?? false,
            minNum: preferences[index].minNum ?? _kMinNum,
            options: generateOptionListList(
                  preferences[index].options ?? [],
                ) ??
                []);
      });
    }
    return preferenceList;
  }

  static List<OptionViewModel>? generateOptionListList(List<Option>? options) {
    List<OptionViewModel>? optionList;
    if (options != null && options.isNotEmpty) {
      optionList = List<OptionViewModel>.generate(options.length, (index) {
        return OptionViewModel(
          optionCode: options[index].optionCode ?? "",
          optionDesc: options[index].optionDesc ?? "",
          imageUrl: options[index].imageUrl ?? "",
        );
      });
    }
    return optionList;
  }

  static List<ServiceViewModel>? generateServiceList(
      List<BusinessCard>? businessCards) {
    List<ServiceViewModel>? serviceList;
    if (businessCards != null && businessCards.isNotEmpty) {
      serviceList =
          List<ServiceViewModel>.generate(businessCards.length, (index) {
        return ServiceViewModel(
            serviceText: businessCards[index].serviceText ?? "",
            deepLinkUrl: businessCards[index].deeplinkUrl ?? "",
            imageUrl: businessCards[index].imageUrl ?? "",
            largeImageUrl: businessCards[index].largeImageUrl ?? "",
            serviceBackgroundUrl:
                businessCards[index].serviceBackgroundUrl ?? "",
            title: businessCards[index].title ?? "",
            description: businessCards[index].description ?? "",
            service: businessCards[index].service ?? "",
            sortSequence: int.tryParse(businessCards[index].sortSeq ?? ''));
      });
    }
    return serviceList;
  }

  static String getIntentType(bool selected) {
    return selected ? _kBlock : _kSeen;
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

  static List<HotelCardPromotions> getHotelCapsulePromotionList(
      List<CardCapsulePromotion>? capsulePromotion) {
    List<HotelCardPromotions> list = [];
    if (capsulePromotion == null || capsulePromotion.isEmpty) {
      return [];
    }
    for (int i = 0; i < capsulePromotion.length; i++) {
      list.add(HotelCardPromotions(
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

  static List<TourCardPromotions> getTourCardPromotionList(
      List<CardCapsulePromotion>? capsulePromotion) {
    if (capsulePromotion == null || capsulePromotion.isEmpty) {
      return [];
    }

    List<TourCardPromotions> list = [];
    for (int i = 0; i < capsulePromotion.length; i++) {
      list.add(TourCardPromotions(
        name: capsulePromotion[i].name ?? '',
        code: capsulePromotion[i].code ?? '',
      ));
    }
    return list;
  }

  static List<CarCardPromotions> getCarCardPromotionList(
      List<CardCapsulePromotion>? capsulePromotion) {
    if (capsulePromotion == null || capsulePromotion.isEmpty) {
      return [];
    }

    List<CarCardPromotions> list = [];

    for (int i = 0; i < capsulePromotion.length; i++) {
      list.add(CarCardPromotions(
        name: capsulePromotion[i].name ?? '',
        code: capsulePromotion[i].code ?? '',
      ));
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

  static StaticPlaylistType getPlayListType(String type) {
    return type == _kTourType
        ? StaticPlaylistType.tour
        : StaticPlaylistType.ticket;
  }

  static StaticPlayListModelEnum getViewModelTypeEnum(String type) {
    switch (type) {
      case _kTourType:
        return StaticPlayListModelEnum.tour;
      case _kTicketType:
        return StaticPlayListModelEnum.ticket;
      case _kCarRentalType:
        return StaticPlayListModelEnum.carRental;
      case _kHotelType:
        return StaticPlayListModelEnum.hotel;
      default:
        return StaticPlayListModelEnum.none;
    }
  }
}
