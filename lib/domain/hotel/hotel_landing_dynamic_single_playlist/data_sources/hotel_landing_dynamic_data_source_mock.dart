import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/data_sources/hotel_landing_dynamic_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/models/hotel_landing_dynamic_data_model.dart';

class HotelLandingDynamicMockDataSourceImpl
    implements HotelLandingDynamicDataSource {
  HotelLandingDynamicMockDataSourceImpl();
  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<HotelLandingDynamicSingleData> getPlaylist(
      HotelLandingDynamicSingleDataArgument argument) async {
    HotelLandingDynamicSingleData data =
        HotelLandingDynamicSingleData.fromJson(_responseMock);
    return data;
  }
}

var _responseMock = '''{
  "data": {
    "getPlaylists": {
      "dynamicPlaylist": {
        "source": "Dynamic",
        "serviceName": "Hotels",
        "playlist": [
          {
            "playlistId": "222",
            "playlistName": "some value",
            "cardList": [
              {
                "id": "MA0511000335",
                "cityId": "MA05110041",
                "countryId": "MA05110001",
                "countryName": "null",
                "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/tongtara_riverview-general1.jpg",
                "name": "null",
                "locationName": "null",
                "locationId": "MA05110010",
                "cityName": "null",
                "styleName": "null",
                "startPrice": "null",
                "productType": "null",
                "address": "null",
                "address1": "null",
                "rating": 4,
                "review": {
                    "score": 4,
                    "numReview": 10,
                    "description": "superb"
                  },
                "promotionText_line1": "null",
                "promotionText_line2": "null",
                "capsulePromotion": [
                    {
                      "name": "cap1",
                      "code": "007"
                    }
                  ],
                "infopromotion": []
              }
              
            ]
          }
        ]
      }
    }
  }
}
''';
