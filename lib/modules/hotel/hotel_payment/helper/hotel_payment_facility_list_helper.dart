import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/domain/confirm_booking/models/booking_confirmation_data_model.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/hotel_payment_room_view_model.dart';

import '../../../../core_pack/custom_widgets/ota_room_promotion_widget/ota_promotion_model.dart';

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

class HotelPaymentFacilityListHelper {
  static List<HotelPaymentFacilityList> getFacility(List<Facility> facility) {
    List<HotelPaymentFacilityList> result = [];
    String str = "";
    for (int i = 0; i < facility.length; i++) {
      if (facility[i].key == _kDoubleBedFlag) {
        str = facility[i].key!;
        if (i != facility.length - 1 &&
            facility[i + 1].key != _kTwinBedFlag &&
            facility[i + 1].key != _kQueenBedFlag) {
          result.add(HotelPaymentFacilityList(
            key: str,
            value: "Y",
          ));
        }
        continue;
      }

      if (facility[i].key == _kTwinBedFlag) {
        str = str.isEmpty ? facility[i].key! : _kDoubleTwinBedFlag;
        if (i != facility.length - 1 && facility[i + 1].key != _kQueenBedFlag) {
          result.add(HotelPaymentFacilityList(
            key: str,
            value: "Y",
          ));
        }
        continue;
      }

      if (facility[i].key == _kQueenBedFlag) {
        if (str.isEmpty) {
          str = facility[i].key!;
        } else if (str == _kDoubleBedFlag) {
          str = _kDoubleQueenBedFlag;
        } else if (str == _kTwinBedFlag) {
          str = _kQueenTwinBedFlag;
        } else {
          str = _kDoubleQueenTwinBedFlag;
        }
        result.add(HotelPaymentFacilityList(
          key: str,
          value: "Y",
        ));
        continue;
      }
      result.add(HotelPaymentFacilityList(
          key: facility[i].key, value: facility[i].value));
    }
    return result;
  }

  static List<OtaPromotionModel> generatePromotionList(
      List<HotelBenefit>? benefits) {
    List<OtaPromotionModel> promotionList = [];
    if (benefits == null || benefits.isEmpty) {
      return promotionList;
    }
    for (int i = 0; i < benefits.length; i++) {
      promotionList.add(OtaPromotionModel(
        benefits[i].shortDescription ?? "",
        benefits[i].longDescription ?? "",
      ));
    }
    return promotionList;
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

  static String getName(
    HotelPaymentFacilityList model,
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
