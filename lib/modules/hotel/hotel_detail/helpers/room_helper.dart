import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_detail_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/secondary_view_model.dart';

import '../../../../core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import '../view_model/primary_view_model.dart';

const String _kBedDouble = "assets/images/icons/bed_double_gradient.svg";
const String _kDefaultIcon = "assets/images/icons/uil_info-circle.svg";
const String _kUserIcon = "assets/images/icons/users_alt.svg";
const String _kArrowShrink = "assets/images/icons/uil_arrows_shrink.svg";

const String _kMaxAdults = "MAX_PAX_NBR";
const String _kQueenBedFlag = "QUEEN_BED_FLAG";
const String _kTwinBedFlag = "TWIN_BED_FLAG";
const String _kDoubleBedFlag = "DOUBLE_BED_FLAG";
const String _kDimension = "DIMENSION";
const String _kDoubleQueenBedFlag = "DOUBLE_QUEEN_BED_FLAG";
const String _kDoubleTwinBedFlag = "DOUBLE_TWIN_BED_FLAG";
const String _kQueenTwinBedFlag = "QUEEN_TWIN_BED_FLAG";
const String _kDoubleQueenTwinBedFlag = "DOUBLE_QUEEN_TWIN_BED_FLAG";

class RoomHelper {
  static List<PrimaryViewModel>? generatePrimary(List<Room>? room,
      {Data? data}) {
    List<PrimaryViewModel>? primaryViewModel;
    if (room != null && room.isNotEmpty) {
      primaryViewModel = List<PrimaryViewModel>.generate(room.length, (index) {
        List<SecondaryViewModel> secondaryViewModel = generateSecondary(
          room[index].details,
          room[index].facility,
          data,
        );
        return PrimaryViewModel(
            roomName: room[index].roomName!,
            nightPrice: secondaryViewModel.isNotEmpty
                ? secondaryViewModel.first.nightPrice
                : 0,
            children: secondaryViewModel,
            imageUrl: room[index].roomInfo?.coverImage ?? "",
            facilitiesList: _getList(room[index].facility));
      });
      primaryViewModel.sort((a, b) => a.nightPrice.compareTo(b.nightPrice));
    }
    return primaryViewModel;
  }

  static List<OtaFreeFoodPromotionModel> generatePromotion(
      List<Promotions>? promotions) {
    List<OtaFreeFoodPromotionModel> freeFoodPromotionList = [];
    if (promotions == null || promotions.isEmpty) {
      return freeFoodPromotionList;
    }
    for (int i = 0; i < promotions.length; i++) {
      freeFoodPromotionList.add(OtaFreeFoodPromotionModel(
        headerText: promotions[i].title ?? "",
        subHeaderText: promotions[i].description ?? "",
        headerIcon: promotions[i].imageIconUrl ?? "",
        deepLinkUrl: promotions[i].web ?? "",
        line1: promotions[i].line1 ?? "",
      ));
    }
    return freeFoodPromotionList;
  }

