import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/favourites/models/favourites_result_model_domain.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String responseMock = '''{
  "getAllFavorites": {
    "status": {
      "code": "1000",
			"description": "Success",
			"header": ""
		},
    "data": {
      "favorites": [
        {
          "hotelId": "MA15062148",
          "hotelName": "Money Motel",
          "cityId": "MA05110041",
          "countryId": "MA05110001",
          "hotelImage": "https://trbhmanage.travflex.com/ImageData/Hotel/capital_j_at_khao_yai-general1.jpg",
          "latitude": 33.43,
          "longitude": 99.32,
          "location": "Money Motel",
          "promotionList":[{
            "line1":"abc",
            "line2":"def",
            "promotionType":"OVERLAY",
            "startDate": "2021-09-06T08:44:39"
          }]
        },
        {
          "hotelId": "MA19120437",
          "hotelName": "Monsan",
          "cityId": "MA05110041",
          "countryId": "MA05110001",
          "hotelImage": null,
          "latitude": 33.43,
          "longitude": 99.32,
          "location": "Monsan",
          "promotionList":[{
            "line1":"abc",
            "promotionType":"OVERLAY",
            "startDate": "2021-09-06T08:44:39"
          }]
        },
        {
          "hotelId": "MA0201233399",
          "hotelName": "Money",
          "cityId": "MA05110001",
          "countryId": "MA05110001",
          "hotelImage": "https://trbhmanage.travflex.com/ImageData/Hotel/capital_j_at_khao_yai-general1.jpg",
          "latitude": 33.43,
          "longitude": 99.32,
          "location": "Money",
          "promotionList":[{
            "line1":"abc",
            "promotionType":"OVERLAY",
            "startDate": "2021-09-06T08:44:39"
          }]
        },
        {
          "hotelId": "MA1912002555",
          "hotelName": null,
          "cityId": "MA05110070",
          "countryId": "MA05110001",
          "hotelImage": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg",
          "latitude": 33.43,
          "longitude": 99.32,
          "location": "Montana Hotel",
          "promotionList":[{
            "line1":"abc",
            "promotionType":"OVERLAY",
            "startDate": "2021-09-06T08:44:39"
          }]
        },
        {
          "hotelId": "MA2009000002",
          "hotelName": "Monmai Resort",
          "cityId": "MA05110001",
          "countryId": "MA05110001",
          "hotelImage": "https://trbhmanage.travflex.com/ImageData/Hotel/capital_j_at_khao_yai-general1.jpg",
          "latitude": 33.43,
          "longitude": 99.32,
          "location": null,
          "promotionList":[{
            "line1":"abc",
            "line2":"def",
            "promotionType":"OVERLAY",
            "startDate": "2021-09-06T08:44:39"
          }]
        },
        {
          "hotelId": "MA2008000090",
          "hotelName": "Monotel Aonang",
          "cityId": "MA05110062",
          "countryId": "MA05110001",
          "hotelImage": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg",
          "latitude": 33.43,
          "longitude": 99.32,
          "location": "Monotel Aonang",
          "promotionList":[{
            "line1":"abc",
            "startDate": "2021-09-06T08:44:39"
          }]
        }
      ]
    }
  }
}''';

  group("Customer model test group", () {
    test('Customer model test', () async {
      FavouritesResultModelDomain favouritesResultModelDomain =
          FavouritesResultModelDomain.fromJson(responseMock);
      expect(favouritesResultModelDomain.getAllFavorites != null, true);
      favouritesResultModelDomain.toJson();
      favouritesResultModelDomain.toMap();
      favouritesResultModelDomain.getAllFavorites?.toJson();
      favouritesResultModelDomain.getAllFavorites?.toMap();
      favouritesResultModelDomain.getAllFavorites?.data?.toJson();
      favouritesResultModelDomain.getAllFavorites?.data?.toMap();
      expect(
          favouritesResultModelDomain
              .getAllFavorites?.data?.favourites.isNotEmpty,
          true);
      favouritesResultModelDomain.getAllFavorites?.data?.favourites.first
          .toJson();
      favouritesResultModelDomain.getAllFavorites?.data?.favourites.first
          .toMap();
      favouritesResultModelDomain
          .getAllFavorites?.data?.favourites.first.promotionList?.first
          .toJson();
      favouritesResultModelDomain
          .getAllFavorites?.data?.favourites.first.promotionList?.first
          .toMap();
    });
  });
}
