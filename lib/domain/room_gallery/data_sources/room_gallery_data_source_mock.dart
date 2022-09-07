import 'package:ota/domain/room_gallery/models/room_gallery_argument_domain.dart';
import 'package:ota/domain/room_gallery/models/room_gallery_model_domain.dart';

import 'room_gallery_remote_data_source.dart';

class RoomGalleryMockDataSourceImpl implements RoomGalleryRemoteDataSource {
  RoomGalleryMockDataSourceImpl();
  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<RoomGalleryModelDomain> getRoomGalleryData(
      RoomGalleryArgumentDomain argument, int offset, int limit) async {
    await Future.delayed(const Duration(seconds: 1));
    return RoomGalleryModelDomain.fromJson(_responseMock);
  }
}

var _responseMock = '''
{
  "getRoomImages": {
    "data": {
      "roomImageCount": 1,
      "coverImage": "https://trbhmanage.travflex.com/ImageData/Hotel/courtyard_by_marriott_bangkok_(sha_plus)-deluxe-overview1.jpg",
      "images": [
        {
          "picSeq": "1",
          "activeFlag": "Y",
          "URL": "https://trbhmanage.travflex.com/ImageData/Hotel/courtyard_by_marriott_bangkok_(sha_plus)-deluxe-overview1.jpg"
        },
        {
          "picSeq": "1",
          "activeFlag": "Y",
          "URL": "https://trbhmanage.travflex.com/ImageData/Hotel/courtyard_by_marriott_bangkok_(sha_plus)-deluxe-overview1.jpg"
        },
        {
          "picSeq": "1",
          "activeFlag": "Y",
          "URL": "https://trbhmanage.travflex.com/ImageData/Hotel/courtyard_by_marriott_bangkok_(sha_plus)-deluxe-overview1.jpg"
        },
        {
          "picSeq": "1",
          "activeFlag": "Y",
          "URL": "https://trbhmanage.travflex.com/ImageData/Hotel/courtyard_by_marriott_bangkok_(sha_plus)-deluxe-overview1.jpg"
        }
      ]
    },
    "status": {
      "description": null,
      "header": "Success",
      "code": "1000"
    }
  }
}
''';
