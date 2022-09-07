import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_view_model.dart';
import 'package:ota/modules/car_rental/car_payment/view_model/car_payment_argument_view_model.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_view_model.dart';

import '../../../../core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import '../../../../domain/car_rental/car_reservation/models/car_reservation_domain_model.dart';

const String _kExclamationIcon = "assets/images/icons/uil_info-circle.svg";
const String _kNoOfSeatIcon = 'assets/images/icons/users_alt.svg';
const String _kNoOfDoorsIcon = 'assets/images/icons/car_door_icon.svg';
const String _kAutomaticIcon = 'assets/images/icons/car_automatic_icon.svg';
const String _kNoOfBagsIcon = 'assets/images/icons/car_bag_icon.svg';
const String _kLocationPlaceholder =
    'assets/images/icons/location_suggestion.svg';
const String _kTimePlaceholder = 'assets/images/icons/uil_clock-three.svg';
const String _kAotomaticType = 'A';

class CarReservationHelper {
  static CarDetailInfoDataViewModel getCarDetailInfo(
      CarDetailInfoModel? carDetail, BuildContext context) {
    double? pricePerDay = carDetail?.pricePerDay;
    double? totalPrice = carDetail?.totalPrice;
    String engine = carDetail?.engine ?? "";
    if (engine.isNotEmpty) {
      NumberFormat numFormat = NumberFormat.decimalPattern('en_us');
      engine = numFormat.format(int.tryParse(engine));
    } else {
      engine = '0';
    }
    engine =
        "${engine.addTrailingSpace()}${getTranslated(context, AppLocalizationsStrings.cc)}.";
    return CarDetailInfoDataViewModel(
      pricing: CarDetailInfoPricing(
        costPerDay: pricePerDay == null ? '' : pricePerDay.toString(),
        totalCost: totalPrice == null ? '' : totalPrice.toString(),
      ),
      carDetailsPickUp: [
        CarDetailInfoCell(
          imagePath: _kLocationPlaceholder,
          subTitle: carDetail?.pickUpLocation ?? "",
          title: getTranslated(context, AppLocalizationsStrings.carPickupPoint),
        ),
        CarDetailInfoCell(
          imagePath: _kLocationPlaceholder,
          subTitle: carDetail?.meetingPointDescription ?? "",
          isHtmlField: true,
          title: getTranslated(context, AppLocalizationsStrings.meetingPlace),
        ),
        CarDetailInfoCell(
          imagePath: _kLocationPlaceholder,
          subTitle: carDetail?.pickUpaddress ?? "",
          isHtmlField: true,
          title: getTranslated(context, AppLocalizationsStrings.address),
        ),
        CarDetailInfoCell(
          imagePath: _kTimePlaceholder,
          subTitle:
              "${carDetail?.pickUpOpenTime} - ${carDetail?.pickUpCloseTime} ",
          title: getTranslated(context, AppLocalizationsStrings.openingHours),
        ),
      ],
      carDetailsDropOff: [
        CarDetailInfoCell(
          imagePath: _kLocationPlaceholder,
          subTitle: carDetail?.returnLocation ?? "",
          title: getTranslated(context, AppLocalizationsStrings.dropOffPoint),
        ),
        CarDetailInfoCell(
          imagePath: _kLocationPlaceholder,
          subTitle: carDetail?.returnPointDescription ?? "",
          isHtmlField: true,
          title: getTranslated(context, AppLocalizationsStrings.meetingPlace),
        ),
        CarDetailInfoCell(
          imagePath: _kLocationPlaceholder,
          subTitle: carDetail?.returnAddress ?? "",
          isHtmlField: true,
          title: getTranslated(context, AppLocalizationsStrings.address),
        ),
        CarDetailInfoCell(
          imagePath: _kTimePlaceholder,
          subTitle:
              "${carDetail?.returnOpenTime} - ${carDetail?.returnCloseTime} ",
          title: getTranslated(context, AppLocalizationsStrings.openingHours),
        ),
      ],
      carDetails: [
        CarDetailInfoCell(
          imagePath: _kExclamationIcon,
          subTitle: carDetail?.crafttype ?? "",
          title: getTranslated(context, AppLocalizationsStrings.carType),
        ),
        CarDetailInfoCell(
          imagePath: _kNoOfSeatIcon,
          subTitle:
              "${carDetail?.seatNbr ?? ""}${getTranslated(context, AppLocalizationsStrings.carRentalOnlySeats).addLeadingSpace()}",
          title: getTranslated(context, AppLocalizationsStrings.seats),
        ),
        CarDetailInfoCell(
          imagePath: _kNoOfDoorsIcon,
          subTitle:
              "${carDetail?.doorNbr ?? ""}${getTranslated(context, AppLocalizationsStrings.carRentalOnlyDoors).addLeadingSpace()}",
          title: getTranslated(context, AppLocalizationsStrings.noOfDoors),
        ),
        if (carDetail?.bagLargeNbr != 0)
          CarDetailInfoCell(
            imagePath: _kNoOfBagsIcon,
            subTitle:
                "${carDetail?.bagLargeNbr ?? ""}${getTranslated(context, AppLocalizationsStrings.carRentalOnlyBags).addLeadingSpace()}",
            title:
                getTranslated(context, AppLocalizationsStrings.noOfLargeBags),
          ),
        if (carDetail?.bagSmallNbr != 0)
          CarDetailInfoCell(
            imagePath: _kNoOfBagsIcon,
            subTitle:
                "${carDetail?.bagSmallNbr ?? ""}${getTranslated(context, AppLocalizationsStrings.carRentalOnlyBags).addLeadingSpace()}",
            title:
                getTranslated(context, AppLocalizationsStrings.noOfSmallBags),
          ),
        CarDetailInfoCell(
          imagePath: _kAutomaticIcon,
          subTitle: getTranslated(
              context,
              (carDetail?.gear ?? "") == _kAotomaticType
                  ? AppLocalizationsStrings.automatic
                  : AppLocalizationsStrings.manual),
          title: getTranslated(context, AppLocalizationsStrings.gearSysyem),
        ),
        CarDetailInfoCell(
          imagePath: _kExclamationIcon,
          subTitle: carDetail?.fuelType ?? "",
          title: getTranslated(context, AppLocalizationsStrings.fuel),
        ),
        CarDetailInfoCell(
          imagePath: _kExclamationIcon,
          subTitle: engine,
          title: getTranslated(context, AppLocalizationsStrings.engine),
        ),
        CarDetailInfoCell(
          imagePath: _kExclamationIcon,
          subTitle: "${carDetail?.year ?? ""}",
          title: getTranslated(context, AppLocalizationsStrings.carYear),
        ),
      ],
      carInfo: CarDetailInfoCarMainData(
        title: carDetail?.serviceProvider ?? "",
        imagePath: carDetail?.logoUrl ?? "",
      ),
      pickupLocation: LocationsModelData(
          lattitude: carDetail?.pickUpLatitude,
          longitude: carDetail?.pickUpLongitude),
      dropOffLocation: LocationsModelData(
          lattitude: carDetail?.returnLatitude,
          longitude: carDetail?.returnLongitude),
    );
  }

  static List<OtaFreeFoodPromotionModel> generatePromotion(
      List<PromotionList>? promotions) {
    List<OtaFreeFoodPromotionModel> freeFoodPromotionList = [];
    if (promotions == null || promotions.isEmpty) {
      return freeFoodPromotionList;
    }
    for (int i = 0; i < promotions.length; i++) {
      freeFoodPromotionList.add(OtaFreeFoodPromotionModel(
        headerText: promotions[i].title ?? "",
        subHeaderText: promotions[i].description ?? "",
        headerIcon: promotions[i].image ?? "",
        deepLinkUrl: promotions[i].web ?? "",
        line1: promotions[i].line1 ?? "",
      ));
    }
    return freeFoodPromotionList;
  }
}
