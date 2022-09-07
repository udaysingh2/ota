import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_argument_model.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_model_domain.dart';

import 'car_search_suggestion_remote_data_source.dart';

class CarSearchSuggestionMockDataSourceImpl
    implements CarSearchSuggestionRemoteDataSource {
  CarSearchSuggestionMockDataSourceImpl();

  @override
  Future<CarSearchSuggestionData> getCarSearchSuggestionData(
      CarSearchSuggestionArgumentModelDomain argument) async {
    await Future.delayed(const Duration(milliseconds: 10));
    return CarSearchSuggestionData.fromJson(_responseMock);
  }

  static String getMockData() {
    return _responseMock;
  }
}

var _responseMock = """ 
{
  "getDataScienceAutoCompleteSearch": {
    "status": {
      "code": "1000",
      "header": "Success"
    },
    "data": {
      "suggestions": {
        "tour": [
          {
            "type":null,
            "keyword": "Phuket Racha Island Snorkeling Tour",
            "id": "MA2111000117",
            "cityId": "MA05110067",
            "countryId": "MA05110001",
            "locationName": null
          }
        ],
        "ticket": [
          { 
            "type": null,
            "keyword": "Phuket Aquarium",
            "id": "MA2110000377",
            "locationName": null,
            "cityId": "MA05110067",
            "countryId": "MA05110001"
          },
          {
            "type": null,
            "keyword": "Phuket Thai Hua Museum",
            "id": "MA2111000034",
            "locationName": null,
            "cityId": "MA05110067",
            "countryId": "MA05110001"
          }
        ],
        "city": [
          {
            "keyword": "Phuket",
            "cityId": "MA05110067",
            "cityName": "Phuket",
            "countryId": "MA05110001"
          },
          {
            "keyword": "Pak Phun",
            "cityId": "MA05110068",
            "cityName": "Pak Phun",
            "countryId": "MA05110001"
          }
        ],
        "cityLocation": [
          {
            "type": "city",
            "keyword": "Phuket",
            "id": null,
            "locationName": "Phuket",
            "cityId": "MA05110067",
            "countryId": "MA05110001"
          },
          {
            "type": "location",
            "keyword": "Phuket International Airport",
            "id": "MA21120004",
            "locationName": "Phuket International Airport",
            "cityId": "MA05110067",
            "countryId": "MA05110001"
          }
        ],
        "location": [
          {
          "type": null,
            "keyword": "Phuket International Airport",
            "id": "MA21120004",
            "cityId": "MA05110067",
            "countryId": "MA05110001",
            "locationName": "Phuket International Airport"
          },
          {
          "type": null,
            "keyword": "Pakchong",
            "id": "MA08030094",
            "cityId": "MA05110027",
            "countryId": "MA05110001",
            "locationName": "Pakchong"
          },
          {
          "type": null,
            "keyword": "Adelphi Grande Sukhumvit",
            "id": "MA21120006",
            "cityId": "MA05110041",
            "countryId": "MA05110001",
            "locationName": "Adelphi Grande Sukhumvit"
          }
        ]
      }
    }
  }
}
  
 """;
