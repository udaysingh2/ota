import 'package:ota/domain/car_rental/car_landing/models/landing_recent_search_domain_model.dart';
import 'package:ota/domain/car_rental/car_landing/models/clear_recent_search_domain_model.dart';

import 'car_landing_remote_data_source.dart';

class CarLandingMockDataSourceImpl implements CarLandingRemoteDataSource {
  CarLandingMockDataSourceImpl();
  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<LandingRecentSearchDomainModel> getRecentSearches(
      String serviceType, String dataSearchType) async {
    await Future.delayed(const Duration(seconds: 1));
    return LandingRecentSearchDomainModel.fromJson(_responseMock);
  }

  @override
  Future<ClearRecentSearchDomainModel> clearRecentSearch(
      String serviceType, String dataSearchType) async {
    await Future.delayed(const Duration(seconds: 1));
    return ClearRecentSearchDomainModel.fromJson(resMock);
  }
}

var resMock = '''{
    "status": {
        "code": "2000",
        "header": "ความสำเร็จ"
    }
}
 ''';

var _responseMock = '''
{
  "data": {
    "getCarRentalRecentSearches": {
      "data": {
        "searchHistory": [
          {
            "carRental": {
              "carRecentSearchList": [
                {
                  "age": 30,
                  "pickupLocationId": "MA028107839914",
                  "pickupLocationName": "Chiang Mai 11International",
                  "returnLocationName" :"Chiang Mai 11International",
                  "pickupTime": "10:00:00",
                  "returnTime": "15:00:00",
                  "returnLocationId": "MA08030095",
                  "pickupDate": "2022-05-01",
                  "returnDate": "2022-05-03"
                },
                {
                  "age": 30,
                  "pickupLocationId": "MA028107839914",
                  "pickupLocationName": "International",
                  "returnLocationName" :"Chiang Mai ",
                  "pickupTime": "10:00:00",
                  "returnTime": "15:00:00",
                  "returnLocationId": "MA08030095",
                  "pickupDate": "2022-05-01",
                  "returnDate": "2022-05-03"
                }
              ]
            }
          }
        ]
      },
      "status": {
        "code": "1000",
        "header": "Success"
      }
    }
  }
}
''';
