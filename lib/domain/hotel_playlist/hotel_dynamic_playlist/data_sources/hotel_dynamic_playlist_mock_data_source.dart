import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/models/hotel_dynamic_playlist_model_domain.dart';

import '../models/hotel_dynamic_playlist_argument_model.dart';
import 'hotel_dynamic_playlist_remote_data_source.dart';

class HotelDynamicPlayListMockDataSourceImpl
    implements HotelDynamicPlayListRemoteDataSource {
  HotelDynamicPlayListMockDataSourceImpl();

  @override
  Future<HotelDynamicPlayListModelDomainData> getHotelDynamicPlayListData(
      HotelDynamicPlayListDataArgumentModelDomain argument) async {
    await Future.delayed(const Duration(milliseconds: 10));
    return HotelDynamicPlayListModelDomainData.fromJson(_responseMock);
  }

  static String getMockData() {
    return _responseMock;
  }
}

var _responseMock = """ 
{
  "getRecentViewPlaylist": {
    "listType": "recentViewPlaylist",
    "dynamicPlaylist": {
      "serviceName": "hotels",
      "source": "dynamic",
      "playlist": [
        {
          "playlistId": "222",
          "playlistName": "Special recommended",
          "cardList": [
            {
              "id": "MA0201175007",
              "name": "Amari Phuket",
              "address": "2 Meun-Ngern Road Patong Beach, Kathu Address field 3",
              "locationId": "MA06040001",
              "locationName": "Patong Beach",
              "cityId": "MA05110067",
              "cityName": "Phuket",
              "countryId": "MA05110001",
              "countryName": "Thailand",
              "capsulePromotions": [
                {
                  "name": "cap1",
                  "code": "007"
                }
              ],
              "rating": 4,
              "infopromotion": [],
              "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/amari_phuket-general1.jpg",
              "promotionText1": "",
              "promotionText2": "",
              "styleName": "NONE",
              "startPrice": 1200,
              "productType": null,
              "review": {
                "score": 4,
                "numReview": 10,
                "description": "superb"
              }
            },
            {
              "id": "MA0201175007",
              "name": "Amari Phuket",
              "address": "2 Meun-Ngern Road Patong Beach, Kathu Address field 3",
              "locationId": "MA06040001",
              "locationName": "Patong Beach",
              "cityId": "MA05110067",
              "cityName": "Phuket",
              "countryId": "MA05110001",
              "countryName": "Thailand",
              "capsulePromotions": [
                {
                  "name": "cap1",
                  "code": "007"
                }
              ],
              "rating": 4,
              "infopromotion": [],
              "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/amari_phuket-general1.jpg",
              "promotionText1": "",
              "promotionText2": "",
              "styleName": "NONE",
              "startPrice": 1200,
              "productType": null,
              "review": {
                "score": 4,
                "numReview": 10,
                "description": "superb"
              }
            },
            {
              "id": "MA0201175007",
              "name": "Amari Phuket",
              "address": "2 Meun-Ngern Road Patong Beach, Kathu Address field 3",
              "locationId": "MA06040001",
              "locationName": "Patong Beach",
              "cityId": "MA05110067",
              "cityName": "Phuket",
              "countryId": "MA05110001",
              "countryName": "Thailand",
              "capsulePromotions": [
                {
                  "name": "cap1",
                  "code": "007"
                }
              ],
              "rating": 4,
              "infopromotion": [],
              "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/amari_phuket-general1.jpg",
              "promotionText1": "",
              "promotionText2": "",
              "styleName": "NONE",
              "startPrice": 1200,
              "productType": null,
              "review": {
                "score": 4,
                "numReview": 10,
                "description": "superb"
              }
            },
            {
              "id": "MA0201175007",
              "name": "Amari Phuket",
              "address": "2 Meun-Ngern Road Patong Beach, Kathu Address field 3",
              "locationId": "MA06040001",
              "locationName": "Patong Beach",
              "cityId": "MA05110067",
              "cityName": "Phuket",
              "countryId": "MA05110001",
              "countryName": "Thailand",
              "capsulePromotions": [
                {
                  "name": "cap1",
                  "code": "007"
                }
              ],
              "rating": 4,
              "infopromotion": [],
              "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/amari_phuket-general1.jpg",
              "promotionText1": "",
              "promotionText2": "",
              "styleName": "NONE",
              "startPrice": 1200,
              "productType": null,
              "review": {
                "score": 4,
                "numReview": 10,
                "description": "superb"
              }
            },
            {
              "id": "MA0201175007",
              "name": "Amari Phuket",
              "address": "2 Meun-Ngern Road Patong Beach, Kathu Address field 3",
              "locationId": "MA06040001",
              "locationName": "Patong Beach",
              "cityId": "MA05110067",
              "cityName": "Phuket",
              "countryId": "MA05110001",
              "countryName": "Thailand",
              "capsulePromotions": [
                {
                  "name": "cap1",
                  "code": "007"
                }
              ],
              "rating": 4,
              "infopromotion": [],
              "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/amari_phuket-general1.jpg",
              "promotionText1": "",
              "promotionText2": "",
              "styleName": "NONE",
              "startPrice": 1200,
              "productType": null,
              "review": {
                "score": 4,
                "numReview": 10,
                "description": "superb"
              }
            },
            {
              "id": "MA0201175007",
              "name": "Amari Phuket",
              "address": "2 Meun-Ngern Road Patong Beach, Kathu Address field 3",
              "locationId": "MA06040001",
              "locationName": "Patong Beach",
              "cityId": "MA05110067",
              "cityName": "Phuket",
              "countryId": "MA05110001",
              "countryName": "Thailand",
              "capsulePromotions": [
                {
                  "name": "cap1",
                  "code": "007"
                }
              ],
              "rating": 4,
              "infopromotion": [],
              "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/amari_phuket-general1.jpg",
              "promotionText1": "",
              "promotionText2": "",
              "styleName": "NONE",
              "startPrice": 1200,
              "productType": null,
              "review": {
                "score": 4,
                "numReview": 10,
                "description": "superb"
              }
            },
            {
              "id": "MA0201175007",
              "name": "Amari Phuket",
              "address": "2 Meun-Ngern Road Patong Beach, Kathu Address field 3",
              "locationId": "MA06040001",
              "locationName": "Patong Beach",
              "cityId": "MA05110067",
              "cityName": "Phuket",
              "countryId": "MA05110001",
              "countryName": "Thailand",
              "capsulePromotions": [
                {
                  "name": "cap1",
                  "code": "007"
                }
              ],
              "rating": 4,
              "infopromotion": [],
              "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/amari_phuket-general1.jpg",
              "promotionText1": "",
              "promotionText2": "",
              "styleName": "NONE",
              "startPrice": 1200,
              "productType": null,
              "review": {
                "score": 4,
                "numReview": 10,
                "description": "superb"
              }
            },
            {
              "id": "MA0201175007",
              "name": "Amari Phuket",
              "address": "2 Meun-Ngern Road Patong Beach, Kathu Address field 3",
              "locationId": "MA06040001",
              "locationName": "Patong Beach",
              "cityId": "MA05110067",
              "cityName": "Phuket",
              "countryId": "MA05110001",
              "countryName": "Thailand",
              "capsulePromotions": [
                {
                  "name": "cap1",
                  "code": "007"
                }
              ],
              "rating": 4,
              "infopromotion": [],
              "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/amari_phuket-general1.jpg",
              "promotionText1": "",
              "promotionText2": "",
              "styleName": "NONE",
              "startPrice": 1200,
              "productType": null,
              "review": {
                "score": 4,
                "numReview": 10,
                "description": "superb"
              }
            },
            {
              "id": "MA0201175007",
              "name": "Amari Phuket",
              "address": "2 Meun-Ngern Road Patong Beach, Kathu Address field 3",
              "locationId": "MA06040001",
              "locationName": "Patong Beach",
              "cityId": "MA05110067",
              "cityName": "Phuket",
              "countryId": "MA05110001",
              "countryName": "Thailand",
              "capsulePromotions": [
                {
                  "name": "cap1",
                  "code": "007"
                }
              ],
              "rating": 4,
              "infopromotion": [],
              "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/amari_phuket-general1.jpg",
              "promotionText1": "",
              "promotionText2": "",
              "styleName": "NONE",
              "startPrice": 1200,
              "productType": null,
              "review": {
                "score": 4,
                "numReview": 10,
                "description": "superb"
              }
            }
          ]
        }
      ]
    }
  }
}
""";
