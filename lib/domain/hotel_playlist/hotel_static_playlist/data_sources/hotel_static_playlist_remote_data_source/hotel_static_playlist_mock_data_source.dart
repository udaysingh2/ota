import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_argument_model.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_model_domain.dart';

import 'hotel_static_playlist_remote_data_source.dart';

class HotelStaticPlayListMockDataSourceImpl
    implements HotelStaticPlayListRemoteDataSource {
  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<HotelStaticPlayListModelDomain> getHotelStaticPlayListData(
      HotelStaticPlayListArgumentModelDomain argument) async {
    await Future.delayed(const Duration(seconds: 1));
    return HotelStaticPlayListModelDomain.fromJson(_responseMock);
  }
}

String _responseMock = '''
 {
  "getPlaylists": {
    "staticPlaylist": {
      "source": "static",
      "serviceName": "HOTEL",
      "playlist": [
        {
          "playlistId": "55555",
          "playlistName": "Hotel Recommended",
          "cardList": [
            {
              "__typename": "PlaylistData",
              "id": "MA1111000019",
              "cityId": "MA05110041",
              "countryId": "MA05110001",
              "imageUrl": "https://train.travflex.com/ImageData/Hotel/amora_neoluxe_bangkok-general1.jpg",
              "countryName": null,
              "name": "Amora Neoluxe Bangkok",
              "locationName": "Bangkok",
              "locationId": null,
              "cityName": "Bangkok",
              "styleName": null,
              "startPrice": 0,
              "productType": "HOTEL",
              "address": null,
              "address1": null,
              "rating": 4,
              "review": null,
              "promotionText_line1": "discount",
              "promotionText_line2": "50%",
              "capsulePromotion": [
                {
                  "__typename": "CapsulePromotions",
                  "name": "Free Food Delivery",
                  "code": "FREE01"
                }
              ],
              "infopromotion": []
            },
            {
              "__typename": "PlaylistData",
              "id": "MA0603000157",
              "cityId": "MA05110001",
              "countryId": "MA05110001",
              "imageUrl": "https://train.travflex.com/ImageData/Hotel/chiang_mai_phucome-general1.jpg",
              "countryName": null,
              "name": "Chiang Mai Phucome",
              "locationName": "",
              "locationId": null,
              "cityName": "Chiang Mai",
              "styleName": null,
              "startPrice": 0,
              "productType": "HOTEL",
              "address": null,
              "address1": null,
              "rating": 3,
              "review": null,
              "promotionText_line1": "discount",
              "promotionText_line2": "50%",
              "capsulePromotion": [
                {
                  "__typename": "CapsulePromotions",
                  "name": "Free Food Delivery",
                  "code": "FREE01"
                }
              ],
              "infopromotion": []
            },
            {
              "__typename": "PlaylistData",
              "id": "MA0603000037",
              "cityId": "MA05110908",
              "countryId": "MA05110001",
              "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/pattaya_hiso-general1.jpg",
              "countryName": null,
              "name": "Pattaya Hiso",
              "locationName": "Pattaya",
              "locationId": null,
              "cityName": "Chonburi",
              "styleName": null,
              "startPrice": 0,
              "productType": "HOTEL",
              "address": null,
              "address1": null,
              "rating": 3,
              "review": null,
              "promotionText_line1": "Only",
              "promotionText_line2": "RBH",
              "capsulePromotion": [
                {
                  "__typename": "CapsulePromotions",
                  "name": "Free Food Delivery",
                  "code": "FREE01"
                }
              ],
              "infopromotion": []
            }
          ]
        },
        {
          "playlistId": "17",
          "playlistName": "Hotel in bangkok",
          "cardList": [
            {
              "__typename": "PlaylistData",
              "id": "MA0511000344",
              "cityId": "MA05110041",
              "countryId": "MA05110001",
              "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg",
              "countryName": null,
              "name": "Shangri La Bangkok",
              "locationName": " Wat Suan Phu New ",
              "locationId": null,
              "cityName": "Bangkok",
              "styleName": "",
              "startPrice": 0,
              "productType": "HOTEL",
              "address": null,
              "address1": null,
              "rating": 5,
              "review": null,
              "promotionText_line1": null,
              "promotionText_line2": null,
              "capsulePromotion": [
                {
                  "__typename": "CapsulePromotions",
                  "name": "Free Food Delivery",
                  "code": "281"
                }
              ],
              "infopromotion": []
            },
            {
              "__typename": "PlaylistData",
              "id": "MA0810000023",
              "cityId": "MA05110041",
              "countryId": "MA05110001",
              "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/p_and_r_residence_siphaya_bangkok-general1.jpg",
              "countryName": null,
              "name": "P and R Residence Siphaya Bangkok",
              "locationName": " Charoen Krung ",
              "locationId": null,
              "cityName": "Bangkok",
              "styleName": "",
              "startPrice": 0,
              "productType": "HOTEL",
              "address": null,
              "address1": null,
              "rating": 3,
              "review": null,
              "promotionText_line1": null,
              "promotionText_line2": null,
              "capsulePromotion": [
                {
                  "__typename": "CapsulePromotions",
                  "name": "Free Food Delivery",
                  "code": "281"
                }
              ],
              "infopromotion": []
            },
            {
              "__typename": "PlaylistData",
              "id": "MA0711050518",
              "cityId": "MA05110041",
              "countryId": "MA05110001",
              "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/courtyard_by_marriott_bangkok_(sha_plus)-general1.jpg",
              "countryName": null,
              "name": "Courtyard By Marriott Bangkok (SHA Plus)",
              "locationName": "Rajdamri",
              "locationId": null,
              "cityName": "Bangkok",
              "styleName": "",
              "startPrice": 0,
              "productType": "HOTEL",
              "address": null,
              "address1": null,
              "rating": 4,
              "review": null,
              "promotionText_line1": null,
              "promotionText_line2": null,
              "capsulePromotion": [
                {
                  "__typename": "CapsulePromotions",
                  "name": "Free Food Delivery",
                  "code": "281"
                }
              ],
              "infopromotion": []
            },
            {
              "__typename": "PlaylistData",
              "id": "MA1210100023",
              "cityId": "MA05110041",
              "countryId": "MA05110001",
              "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/w_bangkok-general1.jpg",
              "countryName": null,
              "name": "W Bangkok",
              "locationName": " North Sathorn ",
              "locationId": null,
              "cityName": "Bangkok",
              "styleName": "",
              "startPrice": 0,
              "productType": "HOTEL",
              "address": null,
              "address1": null,
              "rating": 5,
              "review": null,
              "promotionText_line1": null,
              "promotionText_line2": null,
              "capsulePromotion": [
                {
                  "__typename": "CapsulePromotions",
                  "name": "Free Food Delivery",
                  "code": "281"
                }
              ],
              "infopromotion": []
            },
            {
              "__typename": "PlaylistData",
              "id": "MA1711000127",
              "cityId": "MA05110001",
              "countryId": "MA05110001",
              "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/little_bear_s_home_(sha_plus)-general1.jpg",
              "countryName": null,
              "name": "Little Bear s Home (SHA Plus)",
              "locationName": "Sripoom",
              "locationId": null,
              "cityName": " Chiang Mai ",
              "styleName": "",
              "startPrice": 0,
              "productType": "HOTEL",
              "address": null,
              "address1": null,
              "rating": 3,
              "review": null,
              "promotionText_line1": null,
              "promotionText_line2": null,
              "capsulePromotion": [
                {
                  "__typename": "CapsulePromotions",
                  "name": "Free Food Delivery",
                  "code": "281"
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
''';
