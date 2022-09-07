import 'package:ota/domain/tours/search/data_source/tour_search_suggestions_remote_data_source.dart';
import 'package:ota/domain/tours/search/model/tour_search_suggestions_argument_domain.dart';
import 'package:ota/domain/tours/search/model/tour_search_suggestions_model_domain.dart';

class TourSearchSuggestionsMockDataSourceImpl
    implements TourSearchSuggestionsRemoteDataSource {
  TourSearchSuggestionsMockDataSourceImpl();
  int count = 0;
  @override
  Future<TourSearchSuggestionsModelDomain> getTourSearchSuggestionsData(
      TourSearchSuggestionsArgumentDomain argument) async {
    await Future.delayed(const Duration(milliseconds: 1));
    count++;
    switch (count) {
      case 0:
        return TourSearchSuggestionsModelDomain.fromJson(
            _searchSuggestionsResponseMock);
      case 1:
        return TourSearchSuggestionsModelDomain.fromJson(
            _searchSuggestionsResponseMockTwo);
      case 2:
        return TourSearchSuggestionsModelDomain.fromJson(
            _searchSuggestionsResponseMockThree);
      case 3:
        return TourSearchSuggestionsModelDomain.fromJson(
            _searchSuggestionsResponseMockFour);
      case 4:
        return TourSearchSuggestionsModelDomain.fromJson(
            _searchSuggestionsResponseMockFive);
      case 5:
        return TourSearchSuggestionsModelDomain.fromJson(
            _searchSuggestionsResponseMockSix);
    }
    return TourSearchSuggestionsModelDomain.fromJson(
        _searchSuggestionsResponseMock);
  }
}

String _searchSuggestionsResponseMock = '''
  {
    "getTourAndTicketSearchSuggestion": {
      "data": {
        "suggestions": {
          "tour": [
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            }
          ],
          "ticket": [
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            }
          ],
          "location": [
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            }
          ]
        }
      },
      "status": {
        "code": "1000",
        "header": "Success",
        "description": ""
      }
    }
  }
  ''';

String _searchSuggestionsResponseMockTwo = '''
  {
    "getTourAndTicketSearchSuggestion": {
      "data": {
        "suggestions": {
          "ticket": [
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            }
          ],
          "location": [
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            }
          ]
        }
      },
      "status": {
        "code": "1000",
        "header": "Success",
        "description": ""
      }
    }
  }
  ''';

String _searchSuggestionsResponseMockThree = '''
  {
    "getTourAndTicketSearchSuggestion": {
      "data": {
        "suggestions": {
          "tour": [
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            }
          ],
          "location": [
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            }
          ]
        }
      },
      "status": {
        "code": "1000",
        "header": "Success",
        "description": ""
      }
    }
  }
  ''';

String _searchSuggestionsResponseMockFour = '''
  {
    "getTourAndTicketSearchSuggestion": {
      "data": {
        "suggestions": {
          "tour": [
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            }
          ],
          "ticket": [
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            }
          ]
        }
      },
      "status": {
        "code": "1000",
        "header": "Success",
        "description": ""
      }
    }
  }
  ''';

String _searchSuggestionsResponseMockFive = '''
  {
    "getTourAndTicketSearchSuggestion": {
      "data": {
        "suggestions": {
         }
      },
      "status": {
        "code": "1000",
        "header": "Success",
        "description": ""
      }
    }
  }
  ''';
String _searchSuggestionsResponseMockSix = '''
  {
    "getTourAndTicketSearchSuggestion": {
      "data": {
        "suggestions": null
      },
      "status": {
        "code": "1000",
        "header": "Success",
        "description": ""
      }
    }
  }
  ''';
