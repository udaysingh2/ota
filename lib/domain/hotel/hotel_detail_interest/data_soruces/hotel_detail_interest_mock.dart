import 'package:ota/domain/hotel/hotel_detail_interest/models/hotel_detail_interest_data.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/models/hotel_detail_interest_data_argument.dart';

import 'hotel_detail_interest_remote_data_source.dart';

class HotelDetailInterestMock implements HotelDetailInterestRemoteDataSource {
  HotelDetailInterestMock();

  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<HotelDetailInterestData> getHotelDetailInterestData(
      HotelDetailInterestDataArgument argument) async {
    await Future.delayed(const Duration(seconds: 1));
    return HotelDetailInterestData.fromJson(_responseMock);
  }
}

var _responseMock = """{
  "data": {
    "getHotelsYouMayLike": {
      "data": {
        "hotelList": [
          {
            "hotelId": "MA0511000344",
            "hotelName": "shangri La Bangkok",
            "image": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg",
            "rating": 5,
            "address": {
              "address": "89 Soi Wat Suan Phu New Road Bangrak",
              "locationId": "MA05110075",
              "locationName": "Wat",
              "cityId": "MA05110041",
              "cityName": "Bangkok",
              "countryId": "MA05110001",
              "countryName": "Thailand"
            },
            "infoTechPromotion": [],
            "totalPrice": 5500,
            "pricePerNight": 5500,
            "adminPromotion": {
              "adminPromotionLine1": "Special",
              "adminPromotionLine2": "discount"
            },
            "capsulePromotion": [
              {
                "name": "Free delivery",
                "code": "FREE"
              }
            ],
            "review": {
              "score": 5,
              "numReview": 20,
              "description": "very Good"
            }
          },
           {
            "hotelId": "MA0511000344",
            "hotelName": "shangri La Bangkok",
            "image": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg",
            "rating": 5,
            "address": {
              "address": "89 Soi Wat Suan Phu New Road Bangrak",
              "locationId": "MA05110075",
              "locationName": "Wat",
              "cityId": "MA05110041",
              "cityName": "Bangkok",
              "countryId": "MA05110001",
              "countryName": "Thailand"
            },
            "infoTechPromotion": [],
            "totalPrice": 5500,
            "pricePerNight": 5500,
            "adminPromotion": {
              "adminPromotionLine1": "Special",
              "adminPromotionLine2": "discount"
            },
            "review": {
              "score": 5,
              "numReview": 20,
              "description": "very Good"
            }
          }
        ]
      },
      "status": {
        "code": "1000",
        "header": "Success",
        "description": null
      }
    }
  }
}""";
