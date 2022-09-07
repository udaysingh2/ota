import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_view_model.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/view_model/car_booking_detail_view_model.dart';

const String _kExclamationIcon = "assets/images/icons/exclamation_circle1.svg";
const String _kNoOfSeatIcon = 'assets/images/icons/users_alt.svg';
const String _kNoOfDoorsIcon = 'assets/images/icons/car_door_icon.svg';
const String _kAutomaticIcon = 'assets/images/icons/car_automatic_icon.svg';
const String _kNoOfBagsIcon = 'assets/images/icons/car_bag_icon.svg';
const String _kLocationPlaceholder =
    'assets/images/icons/location_suggestion.svg';
const String _kTimePlaceholder = 'assets/images/icons/uil_clock-three.svg';
const String _kAotomaticType = 'A';

class CarBookingDetailHelper {
  static CarDetailInfoDataViewModel getCarDetailInfo(
      CarBookingDetailModel? carBookingDetails, BuildContext context) {
    CarDetailInfoPricing pricing = CarDetailInfoPricing(
      costPerDay: '',
      totalCost: '',
    );
    CounterModel? pickupCounter = carBookingDetails?.pickupCounter;
    CounterModel? returnCounter = carBookingDetails?.returnCounter;
    CarModel? car = carBookingDetails?.car;
    SupplierModel? supplier = carBookingDetails?.supplier;
    String engine = car?.engine ?? "";
    if (engine.isNotEmpty) {
      NumberFormat numFormat = NumberFormat.decimalPattern('en_us');
      engine = numFormat.format(int.tryParse(engine));
    } else {
      engine = '0';
    }
    engine =
        "${engine.addTrailingSpace()}${getTranslated(context, AppLocalizationsStrings.cc)}.";

    return CarDetailInfoDataViewModel(
      pricing: pricing,
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
      pickupLocation: LocationModel(
          lattitude: pickupCounter?.latitude,
          longitude: pickupCounter?.longitude),
      dropOffLocation: LocationModel(
          lattitude: returnCounter?.latitude,
          longitude: returnCounter?.longitude),
    );
  }
}
