import 'package:ota/domain/favourites/data_sources/favourite_remote_data_source_all.dart';
import 'package:ota/domain/favourites/models/favourites_all_model_domain.dart';

class FavouritesAllMockDataSourceImpl implements FavouriteAllRemoteDataSource {
  FavouritesAllMockDataSourceImpl();
  static String getAllMockDataForHotel() {
    return _responseMockHotel;
  }

  static String getAllMockDataForTour() {
    return _responseMockTour;
  }

  static String getAllMockDataForTicket() {
    return _responseMockTicket;
  }

  static String getAllMockDataForCarrental() {
    return _responseMockCarrental;
  }

  static String getAllMockEmptyData() {
    return _emptyAllResponseMock;
  }

  @override
  Future<FavouritesAllModelDomain> getAllFavouritesData(
      String type, int offset, int limit) async {
    await Future.delayed(const Duration(seconds: 2));
    return FavouritesAllModelDomain.fromJson(_responseMockHotel);
  }
}

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

String _responseMockHotel = '''
{
	"getFavorites": {
		"status": {
			"code": "1000",
			"description": "Success",
			"header": ""
		},
		"data": {
			"favorites": [
        {
					"serviceId": "MA15062148",
					"name": "Money Motel",
					"cityId": "MA05110041",
					"countryId": "MA05110001",
					"Image": "https://trbhmanage.travflex.com/ImageData/Hotel/capital_j_at_khao_yai-general1.jpg",
					"pickupLocationId": "3.43",
					"supplieId": "99.32",
					"dropLocationId": "99.32",
					"location": "Money Motel",
					"serviceName": "HOTEL",
					"promotionList": [{
						"productId": "sss",
						"productType": "sss",
						"promotionType": "sss",
						"promotionCode": "sss",
						"line1": "sss",
						"line2": "ss"
					}]
				}
			]
		}
	}
}''';

String _responseMockTour = '''
{
	"getFavorites": {
		"status": {
			"code": "1000",
			"description": "Success",
			"header": ""
		},
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
				}
			]
		}
	}
}''';

String _responseMockTicket = '''
{
	"getFavorites": {
		"status": {
			"code": "1000",
			"description": "Success",
			"header": ""
		},
		"data": {
			"favorites": [
				{
					"serviceId": "MA2110000414",
					"cityId": "MA05110041",
					"countryId": "MA05110001",
					"name": "Chiang Mai Animal Section",
					"image": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/jj-green-market-tour-ma2110000413-general1.jpg",
					"location": "NONE-Bangkok",
					"category": "ADVENTURE",
					"serviceName": "TICKET"
				}
			]
		}
	}
}''';

String _responseMockCarrental = '''
{
	"getFavorites": {
		"status": {
			"code": "1000",
			"description": "Success",
			"header": ""
		},
		"data": {
			"favorites": [
				{
					"serviceId": "MA15062148",
					"name": "motel",
					"cityId": "MA05110041",
					"countryId": "MA05110001",
					"Image": "https://trbhmanage.travflex.com/ImageData/Hotel/capital_j_at_khao_yai-general1.jpg",
					"pickupLocationId": "3.43",
					"supplieId": "99.32",
					"dropLocationId": "99.32",
					"location": "Money Motel",
					"serviceName": "CARRENTAL",
					"promotionList": [{
						"productId": "sss",
						"productType": "sss",
						"promotionType": "sss",
						"promotionCode": "sss",
						"line1": "sss",
						"line2": "sss"
					}]
				}
			]
		}
	}
}''';
