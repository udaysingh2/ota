import 'package:ota/domain/favourites/models/favourites_carrental_model_domain.dart';
import 'favourites_remote_data_source_car_rental.dart';

class FavouritesCarRentalMockDataSourceImpl
    implements FavouriteCarRentalRemoteDataSource {
  FavouritesCarRentalMockDataSourceImpl();
  static String getMockData() {
    return _responseMock;
  }

  static String getEmptyMockData() {
    return _emptyAllResponseMock;
  }

  @override
  Future<FavouritesCarRentalModelDomain> getAllFavouritesData(
      String type, int offset, int limit) async {
    await Future.delayed(const Duration(seconds: 2));
    return FavouritesCarRentalModelDomain.fromJson(_responseMock);
  }
}

String _emptyAllResponseMock = '''
{
  "getCarRentalFavorites": {
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
String _responseMock = '''
{
	"getCarRentalFavorites": {
		"data": {
			"favorites": [{
				"serviceId": "2",
				"supplierId": "MA2111000062",
				"name": "Vios",
				"image": "https://trbhmanage.travflex.com/imagedata/Car/800/vios-2-1.jpg",
				"location": "Bangkok",
				"pickupLocationId": "MA06030005",
				"dropLocationId": "MA06030005",
				"promotionList": [{
            "line1":"abc",
            "line2":"def",
            "promotionType":"OVERLAY"
          }]
			}, 
      {
				"serviceId": "3",
				"supplierId": "MA2111000062",
				"name": "Vios",
				"image": "https://trbhmanage.travflex.com/imagedata/Car/800/vios-2-1.jpg",
				"location": "Bangkok",
				"pickupLocationId": "MA06030005",
				"dropLocationId": "MA06030005",
				"promotionList": [{
            "line1":"abc",
            "line2":"def",
            "promotionType":"OVERLAY"
          }]
			}]
		},
		"status": {
			"code": "1000",
			"header": "Success",
			"description": null
		}
	}
}
''';
