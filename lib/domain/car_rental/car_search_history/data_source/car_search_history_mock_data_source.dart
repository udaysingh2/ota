import 'package:ota/domain/car_rental/car_search_history/data_source/car_search_history_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_search_history/models/car_search_history_model.dart';

class CarSearchHistoryMockDataSourceImpl
    implements CarSearchHistoryRemoteDataSource {
  CarSearchHistoryMockDataSourceImpl();

  @override
  Future<CarSearchHistoryModelDomainData> getCarSearchHistoryData() async {
    await Future.delayed(const Duration(milliseconds: 1));
    return CarSearchHistoryModelDomainData.fromString(_searchHistoryResponseMock);
  }
}

String _searchHistoryResponseMock = '''
  {
    "getCarRentalRecentSearches": {
      "data": {
        "searchHistory": [
          {
            "carRental": {
              "carRecentSearchList": [
                {
                  "dataSearchType": "AUTOCOMPLETE",
                  "cityId": "MA05110",
                  "countryId": "Austria",
                  "locationId": "1111999",
                  "createdDate": "2022-04-26T14:08:52.465",
                  "updatedDate": "2022-04-26T14:08:52.465",
                  "searchKey": "xlocation5"
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
  ''';
