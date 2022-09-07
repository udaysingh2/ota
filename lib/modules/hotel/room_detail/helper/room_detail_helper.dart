import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/domain/hotel/room_detail/models/room_detail_model.dart';
import 'package:ota/modules/hotel/room_detail/view/widgets/cancellation_policy/cancellation_policy_model.dart';
import 'package:ota/modules/hotel/room_detail/view_model/room_category_view_model.dart';
import 'package:ota/modules/hotel/room_detail/view_model/room_detail_view_model.dart';

import '../../../../core_pack/custom_widgets/ota_room_promotion_widget/ota_promotion_model.dart';

const String _kBedDouble = "assets/images/icons/bed_double_gradient.svg";
const String _kDefaultIcon = "assets/images/icons/uil_info-circle.svg";
const String _kCloseIcon = "assets/images/icons/close.svg";
const String _kWifiIcon = "assets/images/icons/wifi.svg";
const String _kCrockeryIcon = "assets/images/icons/crockery.svg";
const String _kPriceIcon = "assets/images/icons/price.svg";
const String _kUserIcon = "assets/images/icons/users_alt.svg";
const String _kArrowShrink = "assets/images/icons/uil_arrows_shrink.svg";

const String _kMaxAdults = "MAX_PAX_NBR";
const String _kQueenBedFlag = "QUEEN_BED_FLAG";
const String _kTwinBedFlag = "TWIN_BED_FLAG";
const String _kDoubleBedFlag = "DOUBLE_BED_FLAG";
const String _kDimension = "DIMENSION";
const String _kPayment = "PAYMENT";
const String _kBreakfast = "BREAKFAST";
const String _kWifi = "WIFI";
const String _kNonSmoking = "NON_SMOKING";
const String _kDoubleQueenBedFlag = "DOUBLE_QUEEN_BED_FLAG";
const String _kDoubleTwinBedFlag = "DOUBLE_TWIN_BED_FLAG";
const String _kQueenTwinBedFlag = "QUEEN_TWIN_BED_FLAG";
const String _kDoubleQueenTwinBedFlag = "DOUBLE_QUEEN_TWIN_BED_FLAG";

class RoomDetailHelper {
  static List<CancellationPolicyModel>? generateCancellationPolicy(
      List<CancellationPolicy>? cancellationPolicy) {
    List<CancellationPolicyModel>? cancellationPolicyModel;
    if (cancellationPolicy != null && cancellationPolicy.isNotEmpty) {
      cancellationPolicyModel = List<CancellationPolicyModel>.generate(
          cancellationPolicy.length, (index) {
        return CancellationPolicyModel(
          cancellationDaysDescription:
              cancellationPolicy[index].cancellationDaysDescription,
          cancellationChargeDescription:
              cancellationPolicy[index].cancellationChargeDescription,
        );
      });
    }
    return cancellationPolicyModel;
  }

  static List<RoomCategoryViewModel>? generateRoomCategory(
      List<RoomCategory>? roomCategory) {
    List<RoomCategoryViewModel>? roomCategoryViewModel;
    if (roomCategory != null && roomCategory.isNotEmpty) {
      roomCategoryViewModel =
          List<RoomCategoryViewModel>.generate(roomCategory.length, (index) {
        return RoomCategoryViewModel.fromRoomCategory(
          roomCategory[index],
        );
      });
    }
    return roomCategoryViewModel;
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

  static List<FacilityModel> generateFacilityList(List<Facility>? facilities) {
    List<FacilityModel> list = [];
    String str = "";
    if (facilities == null || facilities.isEmpty) return list;
    for (int i = 0; i < facilities.length; i++) {
      if (facilities[i].key == _kDoubleBedFlag) {
        str = facilities[i].key!;
        if (i != facilities.length - 1 &&
            facilities[i + 1].key != _kTwinBedFlag &&
            facilities[i + 1].key != _kQueenBedFlag) {
          list.add(FacilityModel(str, "Y"));
        }
        continue;
      }

      if (facilities[i].key == _kTwinBedFlag) {
        str = str.isEmpty ? facilities[i].key! : _kDoubleTwinBedFlag;
        if (i != facilities.length - 1 &&
            facilities[i + 1].key != _kQueenBedFlag) {
          list.add(FacilityModel(str, "Y"));
        }
        continue;
      }

      if (facilities[i].key == _kQueenBedFlag) {
        if (str.isEmpty) {
          str = facilities[i].key!;
        } else if (str == _kDoubleBedFlag) {
          str = _kDoubleQueenBedFlag;
        } else if (str == _kTwinBedFlag) {
          str = _kQueenTwinBedFlag;
        } else {
          str = _kDoubleQueenTwinBedFlag;
        }
        list.add(FacilityModel(str, "Y"));
        continue;
      }

      list.add(FacilityModel(facilities[i].key!, facilities[i].value!));
    }
    return list;
  }

  static String getName(FacilityModel model, BuildContext context) {
    switch (model.key) {
      case _kPayment:
      case _kBreakfast:
        return getTranslated(context, model.key);
      case _kWifi:
        return getTranslated(context, AppLocalizationsStrings.wifi);
      case _kNonSmoking:
        return getTranslated(context, AppLocalizationsStrings.nonSmoking);
      case _kMaxAdults:
        return getTranslated(context, AppLocalizationsStrings.maxAdult)
            .replaceAll("#", model.value);
      case _kDimension:
        return getTranslated(context, AppLocalizationsStrings.squareMeters)
            .replaceAll("#", model.value.split(" ").first);
      case _kDoubleBedFlag:
        return getTranslated(context, AppLocalizationsStrings.doubleBed);
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
