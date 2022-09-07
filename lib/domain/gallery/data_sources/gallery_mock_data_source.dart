import 'package:ota/domain/gallery/data_sources/gallery_remote_data_source.dart';
import 'package:ota/domain/gallery/models/gallery_argument_model_domain.dart';
import 'package:ota/domain/gallery/models/gallery_model_domain.dart';
import 'package:ota/domain/gallery/models/gallery_result_model.dart';
import 'package:ota/domain/hotel/hotel_detail/models/argument_data_model.dart';

class GalleryMockDataSourceImpl implements GalleryRemoteDataSource {
  GalleryMockDataSourceImpl();
  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<GalleryResultModel> getGalleryData(
      HotelDetailDataArgument argument, String offset, String limit) async {
    await Future.delayed(const Duration(seconds: 1));
    return GalleryResultModel.fromJson(_responseMockHotel);
  }

  @override
  Future<GalleryModelDomain> getGalleryImages(
      GalleryArgumentDomain argument, String offset, String limit) async {
    await Future.delayed(const Duration(seconds: 1));
    return GalleryModelDomain.fromJson(_responseMock);
  }
}

String _responseMock = '''
  {
		"getAllTourImages": {
			"data": {
				"images": [
					"https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/jj-green-market-tour-ma2110000413-general1.jpg"
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

String _responseMockHotel = '''
      {
      	"getImages": {
      		"data": {
      			"images": {
      				"baseUri": "https://trbhmanage.travflex.com/ImageData/Hotel/",
      				"gallery": [
      					"white_house_apartment_ramkhamhaeng_65-general1.jpg",
      					"white_house_apartment_ramkhamhaeng_65-general2.jpg"
      				]
      			}
      		},
      		"status": {
      			"code": "1000",
      			"header": "Success"
      		}
      	}
      }
''';
