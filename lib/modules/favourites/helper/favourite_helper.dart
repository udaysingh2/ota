import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/domain/favourites/models/favourites_all_model_domain.dart';
import 'package:ota/domain/favourites/models/favourites_carrental_model_domain.dart';
import 'package:ota/domain/favourites/models/favourites_model_domain.dart';
import 'package:ota/domain/favourites/models/favourites_result_model_domain.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_options/favourites_options_model.dart';

const String _kOverlay = "OVERLAY";
const _kLocationIconAsset = "assets/images/icons/travel_location_company.svg";
const _kCarIconAsset = "assets/images/icons/car_sideview.svg";
const _kTourIcon = 'assets/images/icons/tour_icon.svg';
const _kTicketIcon = 'assets/images/icons/uil_ticket.svg';
const _kHotelKey = "hotel_key";
const _kTourKey = "tour_key";
const _kCarKey = "car_key";
const _kFlightKey = "flights_key";
const _kAllKey = "all_key";

class FavouriteHelper {
  static List<String> getFavouritesOptionsKeyList(String favouritesOptions) {
    List<String> favouritesOptionsKeyList = favouritesOptions.split(',');
    List<String> optionsKeyList = [];
    for (int i = 0; i < favouritesOptionsKeyList.length; i++) {
      String option = favouritesOptionsKeyList.elementAt(i);
      if (option == _kHotelKey ||
          option == _kTourKey ||
          option == _kCarKey ||
          option == _kFlightKey ||
          option == _kAllKey) {
        optionsKeyList.add(option);
      }
    }
    return optionsKeyList;
  }

  static String getServiceType(String serviceKey) {
    Map<String, dynamic> serviceType = {
      _kHotelKey: 'HOTEL',
      _kTourKey: 'TOUR',
      _kCarKey: 'CARRENTAL',
      _kFlightKey: 'FLIGHTS',
      _kAllKey: 'ALL'
    };
    return serviceType[serviceKey];
  }

  static String getServiceTitle(String serviceKey) {
    Map<String, dynamic> serviceType = {
      _kHotelKey: AppLocalizationsStrings.allServicesAccommodation,
      _kTourKey: AppLocalizationsStrings.toursAndTravelService,
      _kCarKey: AppLocalizationsStrings.allServicesCar,
      _kFlightKey: AppLocalizationsStrings.flightService,
      _kAllKey: AppLocalizationsStrings.allServices
    };
    return serviceType[serviceKey];
  }

  static FavouriteService getServiceKey(String serviceKey) {
    Map<String, dynamic> serviceType = {
      _kHotelKey: FavouriteService.hotel,
      _kTourKey: FavouriteService.toursAndTickets,
      _kCarKey: FavouriteService.carRental,
      _kFlightKey: FavouriteService.flights,
      _kAllKey: FavouriteService.all,
    };
    if (serviceType[serviceKey] != null) {
      return serviceType[serviceKey];
    } else {
      return FavouriteService.none;
    }
  }

  static FavouriteService getServiceTypeKey(String serviceKey) {
    Map<String, dynamic> serviceType = {
      "HOTEL": FavouriteService.hotel,
      "TOUR": FavouriteService.tour,
      "TICKET": FavouriteService.tickets,
      "ALL": FavouriteService.all,
      "CARRENTAL": FavouriteService.carRental,
      "FLIGHTS": FavouriteService.flights,
    };
    if (serviceType[serviceKey] != null) {
      return serviceType[serviceKey];
    } else {
      return FavouriteService.none;
    }
  }

  static String getServiceTypeString(String serviceKey) {
    Map<String, dynamic> serviceType = {
      'HOTEL': "hotel_key",
      'TOUR': "activity_label",
      'TICKET': "ticket",
      'CARRENTAL': "car_key",
      'FLIGHTS': "flights_key",
      'ALL': "all_key",
    };
    return serviceType[serviceKey];
  }

  static String getSvg(String serviceKey) {
    Map<String, dynamic> serviceType = {
      'HOTEL': _kLocationIconAsset,
      'TOUR': _kTourIcon,
      'TICKET': _kTicketIcon,
      'CARRENTAL': _kCarIconAsset,
      'FLIGHTS': "flights_key",
      'ALL': "landing_services_label",
    };
    return serviceType[serviceKey];
  }

  static bool isAllFavoritesEnabled() {
    return AppConfig().configModel.allFavoritesEnabled.toLowerCase() == "true";
  }

  static String getFavouriteOptionString() {
    String optionsKey = AppConfig().configModel.otaServices;
    if (isAllFavoritesEnabled()) {
      optionsKey = "all_key,$optionsKey";
    }
    return optionsKey;
  }

  static String getOptionString() {
    String optionsKey = AppConfig().configModel.otaServices;
    return optionsKey;
  }

  static String getAdminPromotionLine1(List<PromotionList> promotionList) {
    for (int i = 0; i < promotionList.length; i++) {
      if (promotionList[i].promotionType == _kOverlay) {
        return promotionList[i].line1 ?? '';
      }
    }
    return '';
  }

  static String getAdminPromotionLine2(List<PromotionList> promotionList) {
    for (int i = 0; i < promotionList.length; i++) {
      if (promotionList[i].promotionType == _kOverlay) {
        return promotionList[i].line2 ?? '';
      }
    }
    return '';
  }

  static String getHotelAdminPromotionLine1(
      List<HotelPromotionList> promotionList) {
    for (int i = 0; i < promotionList.length; i++) {
      if (promotionList[i].promotionType == _kOverlay) {
        return promotionList[i].line1 ?? '';
      }
    }
    return '';
  }

  static String getHotelAdminPromotionLine2(
      List<HotelPromotionList> promotionList) {
    for (int i = 0; i < promotionList.length; i++) {
      if (promotionList[i].promotionType == _kOverlay) {
        return promotionList[i].line2 ?? '';
      }
    }
    return '';
  }

  static String getCarAdminPromotionLine1(List<PromotionList> promotionList) {
    for (int i = 0; i < promotionList.length; i++) {
      return promotionList[i].line1 ?? '';
    }
    return '';
  }

  static String getCarAdminPromotionLine2(List<PromotionList> promotionList) {
    for (int i = 0; i < promotionList.length; i++) {
      return promotionList[i].line2 ?? '';
    }
    return '';
  }

  static String getAdminCarPromotionLine1(
      List<CarPromotionList> promotionList) {
    for (int i = 0; i < promotionList.length; i++) {
      if (promotionList[i].promotionType == _kOverlay) {
        return promotionList[i].line1 ?? '';
      }
    }
    return '';
  }

  static String getAdminCarPromotionLine2(
      List<CarPromotionList> promotionList) {
    for (int i = 0; i < promotionList.length; i++) {
      if (promotionList[i].promotionType == _kOverlay) {
        return promotionList[i].line2 ?? '';
      }
    }
    return '';
  }

  static String getAdminAllPromotionLine1(
      List<AllPromotionList> promotionList) {
    for (int i = 0; i < promotionList.length; i++) {
      if (promotionList[i].promotionType == _kOverlay) {
        return promotionList[i].line1 ?? '';
      }
    }
    return '';
  }

  static String getAdminAllPromotionLine2(
      List<AllPromotionList> promotionList) {
    for (int i = 0; i < promotionList.length; i++) {
      if (promotionList[i].promotionType == _kOverlay) {
        return promotionList[i].line2 ?? '';
      }
    }
    return '';
  }
}
