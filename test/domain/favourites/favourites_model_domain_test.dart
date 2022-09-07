import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/favourites/models/favourites_model_domain.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String favoritesMock = '''
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
					"serviceName": "TOUR",
          "promotionList":[{
            "line1":"abc",
            "line2":"def",
            "promotionType":"OVERLAY",
            "startDate": "2021-09-06T08:44:39"
          }]
				},
				{
					"serviceId": "MA2110000414",
					"cityId": "MA05110041",
					"countryId": "MA05110001",
					"name": "Chiang Mai Animal Section",
					"image": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/jj-green-market-tour-ma2110000413-general1.jpg",
					"location": "NONE-Bangkok",
					"category": "ADVENTURE",
					"serviceName": "TICKET",
          "promotionList":[{
            "line1":"abc",
            "line2":"def",
            "promotionType":"OVERLAY",
            "startDate": "2021-09-06T08:44:39"
          }]
				},
				{
					"serviceId": "MA2110000414",
					"cityId": "MA05110041",
					"countryId": "MA05110001",
					"name": "Chiang Mai Animal Section",
					"image": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/jj-green-market-tour-ma2110000413-general1.jpg",
					"location": null,
					"category": "SPORTS",
					"serviceName": "TICKET",
          "promotionList":[{
            "line1":"abc",
            "line2":"def",
            "promotionType":"OVERLAY",
            "startDate": "2021-09-06T08:44:39"
          }]
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

  group("Customer model test group", () {
    test('Customer model test', () async {
      FavoritesModelDomain favouriteCheckServiceDomain =
          FavoritesModelDomain.fromJson(favoritesMock);
      favouriteCheckServiceDomain.toJson();
      favouriteCheckServiceDomain.toMap();
      favouriteCheckServiceDomain.getFavorites?.data?.toJson();
      favouriteCheckServiceDomain.getFavorites?.data?.toMap();
      favouriteCheckServiceDomain.getFavorites?.toJson();
      favouriteCheckServiceDomain.getFavorites?.toMap();
      favouriteCheckServiceDomain.getFavorites?.status?.toMap();
      favouriteCheckServiceDomain.getFavorites?.data?.favorites?.first.toMap();
      expect(
          favouriteCheckServiceDomain.getFavorites?.data?.favorites?.isNotEmpty,
          true);
      favouriteCheckServiceDomain.getFavorites?.data?.favorites?.first.toJson();
      favouriteCheckServiceDomain.getFavorites?.data?.favorites?.first.toJson();
      expect(
          favouriteCheckServiceDomain
              .getFavorites?.data?.favorites?.first.promotionList?.isNotEmpty,
          true);
      favouriteCheckServiceDomain
          .getFavorites?.data?.favorites?.first.promotionList?.first
          .toMap();
    });
  });
}
