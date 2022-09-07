import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/modules/car_rental/car_landing/db_models/car_recent_search_model.dart';

class QueriesCarLandingSyncRecentSearch {
  static String syncRecentSearchData(
      List<CarRecentSearchData> dataList,
      String userId,
      String searchKey,
      bool searchAvailableApi,
      bool includeDriver) {
    return '''
  mutation{
  saveGuestRecentSearchPlaylistHistory (searchHistoryListRequest: {
      searchRequests: ${dataList.map((data) {
      return {
        "index": dataList.indexOf(data) + 1,
        "searchKey": searchKey.addTrailingComma(),
        "lang": data.languageCode.addQuote(),
        "car": {
          "pickupLocationId": data.pickupLocationId.surroundWithDoubleQuote(),
          "returnLocationId": data.returnLocationId.surroundWithDoubleQuote(),
          "pickupDate": data.pickupDate.surroundWithDoubleQuote(),
          "returnDate": data.returnDate.surroundWithDoubleQuote(),
          "pickupTime": data.pickupTime.surroundWithDoubleQuote(),
          "returnTime": data.returnTime.surroundWithDoubleQuote(),
          "age": data.age,
          "includeDriver": includeDriver,
          "dataSearchType": data.dataSearchType.surroundWithDoubleQuote(),
          "pickupLocationName":
              data.pickupLocationName.surroundWithDoubleQuote(),
          "returnLocationName":
              data.returnLocationName.surroundWithDoubleQuote(),
        }
      };
    }).toList()}
        }){
   status {
     code
     
   }
  }
}

''';
  }
}

extension StringQuote on String {
  String addQuote() {
    return '"${this}"';
  }
}
