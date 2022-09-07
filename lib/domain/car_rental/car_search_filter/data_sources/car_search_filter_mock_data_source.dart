import 'package:ota/domain/car_rental/car_search_filter/data_sources/car_search_filter_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_search_filter/model/car_search_filter_domain_model.dart';

class CarSearchFilterMockDataSourceImpl
    implements CarSearchFilterRemoteDataSource {
  CarSearchFilterMockDataSourceImpl();
  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<CarSearchFilterDomainModel> getCarSearchFilterData() async {
    await Future.delayed(const Duration(seconds: 1));
    return CarSearchFilterDomainModel.fromString(_responseMock);
  }
}

var _responseMock = '''
{
    "data": {
        "sortInfo": [
            {
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
        "criteria": [
            {
                "displayTitle": "Promotion",
                "sortSeq": 1,
                "value": "criteria_rbh_pro",
                "description": null
            },
            {
                "displayTitle": "Type",
                "sortSeq": 2,
                "value": "car_type",
                "description": null
            },
            {
                "displayTitle": "Band",
                "sortSeq": 3,
                "value": "car_brand",
                "description": null
            },
            {
                "displayTitle": "Service",
                "sortSeq": 4,
                "value": "car_service_provider",
                "description": null
            }
        ]
    },
    "status": {
        "code": "1000",
        "header": "Success",
        "description": null
    }
}
''';
