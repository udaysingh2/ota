import 'package:ota/domain/tours/search/data_source/tour_search_remote_data_source.dart';
import 'package:ota/domain/tours/search/model/tour_search_history_model_domain.dart';

class TourSearchMockDataSourceImpl implements TourSearchRemoteDataSource {
  TourSearchMockDataSourceImpl();

  @override
  Future<TourSearchHistoryModelDomain> getTourSearchHistoryData() async {
    await Future.delayed(const Duration(milliseconds: 1));
    return TourSearchHistoryModelDomain.fromJson(_searchHistoryResponseMock);
  }
}

String _searchHistoryResponseMock = '''
	{
    "getTourAndTicketRecentSearches": {
      "data": {
      "searchHistory": [
      {
        "serviceType": "TOUR",
        "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
        "countryId": "MA05110001",
        "cityId": "MA05110041",
        "placeId": "MA2110000413",
        "locationName": ""
      },
      {
        "serviceType": "TICKET",
        "keyword": "Dream World(Hello We Sell Tour & Ticket)",
        "countryId": "MA05110001",
        "cityId": "MA05110041",
        "placeId": "MA2111000168",
        "locationName": ""
      }
      ,
      {
        "serviceType": "LOCATION",
        "keyword": "Rangsit-Bangkok",
        "countryId": "MA05110001",
        "cityId": "MA05110041",
        "placeId": "MA2110000413",
        "locationName": "locationName"
      }
    ]
      },
      "status": {
        "code": "1000",
        "header": "success",
        "description": ""
      }
    }
  }
  ''';
