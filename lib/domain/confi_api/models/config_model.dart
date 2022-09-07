import 'package:ota/domain/confi_api/models/config_constant.dart';
import 'package:ota/domain/confi_api/models/config_result_model.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';

class ConfigModel {
  final int imagesCount;
  final int coverImagesCount;
  final int galleryImagesCount;
  final int maxChildrenAllowed;
  final int maxAdultsAllowed;
  final int maxChildAge;
  final int maxRoom;
  final int maxGuestsAllowed;
  final int timeoutDuration;
  final int splashScreenDuration;
  final int calendarMinDate;
  final int carouselCardLimit;
  final int timerValue;
  final double netPriceBoundaryInBaht;
  final int paymentWaitingTimesInMin;
  final String? loadingImageUrl;
  final String guestUsername;
  final String paymentConfirmationRecommendations;
  final int paymentStatusTimeIntervalInSec;
  final String otaServices;
  final String otaSearchServicesEnabled;
  final int processingFee;
  final int defaultAdultCount;
  final int defaultChildCount;
  final int seatAvailabilityThresholdMin;
  final String allFavoritesEnabled;
  final String firebaseEnabled;
  final String appFlyerEnabled;
  final String robinHoodPhoneNumber;
  final String scbEasyDefaultDeepLink;
  final String countryListEnglish;
  final String countryListThai;
  final String tourCancellationPercent;
  final String ticketCancellationPercent;
  final int checkInDeltaHotel;
  final int checkOutDeltaHotel;
  final int carDriverDefaultAge;
  final int carDriverMinAge;
  final int carDriverMaxAge;
  final int pickUpDeltaCar;
  final int dropOffDeltaCar;
  final String freeFoodDeliveryUrlHotel;
  final String freeFoodDeliveryUrlHotelTh;
  final String guestUsernameTh;
  final String includeDriver;
  final String pickupCounter;
  final String returnCounter;
  final String carRentalShareTitle;
  final String carCancelPolicyConfigLine;
  final String defaultFilterSortCriteria;
  final String tourShareTitle;
  final String ticketShareTitle;
  final String hotelShareTitle;
  final String bedTypes;
  final String defaultBedType;
  final int bedTypeMaxAdults;
  final double defaultLatitude;
  final double defaultLongitude;
  final int hotelSearchSuggestionMaxLimit;
  final int otaSearchSuggestionMaxLimit;
  final String otaVirtualAccEnable;

  ConfigModel({
    required this.imagesCount,
    required this.coverImagesCount,
    required this.galleryImagesCount,
    required this.maxChildrenAllowed,
    required this.maxAdultsAllowed,
    required this.maxChildAge,
    required this.maxRoom,
    required this.maxGuestsAllowed,
    required this.timeoutDuration,
    required this.splashScreenDuration,
    required this.calendarMinDate,
    required this.carouselCardLimit,
    this.loadingImageUrl,
    required this.guestUsername,
    required this.paymentConfirmationRecommendations,
    required this.netPriceBoundaryInBaht,
    required this.paymentWaitingTimesInMin,
    required this.timerValue,
    required this.paymentStatusTimeIntervalInSec,
    required this.otaServices,
    required this.otaSearchServicesEnabled,
    required this.processingFee,
    required this.defaultAdultCount,
    required this.defaultChildCount,
    required this.seatAvailabilityThresholdMin,
    required this.allFavoritesEnabled,
    required this.firebaseEnabled,
    required this.appFlyerEnabled,
    required this.robinHoodPhoneNumber,
    required this.scbEasyDefaultDeepLink,
    required this.countryListEnglish,
    required this.countryListThai,
    required this.tourCancellationPercent,
    required this.ticketCancellationPercent,
    required this.checkInDeltaHotel,
    required this.checkOutDeltaHotel,
    required this.carDriverDefaultAge,
    required this.carDriverMaxAge,
    required this.carDriverMinAge,
    required this.pickUpDeltaCar,
    required this.dropOffDeltaCar,
    required this.freeFoodDeliveryUrlHotel,
    required this.freeFoodDeliveryUrlHotelTh,
    required this.guestUsernameTh,
    required this.includeDriver,
    required this.pickupCounter,
    required this.returnCounter,
    required this.carRentalShareTitle,
    required this.carCancelPolicyConfigLine,
    required this.defaultFilterSortCriteria,
    required this.tourShareTitle,
    required this.ticketShareTitle,
    required this.hotelShareTitle,
    required this.bedTypes,
    required this.defaultBedType,
    required this.bedTypeMaxAdults,
    required this.defaultLatitude,
    required this.defaultLongitude,
    required this.hotelSearchSuggestionMaxLimit,
    required this.otaSearchSuggestionMaxLimit,
    required this.otaVirtualAccEnable,
  });

