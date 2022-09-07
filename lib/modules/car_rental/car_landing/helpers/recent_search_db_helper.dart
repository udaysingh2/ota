import 'package:ota/core_pack/persistence/hive/boxes.dart';
import 'package:ota/modules/car_rental/car_landing/db_models/car_recent_search_model.dart';
import 'package:ota/modules/car_rental/car_landing/helpers/string_to_date.dart';

import '../../../../core/app_config.dart';

class CarSearchDBHelper {
  static List<CarRecentSearchData> getCarRecentSearchData() =>
      OTAHiveBoxes.getRecentSearches()
          .values
          .toList()
          .cast<CarRecentSearchData>()
          .where((element) =>
              element.languageCode == AppConfig().appLocale.languageCode)
          .where((element) => DateTime.now().isBefore(
              StringToDate.getDateFromString(
                  element.pickupDate, element.pickupTime)))
          .toList();

  static List<CarRecentSearchData> getCarRecentSearchDataForSync() =>
      OTAHiveBoxes.getRecentSearches()
          .values
          .toList()
          .cast<CarRecentSearchData>();

  static void saveCarRecentSearchData(
      CarRecentSearchData carRecentSearchData) async {
    await OTAHiveBoxes.getRecentSearches().add(carRecentSearchData);
  }

  static void remove(CarRecentSearchData carRecentSearchData) {
    carRecentSearchData.delete();
  }

  static void removeAll() {
    getCarRecentSearchData().forEach((element) {
      element.delete();
    });
  }
}
