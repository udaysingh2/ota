import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_room_promotion_widget/ota_promotion_model.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/domain/hotel/hotel_booking_details/models/hotel_booking_detail_model_domain.dart'
    as booking_detail_data;
import 'package:ota/domain/hotel/hotel_booking_details/models/hotel_booking_detail_model_domain.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view_model/hotel_booking_details_room_info_view_model.dart';

const String _kOverlay = "OVERLAY";
const String _kBedDouble = "assets/images/icons/bed_double_gradient.svg";
const String _kDefaultIcon = "assets/images/icons/uil_info-circle.svg";
const String _kUserIcon = "assets/images/icons/users_alt.svg";
const String _kArrowShrink = "assets/images/icons/uil_arrows_shrink.svg";

const String _kCloseIcon = "assets/images/icons/close.svg";
const String _kWifiIcon = "assets/images/icons/wifi.svg";
const String _kCrockeryIcon = "assets/images/icons/crockery.svg";
const String _kPriceIcon = "assets/images/icons/price.svg";
const String _kMaxAdults = "MAX_PAX_NBR";
const String _kQueenBedFlag = "QUEEN_BED_FLAG";
const String _kTwinBedFlag = "TWIN_BED_FLAG";
const String _kDoubleBedFlag = "DOUBLE_BED_FLAG";
const String _kDimension = "DIMENSION";
const String _kPayment = "PAYMENT";
const String _kBreakfast = "BREAKFAST";
const String _kWifi = "WIFI";
const String _kNonSmoking = "NON_SMOKING";
const String _kDoubleQueenBedFlag = "DOUBLE_QUEEN";
const String _kDoubleTwinBedFlag = "DOUBLE_TWIN";
const String _kQueenTwinBedFlag = "QUEEN_TWIN";
const String _kDoubleQueenTwinBedFlag = "DOUBLE_QUEEN_TWIN";

class HotelBookingDetailHelper {
  static List<OtaPromotionModel> getHotelBenefits(
      List<HotelBenefits> hotelBenefits) {
    return List.generate(hotelBenefits.length, (index) {
      return OtaPromotionModel(
        hotelBenefits.elementAt(index).shortDescription ?? "",
        hotelBenefits.elementAt(index).longDescription ?? "",
      );
    });
  }

  static List<OtaFreeFoodPromotionModel> generateFreeFoodPromotionList(
      List<PromotionList>? list) {
    List<OtaFreeFoodPromotionModel> promotionList = [];
    if (list == null || list.isEmpty) {
      return promotionList;
    }
    for (int i = 0; i < list.length; i++) {
      promotionList.add(OtaFreeFoodPromotionModel(
        deepLinkUrl: list[i].web ?? "",
        headerIcon: list[i].iconImage ?? "",
        headerText: list[i].title ?? "",
        subHeaderText: list[i].description ?? "",
        promotionCode: list[i].promotionCode ?? "",
        line1: list[i].line1 ?? "",
      ));
    }
    return promotionList;
  }

  static String getAdminPromotionLine1(
      List<booking_detail_data.Promotions> promotionList) {
    for (int i = 0; i < promotionList.length; i++) {
      if (promotionList[i].promotionType == _kOverlay) {
        return promotionList[i].line1 ?? '';
      }
    }
    return '';
  }

  static String getAdminPromotionLine2(
      List<booking_detail_data.Promotions> promotionList) {
    for (int i = 0; i < promotionList.length; i++) {
      if (promotionList[i].promotionType == _kOverlay) {
        return promotionList[i].line2 ?? '';
      }
    }
    return '';
  }