  factory ConfigModel.fromModel(List<Datum> data) => ConfigModel(
      imagesCount: _getConfigIntValue(
          data, ConfigString.imagesCount, ConfigConst.imagesCount),
      coverImagesCount: _getConfigIntValue(
          data, ConfigString.coverImagesCount, ConfigConst.coverImagesCount),
      galleryImagesCount: _getConfigIntValue(data,
          ConfigString.galleryImagesCount, ConfigConst.galleryImagesCount),
      maxChildrenAllowed: _getConfigIntValue(data,
          ConfigString.maxChildrenAllowed, ConfigConst.maxChildrenAllowed),
      maxAdultsAllowed: _getConfigIntValue(
          data, ConfigString.maxAdultsAllowed, ConfigConst.maxAdultsAllowed),
      maxChildAge: _getConfigIntValue(
          data, ConfigString.maxChildAge, ConfigConst.maxChildAge),
      maxRoom:
          _getConfigIntValue(data, ConfigString.maxRoom, ConfigConst.maxRoom),
      maxGuestsAllowed: _getConfigIntValue(
          data, ConfigString.maxGuestsAllowed, ConfigConst.maxGuestsAllowed),
      timeoutDuration: _getConfigIntValue(
          data, ConfigString.timeoutDuration, ConfigConst.timeoutDuration),
      splashScreenDuration: _getConfigIntValue(data,
          ConfigString.splashScreenDuration, ConfigConst.splashScreenDuration),
      calendarMinDate: _getConfigIntValue(
          data, ConfigString.calendarMinDate, ConfigConst.calendarMinDate),
      carouselCardLimit: _getConfigIntValue(
          data, ConfigString.carouselCardLimit, ConfigConst.carouselCardLimit),
      loadingImageUrl:
          _getConfigStringValue(data, ConfigString.loadingImageUrl, ""),
      guestUsername: _getConfigStringValue(
          data, ConfigString.guestUsername, ConfigConst.guestUsername),
      paymentConfirmationRecommendations: _getConfigStringValue(
          data,
          ConfigString.paymentConfirmationRecommendations,
          ConfigConst.paymentConfirmationRecommendations),
      paymentWaitingTimesInMin: _getConfigIntValue(
          data,
          ConfigString.paymentWaitingTimesInMin,
          ConfigConst.paymentWaitingTimesInMin),
      netPriceBoundaryInBaht: _getConfigDoubleValue(
          data,
          ConfigString.netPriceBoundaryInBaht,
          ConfigConst.netPriceBoundaryInBaht),
      timerValue: _getConfigIntValue(
          data, ConfigString.timerValue, ConfigConst.timerValue),
      paymentStatusTimeIntervalInSec: _getConfigIntValue(
          data,
          ConfigString.paymentStatusTimeIntervalInSec,
          ConfigConst.paymentStatusTimeIntervalInSec),
      otaServices: _getConfigStringValue(
          data, ConfigString.otaServices, ConfigConst.otaServices),
      otaSearchServicesEnabled: _getConfigStringValue(
          data,
          ConfigString.otaSearchServicesEnabled,
          ConfigConst.otaSearchServicesEnabled),
      processingFee: _getConfigIntValue(
          data, ConfigString.processingFee, ConfigConst.processingFee),
      defaultAdultCount: _getConfigIntValue(
          data, ConfigString.defaultAdultCount, ConfigConst.defaultAdultCount),
      defaultChildCount: _getConfigIntValue(data, ConfigString.defaultChildCount, ConfigConst.defaultChildCount),
      seatAvailabilityThresholdMin: _getConfigIntValue(data, ConfigString.seatAvailabilityThresholdMin, ConfigConst.seatAvailabilityThresholdMin),
      allFavoritesEnabled: _getConfigStringValue(data, ConfigString.allFavoritesEnabled, ConfigConst.allFavoritesEnabled),
      firebaseEnabled: _getConfigStringValue(data, ConfigString.firebaseEnabled, ConfigConst.firebaseEnabled),
      appFlyerEnabled: _getConfigStringValue(data, ConfigString.appFlyerEnabled, ConfigConst.appFlyerEnabled),
      robinHoodPhoneNumber: _getConfigStringValue(data, ConfigString.robinHoodPhoneNumber, ConfigConst.robinHoodPhoneNumber),
      scbEasyDefaultDeepLink: _getConfigStringValue(data, ConfigString.scbEasyDefaultDeepLink, ConfigConst.scbEasyDefaultDeepLink),
      countryListEnglish: _getConfigStringValue(data, ConfigString.countryListEnglish, ConfigConst.countryListEnglish),
      countryListThai: _getConfigStringValue(data, ConfigString.countryListThai, ConfigConst.countryListThai),
      tourCancellationPercent: _getConfigStringValue(data, ConfigString.tourCancellationPercent, ConfigConst.tourCancellationPercent),
      ticketCancellationPercent: _getConfigStringValue(data, ConfigString.ticketCancellationPercent, ConfigConst.ticketCancellationPercent),
      checkInDeltaHotel: _getConfigIntValue(data, ConfigString.checkInDeltaHotel, ConfigConst.checkInDeltaHotel),
      checkOutDeltaHotel: _getConfigIntValue(data, ConfigString.checkOutDeltaHotel, ConfigConst.checkOutDeltaHotel),
      freeFoodDeliveryUrlHotel: _getConfigStringValue(data, ConfigString.freeFoodDeliveryUrlHotel, ConfigConst.freeFoodDeliveryUrlHotel),
      freeFoodDeliveryUrlHotelTh: _getConfigStringValue(data, ConfigString.freeFoodDeliveryUrlHotelTh, ConfigConst.freeFoodDeliveryUrlHotelTh),
      guestUsernameTh: _getConfigStringValue(data, ConfigString.guestUsernameTh, ConfigConst.guestUsernameTh),
      carDriverDefaultAge: _getConfigIntValue(data, ConfigString.carDriverDefaultAge, ConfigConst.carDriverDefaultAge),
      carDriverMinAge: _getConfigIntValue(data, ConfigString.carDriverMinAge, ConfigConst.carDriverMinAge),
      carDriverMaxAge: _getConfigIntValue(data, ConfigString.carDriverMaxAge, ConfigConst.carDriverMaxAge),
      pickUpDeltaCar: _getConfigIntValue(data, ConfigString.pickUpDeltaCar, ConfigConst.pickUpDeltaCar),
      dropOffDeltaCar: _getConfigIntValue(data, ConfigString.dropOffDeltaCar, ConfigConst.dropOffDeltaCar),
      defaultFilterSortCriteria: _getConfigStringValue(data, ConfigString.defaultFilterSortCriteria, ConfigConst.defaultFilterSortCriteria),
      tourShareTitle: _getConfigStringValue(data, ConfigString.tourShareTitle, ConfigConst.tourShareTitle),
      ticketShareTitle: _getConfigStringValue(data, ConfigString.ticketShareTitle, ConfigConst.tourShareTitle),
      hotelShareTitle: _getConfigStringValue(data, ConfigString.hotelShareTitle, ConfigConst.hotelShareTitle),
      includeDriver: _getConfigStringValue(data, ConfigString.includeDriver, ConfigConst.includeDriver),
      pickupCounter: _getConfigStringValue(data, ConfigString.pickupCounter, ConfigConst.pickupCounter),
      returnCounter: _getConfigStringValue(data, ConfigString.returnCounter, ConfigConst.returnCounter),
      carRentalShareTitle: _getConfigStringValue(data, ConfigString.carRentalShareTitle, ConfigConst.carRentalShareTitle),
      bedTypes: _getConfigStringValue(data, ConfigString.bedTypes, ConfigConst.bedTypes),
      defaultBedType: _getConfigStringValue(data, ConfigString.defaultBedType, ConfigConst.defaultBedType),
      bedTypeMaxAdults: _getConfigIntValue(data, ConfigString.bedTypeMaxAdults, ConfigConst.bedTypeMaxAdults),
      defaultLatitude: _getConfigDoubleValue(data, ConfigString.defaultLatitude, ConfigConst.defaultLatitude),
      defaultLongitude: _getConfigDoubleValue(data, ConfigString.defaultLongitude, ConfigConst.defaultLongitude),
      hotelSearchSuggestionMaxLimit: _getConfigIntValue(data, ConfigString.hotelSearchSuggestionMaxLimit, ConfigConst.hotelSearchSuggestionMaxLimit),
      otaSearchSuggestionMaxLimit: _getConfigIntValue(data, ConfigString.otaSearchSuggestionMaxLimit, ConfigConst.otaSearchSuggestionMaxLimit),
      carCancelPolicyConfigLine: _getConfigStringValue(data, ConfigString.carCancelPolicyConfigLine, ConfigConst.carCancelPolicyConfigLine),
      otaVirtualAccEnable: _getConfigStringValue(data, ConfigString.otaVirtualAccEnable, ConfigConst.otaVirtualAccEnable));

