import 'package:ota/domain/car_rental/car_save_search_history/models/car_save_search_argument_domain.dart';

class QueriesCarSaveSearchHistory {
  static String saveSearchHistoryData(
      CarSaveSearchHistoryArgumentDomain argument) {
    return '''
mutation saveRecentCarRentalSearchHistory {
  saveRecentCarRentalSearchHistory(
    searchRequest: {
      searchKey: "${argument.searchKey}"
      car: {
        cityId: "${argument.cityId}"
        locationId: "${argument.locationId}"
        countryId: "${argument.countryId}"
        dataSearchType: "AUTOCOMPLETE"
      }
    }
  ) {
    status {
      code
      header
    }
  }
}
    ''';
  }
}