  static List<FacilityViewModel> _getList(List<ListElement>? facilities) {
    List<FacilityViewModel> list = [];
    String str = "";
    if (facilities == null || facilities.isEmpty) return list;
    for (int i = 0; i < facilities.length; i++) {
      if (facilities[i].key == _kDoubleBedFlag) {
        str = facilities[i].key!;
        if (i != facilities.length - 1 &&
            facilities[i + 1].key != _kTwinBedFlag &&
            facilities[i + 1].key != _kQueenBedFlag) {
          list.add(FacilityViewModel(str, "Y"));
        }
        continue;
      }

      if (facilities[i].key == _kTwinBedFlag) {
        str = str.isEmpty ? facilities[i].key! : _kDoubleTwinBedFlag;
        if (i != facilities.length - 1 &&
            facilities[i + 1].key != _kQueenBedFlag) {
          list.add(FacilityViewModel(str, "Y"));
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
        list.add(FacilityViewModel(str, "Y"));
        continue;
      }

      list.add(FacilityViewModel(facilities[i].key!, facilities[i].value!));
    }
    return list;
  }

  static List<SecondaryViewModel> generateSecondary(
      List<Detail>? details, List<ListElement>? facilitys, Data? data) {
    Map<String, dynamic>? facility;
    if (facilitys != null && facilitys.isNotEmpty) {
      facility = {
        for (var element in facilitys) (element).key!: (element).value
      };
    }

    List<SecondaryViewModel> secondaryViewModel =
        List<SecondaryViewModel>.generate(details?.length ?? 0, (indexChild) {
      Detail? detail = details?.elementAt(indexChild);
      return SecondaryViewModel(
        roomCode: detail?.roomCode ?? "",
        roomType: detail?.roomType ?? "",
        roomName: detail?.roomOfferName ?? "",
        supplier: detail?.supplier ?? '',
        supplierId: detail?.supplierId ?? '',
        supplierName: detail?.supplierName ?? '',
        facilityList: facility,
        roomOffer: RoomOffers(
          cancellationPolicy: detail?.roomOffer?.cancellationPolicy,
          payNow: detail?.roomOffer?.payNow,
          breakfast: detail?.roomOffer?.breakfast,
          mealCode: detail?.roomOffer?.mealCode,
        ),
        nightPrice: detail?.nightPrice ?? 0,
        totalPrice: detail?.totalPrice ?? 0,
        maxDiscount: detail?.discountPercent,
        priceWithoutDiscount: detail?.nightPriceBeforeDiscount,
        noOfRoomsAndName: detail?.noOfRoomsAndName ?? "",
        freeFoodDelivery: data?.freefoodDelivery ?? false,
        rating: data?.rating ?? "",
        hotelBenefits: _getHotelBenefitsList(detail?.hotelBenefits ?? []),
        address: data?.location ?? "",
        roomCatName: detail?.roomCatName ?? "",
      );
    });
    secondaryViewModel.sort((a, b) => a.nightPrice.compareTo(b.nightPrice));
    return secondaryViewModel;
  }

  static List<String> _getHotelBenefitsList(List<HotelBenefits> hotelBenefits) {
    return List.generate(hotelBenefits.length, (index) {
      return hotelBenefits.elementAt(index).shortDescription ?? "";
    });
  }

  static String getName(FacilityViewModel model, BuildContext context,
      List<SecondaryViewModel> secondaryViewModel) {
    switch (model.key) {
      case _kDimension:
        if (secondaryViewModel.isNotEmpty &&
            secondaryViewModel.first.noOfRoomsAndName.isNotEmpty) {
          return getTranslated(context, AppLocalizationsStrings.squareMeters)
                  .replaceAll("#", model.value.split(" ").first) +
              secondaryViewModel.first.noOfRoomsAndName
                  .split(" ")
                  .first
                  .addOpeningParenthesis()
                  .addTrailingSpace() +
              getTranslated(context, AppLocalizationsStrings.bedroom)
                  .addClosingParenthesis();
        } else {
          return getTranslated(context, AppLocalizationsStrings.squareMeters)
              .replaceAll("#", model.value.split(" ").first);
        }
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
      case _kMaxAdults:
        return getTranslated(context, AppLocalizationsStrings.maxAdult)
            .replaceAll("#", model.value);
      default:
        return "";
    }
  }

  static String getSvgIcon(String key) {
    switch (key) {
      case _kDimension:
        return _kArrowShrink;
      case _kDoubleBedFlag:
      case _kTwinBedFlag:
      case _kQueenBedFlag:
      case _kDoubleQueenBedFlag:
      case _kDoubleTwinBedFlag:
      case _kQueenTwinBedFlag:
      case _kDoubleQueenTwinBedFlag:
        return _kBedDouble;
      case _kMaxAdults:
        return _kUserIcon;
      default:
        return _kDefaultIcon;
    }
  }
}
