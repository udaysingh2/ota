import 'package:ota/domain/tours/landing/data_sources/tour_attractions_remote_data_source.dart';
import 'package:ota/domain/tours/landing/models/tour_attractions_model_domain.dart';

class TourAttractionsMockDataSourceImpl
    implements TourAttractionsRemoteDataSource {
  TourAttractionsMockDataSourceImpl();
  @override
  Future<TourAttractionsModelDomain> getTourAttractionsData(
      String serviceType) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return TourAttractionsModelDomain.fromJson(_responseMock);
  }
}

var _responseMock = '''{
  "getTourServiceSuggestions": {
    "data": {
      "attractionList": [
        {
          "serviceTitle": "พัทยา",
          "searchKey": "พัทยา",
          "cityId": "MA05110908",
          "countryId": "MA05110001",
          "imageUrl": "https://static-dev.alp-robinhood.com/ota/suggestion/OTAImage4.jpg"
        },
        {
          "serviceTitle": "กรุงเทพมหานคร",
          "searchKey": "กรุงเทพมหานคร",
          "cityId": "MA05110908",
          "countryId": "MA05110001",
          "imageUrl": "https://static-dev.alp-robinhood.com/ota/suggestion/OTAImage4.jpg"
        }
      ]
    },
    "status": {
      "code": "1000",
      "header": "success",
      "description": ""
    }
  }
}
''';
