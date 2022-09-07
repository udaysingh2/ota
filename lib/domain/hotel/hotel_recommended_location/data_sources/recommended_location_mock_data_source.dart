import 'package:ota/domain/hotel/hotel_recommended_location/data_sources/recommended_location_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/models/recommended_location_model_domain.dart';

class RecommendedLocationMockDataSourceImpl
    implements RecommendedLocationRemoteDataSource {
  RecommendedLocationMockDataSourceImpl();
  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<RecommendedLocationModelDomain> getRecommendedLocationData(
      String serviceType) async {
    await Future.delayed(const Duration(seconds: 1));
    return RecommendedLocationModelDomain.fromJson(_responseMock);
  }
}

String _responseMock = '''{
  "getRecommendedLocation": {
    "data": {
      "locationList": [
        {
          "playlistId": "123",
          "searchKey": "Banklangna Homestay",
          "serviceTitle": "Shangri La Bangkok",
          "hotelId": "MA15061431",
          "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg",
          "countryId": "MA05110001",
          "cityId": "MA05110041"
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