  static List<HotelBookingDetailsFacilityList> getFacilityList(
      List<Facility>? facilities) {
    List<HotelBookingDetailsFacilityList> list = [];
    String str = "";
    if (facilities == null || facilities.isEmpty) return list;
    for (int i = 0; i < facilities.length; i++) {
      if (facilities[i].key == _kDoubleBedFlag ||
          facilities[i].key == _kQueenBedFlag ||
          facilities[i].key == _kTwinBedFlag) {
        if (str.isEmpty) {
          str = facilities[i].key!;
        } else {
          str += " ${facilities[i].key!}";
        }
        continue;
      }
      list.add(HotelBookingDetailsFacilityList(
          key: facilities[i].key, value: facilities[i].value));
    }
    if (str.isNotEmpty) {
      if (str.contains(_kDoubleBedFlag) &&
          str.contains(_kQueenBedFlag) &&
          str.contains(_kTwinBedFlag)) {
        list.add(HotelBookingDetailsFacilityList(
            key: _kDoubleQueenTwinBedFlag, value: "Y"));
      } else if (str.contains(_kDoubleBedFlag) &&
          str.contains(_kQueenBedFlag)) {
        list.add(HotelBookingDetailsFacilityList(
            key: _kDoubleQueenBedFlag, value: "Y"));
      } else if (str.contains(_kDoubleBedFlag) && str.contains(_kTwinBedFlag)) {
        list.add(HotelBookingDetailsFacilityList(
            key: _kDoubleTwinBedFlag, value: "Y"));
      } else if (str.contains(_kTwinBedFlag) && str.contains(_kQueenBedFlag)) {
        list.add(HotelBookingDetailsFacilityList(
            key: _kQueenTwinBedFlag, value: "Y"));
      } else {
        list.add(HotelBookingDetailsFacilityList(key: str, value: "Y"));
      }
    }
    return list;
  }

  static String getName(
    HotelBookingDetailsFacilityList model,
    BuildContext context,
  ) {
    switch (model.key) {
      case _kPayment:
      case _kBreakfast:
        return getTranslated(context, model.key!);
      case _kWifi:
        return getTranslated(context, AppLocalizationsStrings.wifi);
      case _kNonSmoking:
        return getTranslated(context, AppLocalizationsStrings.nonSmoking);
      case _kDoubleBedFlag:
        return getTranslated(context, AppLocalizationsStrings.doubleBed);
      case _kMaxAdults:
        return getTranslated(context, AppLocalizationsStrings.maxAdult)
            .replaceAll("#", model.value!);
      case _kDimension:
        return getTranslated(context, AppLocalizationsStrings.squareMeters)
            .replaceAll("#", model.value!.split(" ").first);
      case _kTwinBedFlag:
        return getTranslated(context, AppLocalizationsStrings.twoSinglebed);
      case _kQueenBedFlag:
        return getTranslated(context, AppLocalizationsStrings.kingbed);
      case _kDoubleQueenBedFlag:
        return getTranslated(context, AppLocalizationsStrings.doubleBed)
                .addTrailingSpace() +
            getTranslated(context, AppLocalizationsStrings.or)
                .addTrailingSpace() +
            getTranslated(context, AppLocalizationsStrings.kingbed);
      case _kDoubleTwinBedFlag:
        return getTranslated(context, AppLocalizationsStrings.doubleBed)
                .addTrailingSpace() +
            getTranslated(context, AppLocalizationsStrings.or)
                .addTrailingSpace() +
            getTranslated(context, AppLocalizationsStrings.twoSinglebed);
      case _kQueenTwinBedFlag:
        return getTranslated(context, AppLocalizationsStrings.kingbed)
                .addTrailingSpace() +
            getTranslated(context, AppLocalizationsStrings.or)
                .addTrailingSpace() +
            getTranslated(context, AppLocalizationsStrings.twoSinglebed);
      case _kDoubleQueenTwinBedFlag:
        return getTranslated(context, AppLocalizationsStrings.doubleBed)
                .addTrailingSpace() +
            getTranslated(context, AppLocalizationsStrings.or)
                .addTrailingSpace() +
            getTranslated(context, AppLocalizationsStrings.kingbed)
                .addTrailingSpace() +
            getTranslated(context, AppLocalizationsStrings.or)
                .addTrailingSpace() +
            getTranslated(context, AppLocalizationsStrings.twoSinglebed);
      default:
        return "";
    }
  }

  static String getSvgIcon(String key) {
    switch (key) {
      case _kPayment:
        return _kPriceIcon;
      case _kBreakfast:
        return _kCrockeryIcon;
      case _kWifi:
        return _kWifiIcon;
      case _kNonSmoking:
        return _kCloseIcon;
      case _kDoubleBedFlag:
      case _kQueenBedFlag:
      case _kTwinBedFlag:
      case _kDoubleQueenBedFlag:
      case _kDoubleTwinBedFlag:
      case _kQueenTwinBedFlag:
      case _kDoubleQueenTwinBedFlag:
        return _kBedDouble;
      case _kMaxAdults:
        return _kUserIcon;
      case _kDimension:
        return _kArrowShrink;
      default:
        return _kDefaultIcon;
    }
  }
}
