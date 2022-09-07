import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_detail/view_model/car_detail_view_model.dart';
import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_view_model.dart';

import '../../../../core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import '../../../../domain/car_rental/car_detail/model/car_detail_domain_model.dart';

const String _kExclamationIcon = "assets/images/icons/uil_info-circle.svg";
const String _kNoOfSeatIcon = 'assets/images/icons/users_alt.svg';
const String _kNoOfDoorsIcon = 'assets/images/icons/car_door_icon.svg';
const String _kAutomaticIcon = 'assets/images/icons/car_automatic_icon.svg';
const String _kNoOfBagsIcon = 'assets/images/icons/car_bag_icon.svg';
const String _kLocationPlaceholder =
    'assets/images/icons/location_suggestion.svg';
const String _kTimePlaceholder = 'assets/images/icons/uil_clock-three.svg';
const String _kAotomaticType = 'A';

class CarDetailHelper {
  static CarDetailsInfoDataViewModel getCarDetailInfo(
    CarDetailModel? carDetail,
    BuildContext context,
  ) {
    double? pricePerDay = carDetail?.pricePerDay;
    double? totalPrice = carDetail?.totalPrice;
    CounterModel? pickupCounter = carDetail?.pickupCounter;
    CounterModel? returnCounter = carDetail?.returnCounter;
    CarModel? car = carDetail?.car;
    SuplierModel? supplier = carDetail?.supplier;
    String engine = car?.engine ?? "";
    if (engine.isNotEmpty) {
      NumberFormat numFormat = NumberFormat.decimalPattern('en_us');
      engine = numFormat.format(int.tryParse(engine));
    } else {
      engine = '0';
    }
    engine =
        "${engine.addTrailingSpace()}${getTranslated(context, AppLocalizationsStrings.cc)}.";

    return CarDetailsInfoDataViewModel(
      pricing: CarDetailInfoPricing(
        costPerDay: pricePerDay == null ? '' : pricePerDay.toString(),
        totalCost: totalPrice == null ? '' : totalPrice.toString(),
      ),
      carDetailsPickUp: [
        CarDetailInfoCell(
          imagePath: _kLocationPlaceholder,
          subTitle: pickupCounter?.locationName ?? "",
          title: getTranslated(context, AppLocalizationsStrings.carPickupPoint),
        ),
        CarDetailInfoCell(
          imagePath: _kLocationPlaceholder,
          subTitle: pickupCounter?.description ?? "",
          isHtmlField: true,
          title:
              getTranslated(context, AppLocalizationsStrings.carMeetingPoint),
        ),
        CarDetailInfoCell(
          imagePath: _kLocationPlaceholder,
          subTitle: pickupCounter?.address ?? "",
          isHtmlField: true,
          title: getTranslated(context, AppLocalizationsStrings.address),
        ),
        CarDetailInfoCell(
          imagePath: _kTimePlaceholder,
          subTitle: "${pickupCounter?.opentime} - ${pickupCounter?.closetime} ",
          title: getTranslated(context, AppLocalizationsStrings.openingHours),
        ),
      ],
      carDetailsDropOff: [
        CarDetailInfoCell(
          imagePath: _kLocationPlaceholder,
          subTitle: returnCounter?.locationName ?? "",
          title: getTranslated(context, AppLocalizationsStrings.dropOffPoint),
        ),
        CarDetailInfoCell(
          imagePath: _kLocationPlaceholder,
          subTitle: returnCounter?.description ?? "",
          isHtmlField: true,
          title:
              getTranslated(context, AppLocalizationsStrings.carMeetingPoint),
        ),
        CarDetailInfoCell(
          imagePath: _kLocationPlaceholder,
          subTitle: returnCounter?.address ?? "",
          isHtmlField: true,
          title: getTranslated(context, AppLocalizationsStrings.address),
        ),
        CarDetailInfoCell(
          imagePath: _kTimePlaceholder,
          subTitle: "${returnCounter?.opentime} - ${returnCounter?.closetime} ",
          title: getTranslated(context, AppLocalizationsStrings.openingHours),
        ),
      ],
      carDetails: [
        CarDetailInfoCell(
          imagePath: _kExclamationIcon,
          subTitle: car?.crafttype ?? "",
          title: getTranslated(context, AppLocalizationsStrings.carType),
        ),
        CarDetailInfoCell(
          imagePath: _kNoOfSeatIcon,
          subTitle: (car?.seatNbr ?? "") +
              getTranslated(context, AppLocalizationsStrings.carRentalOnlySeats)
                  .addLeadingSpace(),
          title: getTranslated(context, AppLocalizationsStrings.seats),
        ),
        CarDetailInfoCell(
          imagePath: _kNoOfDoorsIcon,
          subTitle: (car?.doorNbr ?? "") +
              getTranslated(context, AppLocalizationsStrings.carRentalOnlyDoors)
                  .addLeadingSpace(),
          title: getTranslated(context, AppLocalizationsStrings.noOfDoors),
        ),
        if (car?.bagLargeNbr != "0")
          CarDetailInfoCell(
            imagePath: _kNoOfBagsIcon,
            subTitle: (car?.bagLargeNbr ?? "") +
                getTranslated(
                        context, AppLocalizationsStrings.carRentalOnlyBags)
                    .addLeadingSpace(),
            title:
                getTranslated(context, AppLocalizationsStrings.noOfLargeBags),
          ),
        if (car?.bagSmallNbr != "0")
          CarDetailInfoCell(
            imagePath: _kNoOfBagsIcon,
            subTitle: (car?.bagSmallNbr ?? "") +
                getTranslated(
                        context, AppLocalizationsStrings.carRentalOnlyBags)
                    .addLeadingSpace(),
            title:
                getTranslated(context, AppLocalizationsStrings.noOfSmallBags),
          ),
        CarDetailInfoCell(
          imagePath: _kAutomaticIcon,
          subTitle: getTranslated(
              context,
              (car?.gear ?? "") == _kAotomaticType
                  ? AppLocalizationsStrings.automatic
                  : AppLocalizationsStrings.manual),
          title: getTranslated(context, AppLocalizationsStrings.gearSysyem),
        ),
        CarDetailInfoCell(
          imagePath: _kExclamationIcon,
          subTitle: car?.fuelType ?? "",
          title: getTranslated(context, AppLocalizationsStrings.fuel),
        ),
        CarDetailInfoCell(
          imagePath: _kExclamationIcon,
          subTitle: engine,
          title: getTranslated(context, AppLocalizationsStrings.engine),
        ),
        CarDetailInfoCell(
          imagePath: _kExclamationIcon,
          subTitle: car?.year ?? "",
          title: getTranslated(context, AppLocalizationsStrings.carYear),
        ),
      ],
      carInfo: CarDetailInfoCarMainData(
        title: supplier?.name ?? "",
        imagePath: supplier?.logo ?? "",
      ),
    );
  }

  static List<OtaFreeFoodPromotionModel> generatePromotion(
      List<Promotion>? promotions) {
    List<OtaFreeFoodPromotionModel> freeFoodPromotionList = [];
    if (promotions == null || promotions.isEmpty) {
      return freeFoodPromotionList;
    }
    for (int i = 0; i < promotions.length; i++) {
      freeFoodPromotionList.add(OtaFreeFoodPromotionModel(
        headerText: promotions[i].title ?? "",
        subHeaderText: promotions[i].description ?? "",
        headerIcon: promotions[i].iconImage ?? "",
        deepLinkUrl: promotions[i].web ?? "",
        line1: promotions[i].line1 ?? "",
      ));
    }
    return freeFoodPromotionList;
  }
}
