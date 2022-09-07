import 'package:ota/domain/favourites/data_sources/favourites_remote_data_source.dart';
import 'package:ota/domain/favourites/models/favourites_model_domain.dart';
import 'package:ota/domain/favourites/models/favourites_result_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/delete_favorite_model_domain.dart';

class FavouritesMockDataSourceImpl implements FavouritesRemoteDataSource {
  FavouritesMockDataSourceImpl();
  static String getTourMockData() {
    return _favoritesMock;
  }

  static String getTourMockEmptyData() {
    return _emptyAllResponseMock;
  }

  static String getHotelMockData() {
    return _responseMock;
  }

  static String getHotelEmptyMockData() {
    return _emptyResponseMock;
  }

  @override
  Future<FavouritesResultModelDomain> getFavouritesData(
      String type, int offset, int limit) async {
    await Future.delayed(const Duration(seconds: 2));
    return FavouritesResultModelDomain.fromJson(_responseMock);
  }

  @override
  Future<DeleteFavoriteModelDomain> unfavouritesHotel(
      {required String type, required String hotelId}) async {
    await Future.delayed(const Duration(seconds: 2));
    return DeleteFavoriteModelDomain.fromJson(_deleteFavMock);
  }

  @override
  Future<FavoritesModelDomain> getFavourites(
      String type, int offset, int limit) async {
    await Future.delayed(const Duration(seconds: 2));
    return FavoritesModelDomain.fromJson(_favoritesMock);
  }
}

String _emptyResponseMock = '''
{
  "getAllFavorites": {
    "status": {
      "code": "1000",
			"description": "Success",
			"header": ""
		},
    "data": {
      "favorites": []
    }
  }
}
''';

String _responseMock = '''{
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
            "promotionType":"OVERLAY"
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
            "promotionType":"OVERLAY"
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
            "promotionType":"OVERLAY"
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
            "promotionType":"OVERLAY"
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
            "promotionType":"OVERLAY"
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
            "line1":"abc"
          }]
        },
        {
          "hotelId": "MA1912002715",
          "hotelName": "Mon Madam",
          "cityId": "MA05110002",
          "countryId": "MA05110001",
          "hotelImage": "https://trbhmanage.travflex.com/ImageData/Hotel/capital_j_at_khao_yai-general1.jpg",
          "latitude": 33.43,
          "longitude": 99.32,
          "location": "Koh Mook Island",
          "promotionList":[{
            "line1":"abc"
          }]
        },
        {
          "hotelId": "MA1912002716",
          "hotelName": null,
          "cityId": "MA05110067",
          "countryId": "MA05110001",
          "hotelImage": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg",
          "latitude": 33.43,
          "longitude": 99.32,
          "location": "Montri Road",
          "promotionList":[{
            "line1":"abc"
          }]
        },
        {
          "hotelId": "MA1912002717",
          "hotelName": "Raya Geritage Hotel",
          "cityId": "MA05110071",
          "countryId": "MA05110001",
          "hotelImage": "https://trbhmanage.travflex.com/ImageData/Hotel/capital_j_at_khao_yai-general1.jpg",
          "latitude": 33.43,
          "longitude": 99.32,
          "location": "Choeng Mon Beach",
          "promotionList":[{
            "line1":"abc"
          }]
        },
        {
          "hotelId": "MA1912002718",
          "hotelName": "Rimping Boutique Chiangmai",
          "cityId": "MA05110001",
          "countryId": "MA05110001",
          "hotelImage": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg",
          "latitude": 33.43,
          "longitude": 99.32,
          "location": "Morakot Road",
          "promotionList":[{
            "line1":"abc"
          }]
        },
        {
          "hotelId": "MA1912002719",
          "hotelName": "Raya Geritage Hotel Raya Geritag...",
          "cityId": "MA05110075",
          "countryId": "MA05110001",
          "hotelImage": "https://trbhmanage.travflex.com/ImageData/Hotel/capital_j_at_khao_yai-general1.jpg",
          "latitude": 33.43,
          "longitude": 99.32,
          "location":  "Kai Mook Beach",
          "promotionList":[{
            "line1":"abc"
          }]
        },
        {
          "hotelId": "MA1912002720",
          "hotelName": null,
          "cityId": "MA05110072",
          "countryId": "MA05110001",
          "hotelImage": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg",
          "latitude": 33.43,
          "longitude": 99.32,
          "location": "Koh Mook Island",
          "promotionList":[{
            "line1":"abc"
          }]
        }
      ]
    }
  }
}''';
String _emptyAllResponseMock = '''
{
  "getFavorites": {
    "status": {
      "code": "1000",
			"description": "Success",
			"header": ""
		},
    "data": {
      "favorites": []
    }
  }
}
''';
String _favoritesMock = '''
{
	"getFavorites": {
		"data": {
			"favorites": [
        {
					"serviceId": "MA2110000413",
					"cityId": "MA05110041",
					"countryId": "MA05110001",
					"name": "JJ Green Market Tour",
					"image": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/jj-green-market-tour-ma2110000413-general1.jpg",
					"location": "NONE-Bangkok",
					"category": "EDUCATIONAL",
					"serviceName": "TOUR"
				},
				{
					"serviceId": "MA2110000414",
					"cityId": "MA05110041",
					"countryId": "MA05110001",
					"name": "Chiang Mai Animal Section",
					"image": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/jj-green-market-tour-ma2110000413-general1.jpg",
					"location": "NONE-Bangkok",
					"category": "ADVENTURE",
					"serviceName": "TICKET"
				},
				{
					"serviceId": "MA2110000414",
					"cityId": "MA05110041",
					"countryId": "MA05110001",
					"name": "Chiang Mai Animal Section",
					"image": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/jj-green-market-tour-ma2110000413-general1.jpg",
					"location": null,
					"category": "SPORTS",
					"serviceName": "TICKET"
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
''';

var _deleteFavMock = """{
  "deleteFavorite": {
    "status": {
      "code": "1000",
      "header": "Information Not Available",
      "description": null
    }
  }
}""";