  factory ConfigModel.defaultValue() => ConfigModel(
        imagesCount: ConfigConst.imagesCount,
        coverImagesCount: ConfigConst.coverImagesCount,
        galleryImagesCount: ConfigConst.galleryImagesCount,
        maxChildrenAllowed: ConfigConst.maxChildrenAllowed,
        maxAdultsAllowed: ConfigConst.maxAdultsAllowed,
        maxChildAge: ConfigConst.maxChildAge,
        maxRoom: ConfigConst.maxRoom,
        maxGuestsAllowed: ConfigConst.maxGuestsAllowed,
        timeoutDuration: ConfigConst.timeoutDuration,
        splashScreenDuration: ConfigConst.splashScreenDuration,
        calendarMinDate: ConfigConst.calendarMinDate,
        carouselCardLimit: ConfigConst.calendarMinDate,
        loadingImageUrl: "",
        guestUsername: ConfigConst.guestUsername,
        paymentConfirmationRecommendations:
            ConfigConst.paymentConfirmationRecommendations,
        paymentWaitingTimesInMin: ConfigConst.paymentWaitingTimesInMin,
        netPriceBoundaryInBaht: ConfigConst.netPriceBoundaryInBaht,
        timerValue: ConfigConst.timerValue,
        paymentStatusTimeIntervalInSec:
            ConfigConst.paymentStatusTimeIntervalInSec,
        otaServices: ConfigConst.otaServices,
        otaSearchServicesEnabled: ConfigConst.otaSearchServicesEnabled,
        processingFee: ConfigConst.processingFee,
        defaultAdultCount: ConfigConst.defaultAdultCount,
        defaultChildCount: ConfigConst.defaultChildCount,
        seatAvailabilityThresholdMin: ConfigConst.seatAvailabilityThresholdMin,
        allFavoritesEnabled: ConfigConst.allFavoritesEnabled,
        firebaseEnabled: ConfigConst.firebaseEnabled,
        appFlyerEnabled: ConfigConst.appFlyerEnabled,
        robinHoodPhoneNumber: ConfigConst.robinHoodPhoneNumber,
        scbEasyDefaultDeepLink: ConfigConst.scbEasyDefaultDeepLink,
        countryListEnglish: ConfigConst.countryListEnglish,
        countryListThai: ConfigConst.countryListThai,
        tourCancellationPercent: ConfigConst.tourCancellationPercent,
        ticketCancellationPercent: ConfigConst.ticketCancellationPercent,
        checkInDeltaHotel: ConfigConst.checkInDeltaHotel,
        checkOutDeltaHotel: ConfigConst.checkOutDeltaHotel,
        carDriverDefaultAge: ConfigConst.carDriverDefaultAge,
        carDriverMaxAge: ConfigConst.carDriverMaxAge,
        carDriverMinAge: ConfigConst.carDriverMinAge,
        dropOffDeltaCar: ConfigConst.dropOffDeltaCar,
        pickUpDeltaCar: ConfigConst.pickUpDeltaCar,
        freeFoodDeliveryUrlHotel: ConfigConst.freeFoodDeliveryUrlHotel,
        freeFoodDeliveryUrlHotelTh: ConfigConst.freeFoodDeliveryUrlHotelTh,
        guestUsernameTh: ConfigConst.guestUsernameTh,
        includeDriver: ConfigConst.includeDriver,
        pickupCounter: ConfigConst.pickupCounter,
        returnCounter: ConfigConst.returnCounter,
        carRentalShareTitle: ConfigConst.carRentalShareTitle,
        carCancelPolicyConfigLine: ConfigConst.carCancelPolicyConfigLine,
        defaultFilterSortCriteria: ConfigConst.defaultFilterSortCriteria,
        ticketShareTitle: ConfigConst.ticketShareTitle,
        tourShareTitle: ConfigConst.tourShareTitle,
        hotelShareTitle: ConfigConst.hotelShareTitle,
        bedTypes: ConfigConst.bedTypes,
        defaultBedType: ConfigConst.defaultBedType,
        bedTypeMaxAdults: ConfigConst.bedTypeMaxAdults,
        defaultLatitude: ConfigConst.defaultLatitude,
        defaultLongitude: ConfigConst.defaultLongitude,
        hotelSearchSuggestionMaxLimit:
            ConfigConst.hotelSearchSuggestionMaxLimit,
        otaSearchSuggestionMaxLimit: ConfigConst.otaSearchSuggestionMaxLimit,
        otaVirtualAccEnable: ConfigConst.otaVirtualAccEnable,
      );

  static double _getConfigDoubleValue(
      List<Datum> list, String name, double defaultValue) {
    Datum data = list.firstWhere((element) => element.name == name,
        orElse: () => Datum());
    if ((data.name != null && data.value != null) && data.name == name) {
      return double.tryParse(data.value!) ?? defaultValue;
    }
    return defaultValue;
  }

  static int _getConfigIntValue(
      List<Datum> list, String name, int defaultValue) {
    Datum data = list.firstWhere((element) => element.name == name,
        orElse: () => Datum());
    if ((data.name != null && data.value != null) && data.name == name) {
      return int.tryParse(data.value!) ?? defaultValue;
    }
    return defaultValue;
  }

  static String _getConfigStringValue(
      List<Datum> list, String name, String defaultValue) {
    Datum data = list.firstWhere((element) => element.name == name,
        orElse: () => Datum());
    if ((data.name != null && data.value != null) && data.name == name) {
      return data.value!;
    }
    return defaultValue;
  }

  String get freeFoodDeliveryUrlHotelLocalized =>
      getLoginProvider().getLanguage() == "EN"
          ? freeFoodDeliveryUrlHotel
          : freeFoodDeliveryUrlHotelTh;
}
