//import 'package:ota/domain/room_gallery/models/room_gallery_argument_domain.dart';
//import 'package:ota/domain/room_gallery/models/room_gallery_model_domain.dart';
import 'package:ota/domain/car_rental/car_gallery/models/car_gallery_argument_domain.dart';
import 'package:ota/domain/car_rental/car_gallery/models/car_gallery_model_domain.dart';

//import 'car_gallery_remote_data_source.dart';
import 'car_gallery_remote_data_source.dart';
//Car Rental

class CarGalleryMockDataSourceImpl implements CarGalleryRemoteDataSource {
  CarGalleryMockDataSourceImpl();
  static String getMockData() {
    return _responseMock;
  }

  static String getNoRespMockData() {
    return _noResponseMock;
  }

  @override
  Future<CarGalleryModelDomain> getCarGalleryData(
      CarGalleryArgumentDomain argument, int offset, int limit) async {
    await Future.delayed(const Duration(seconds: 1));
    return CarGalleryModelDomain.fromJson(_responseMock);
  }
}

var _responseMock = '''
{
  "data": {
    "getAllCarRentalImages": {
      "data": {
        "id": "2",
        "images": [
          {
            "thumb": "https://trbhmanage.travflex.com/imagedata/Car/800/vios-2-1.jpg",
            "full": "https://trbhmanage.travflex.com/ImageData/Car/vios-2-1.jpg"
          },
          {
            "thumb": "https://trbhmanage.travflex.com/imagedata/Car/800/vios-2-2.jpg",
            "full": "https://trbhmanage.travflex.com/ImageData/Car/vios-2-2.jpg"
          },
          {
            "thumb": "https://trbhmanage.travflex.com/imagedata/Car/800/vios-2-3.jpg",
            "full": "https://trbhmanage.travflex.com/ImageData/Car/vios-2-3.jpg"
          },
          {
            "thumb": "https://trbhmanage.travflex.com/imagedata/Car/800/vios-2-4.jg",
            "full": "https://trbhmanage.travflex.com/ImageData/Car/vios-2-4.jg"
          }
        ]
      }
    }
  }
}
''';
var _noResponseMock = '''
{
  "data": {
    "getAllCarRentalImages": {
      "data": null
    }
  }
}
''';
