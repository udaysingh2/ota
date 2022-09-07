import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const String _defaultImageId = "assets/images/icons/uil_info-circle.svg";

const String kCancellationPolicy = "cancellationPolicy";
const String kPayNow = "payNow";
const String kBreakfast = "breakfast";
const String kWifi = "WIFI";
const String kFitness = "FITNESS";
const String kAirCondition = "AIR_COND";
const String kRoomService = "ROOM_SRV";
const String kToileteries = "TOILETERIES";
const String kCdPlayer = "CD_PLAYER";
const String kWInternet = "W_INTERNET";
const String kDesk = "DESK";
const String kAlarm = "ALARM";
const String kSlippers = "SLIPPERS";
const String kFridge = "FRIDGE";
const String kKettle = "KETTLE";
const String kPhone = "PHONE";
const String kTub = "TUB";
const String kBabycot = "BABY_COT";
const String kDryer = "H_DRYER";
const String kDepositBox = "DEPOSIT_BOX";
const String kSwimming = "SWIMMING";
const String kParking = "PARKING";
const String kSpa = "SPA";
const String kLaundry = "LAUNDRY";
const String kRestaurant = "RESTAURANT";
const String kTourTime = "tourTime";
const String kTourType = "tourType";
const String kGuideLanguage = "guideLanguage";
const String kTicketTime = "ticketTime";
//update ticketType Icon
const String kTicketType = "ticketType";
const String kRefundType = "isNonRefund";
const String kRestaurants = "RESTAURANTS";
const String kSwim = "SWIM";
const String kCheckCircle = "HOTEL_BENEFITS";

class FacilityHelper {
  static final Map<String, String> _assetKey = {
    kCancellationPolicy: "assets/images/icons/uil_check-circle.svg",
    kPayNow: "assets/images/icons/price.svg",
    kBreakfast: "assets/images/icons/crockery.svg",
    kWifi: "assets/images/icons/wifi.svg",
    kFitness: "assets/images/icons/dumbbell.svg",
    kAirCondition: "",
    kRoomService: "assets/images/icons/room_service.svg",
    kToileteries: "",
    kCdPlayer: "",
    kWInternet: "",
    kDesk: "",
    kAlarm: "",
    kSlippers: "",
    kFridge: "",
    kKettle: "",
    kPhone: "",
    kTub: "",
    kBabycot: "",
    kDryer: "",
    kDepositBox: "",
    kSwimming: "assets/images/icons/swimming_pool.svg",
    kParking: "assets/images/icons/parking_circle.svg",
    kSpa: "assets/images/icons/spa.svg",
    kLaundry: "assets/images/icons/laundry_service.svg",
    kRestaurant: 'assets/images/icons/restaurant.svg',
    kTourTime: 'assets/images/icons/clock_icon.svg',
    kTourType: 'assets/images/icons/user_icon.svg',
    kGuideLanguage: 'assets/images/icons/megaphone.svg',
    kRefundType: 'assets/images/icons/uil_exclamation-circle.svg',
    kTicketTime: 'assets/images/icons/clock_icon.svg',
    kTicketType: 'assets/images/icons/user_icon.svg',
    kRestaurants: 'assets/images/icons/restaurant.svg',
    kSwim: "assets/images/icons/swimming_pool.svg",
    kCheckCircle: "assets/images/icons/check_circle.svg",
  };

  static final Map<String, String> _localizedKey = {
    kCancellationPolicy: AppLocalizationsStrings.cancellationPolicy,
    kPayNow: AppLocalizationsStrings.payNow,
    kBreakfast: AppLocalizationsStrings.breakfast,
    kWifi: AppLocalizationsStrings.wifi,
    kFitness: AppLocalizationsStrings.fitness,
    kAirCondition: AppLocalizationsStrings.airCondition,
    kRoomService: AppLocalizationsStrings.roomService,
    kToileteries: AppLocalizationsStrings.toileteries,
    kCdPlayer: AppLocalizationsStrings.cdPlayer,
    kWInternet: AppLocalizationsStrings.wInternet,
    kDesk: AppLocalizationsStrings.desk,
    kAlarm: AppLocalizationsStrings.alarm,
    kSlippers: AppLocalizationsStrings.slippers,
    kFridge: AppLocalizationsStrings.fridge,
    kKettle: AppLocalizationsStrings.kettle,
    kPhone: AppLocalizationsStrings.phone,
    kTub: AppLocalizationsStrings.tub,
    kBabycot: AppLocalizationsStrings.babycot,
    kDryer: AppLocalizationsStrings.dryer,
    kDepositBox: AppLocalizationsStrings.depositBox,
    kSwimming: AppLocalizationsStrings.swimming,
    kParking: AppLocalizationsStrings.parking,
    kSpa: AppLocalizationsStrings.spa,
    kLaundry: AppLocalizationsStrings.laundry,
    kRestaurant: AppLocalizationsStrings.restaurant,
    kRestaurants: AppLocalizationsStrings.restaurant,
    kSwim: AppLocalizationsStrings.swimming,
  };

  static bool keyExist(String assetId) {
    return _localizedKey.containsKey(assetId);
  }

  static String getAssetName(String assetId) {
    String asset = _assetKey[assetId] ?? "";
    return asset.isEmpty ? _defaultImageId : asset;
  }

  static String getLocalizedText(String assetId, BuildContext context) {
    return getTranslated(context, _localizedKey[assetId] ?? assetId);
  }
}
