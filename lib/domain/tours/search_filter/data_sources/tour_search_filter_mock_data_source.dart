import 'package:ota/domain/tours/search_filter/data_sources/tour_search_filter_remote_data_source.dart';
import 'package:ota/domain/tours/search_filter/models/tour_search_filter_model_domain.dart';

class TourSearchFilterMockDataSourceImpl
    implements TourSearchFilterRemoteDataSource {
  TourSearchFilterMockDataSourceImpl();
  @override
  Future<TourSearchFilterModelDomain> getTourSearchFilterData(
      String serviceType) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return TourSearchFilterModelDomain.fromJson(_responseMock);
  }
}

var _responseMock = '''
{
	"getSortCriteriaForService": {
		"data": {
			"sortInfo": [{
					"displayTitle": "Robinhood suggestion",
					"sortSeq": 1,
					"value": "rbh_suggest"
				},
				{
					"displayTitle": "Popular",
					"sortSeq": 2,
					"value": "rbh_popular"
				},
				{
					"displayTitle": "Low price to high price",
					"sortSeq": 3,
					"value": "price_ascending"
				},
				{
					"displayTitle": "High price to Low price",
					"sortSeq": 4,
					"value": "price_descending"
				}
			],
			"criteria": [{
					"displayTitle": "Price",
					"sortSeq": 1,
					"value": "criteria_price",
					"description": null
				},
				{
					"displayTitle": "Ticket Style",
					"sortSeq": 2,
					"value": "criteria_style",
					"description": " Can select more than 1 item."
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
