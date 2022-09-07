import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/data_sources/hotel_landing_static_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/models/hotel_landing_static_data_model.dart';

class HotelLandingStaticMockDataSourceImpl
    implements HotelLandingStaticDataSource {
  HotelLandingStaticMockDataSourceImpl();
  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<HotelLandingStaticSingleData> getPlaylist(
      HotelLandingStaticSingleDataArgument argument) async {
    HotelLandingStaticSingleData data =
        HotelLandingStaticSingleData.fromJson(_responseMock);
    return data;
  }
}

var _responseMock = '''
{
  "data": {
    "getPlaylists": {
      "staticPlaylist": {
        "source": "null",
        "serviceName": "HOTEL",
        "playlist": [
          {
            "playlistId": "333",
            "playlistName": "Activity recommend -1",
            "cardList": [
              {
                "id": "MA2111000070",
                "cityId": "MA05110041",
                "countryId": "MA05110001",
                "imageUrl": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/wat-arun.jpg",
                "countryName": "null",
                "name": "Wat Arun(Holiday by RBH)",
                "locationName": "Yaowaraj,Bangkok",
                "locationId": "null",
                "cityName": "Bangkok",
                "styleName": "CULTURAL",
                "startPrice": 800,
                "productType": "null",
                "address": "null",
                "address1": "null",
                "rating": 0,
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
