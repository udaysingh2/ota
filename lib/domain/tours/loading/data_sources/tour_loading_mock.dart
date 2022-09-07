
import 'package:ota/domain/tours/loading/data_sources/tour_loading_remote_data_source.dart';
import 'package:ota/domain/tours/loading/models/tour_loading_model.dart';

class OtaLoadingMockDataSourceImpl implements TourLoadingRemoteDataSource {
  OtaLoadingMockDataSourceImpl();
  @override
  Future<TourLoadingData> getTourLoadingData() async {
    await Future.delayed(const Duration(milliseconds: 10));
    return TourLoadingData.fromJson(_responseMock);
  }
}

var _responseMock = """
{
	"getTourServiceCards": {
		"data": {
			"serviceBackgroundUrl": "https://www.linkpicture.com/q/hotel_card.png"
		},
		"status": {
			"code": "1000",
			"header": "Success",
			"description": null
		}
	}
}
""";
