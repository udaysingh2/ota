import 'package:ota/domain/tours/review_reservation/data_sources/pickup_point_remote_data_source.dart';
import 'package:ota/domain/tours/review_reservation/models/pickup_point_model_domain.dart';

class PickUpPointMockDataSourceImpl implements PickUpPointRemoteDataSource {
  PickUpPointMockDataSourceImpl();
  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<PickUpPointDomain> getPickUpPointDetail(String zoneId) async {
    await Future.delayed(const Duration(seconds: 1));
    return PickUpPointDomain.fromJson(_responseMock);
  }
}

var _responseMock = '''
{

	"getPickUpDetails": {
		"data": {
			"pickupPoints": [{
					"id": "MA2110000118",
					"name": "Baan Chom Daw"
				},
				{
					"id": "MA2109000091",
					"name": "Faikid Hotel"
				}
			]
		},
		"status": {
			"code": "1000",
			"header": "Success",
			"description": ""
		}
	}
}
	''';
