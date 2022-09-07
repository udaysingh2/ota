import 'package:ota/domain/popup/data_sources/popup_remote_data_source.dart';
import 'package:ota/domain/popup/models/popup_models.dart';

class PopupMockDataSourceImpl implements PopupRemoteDataSource {
  PopupMockDataSourceImpl();

  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<PopupModelDomain> getPopup() async {
    await Future.delayed(const Duration(milliseconds: 1));
    return PopupModelDomain.fromJson(_responseMock);
  }
}

var _responseMock = '''
  {
    "getPopups": {
      "data": {
        "popups": [
          {
            "popupId": "1",
            "type": "GLOBAL",
            "startDate": "2021-10-29T08:44:39",
            "endDate": "2023-01-30T08:44:39",
            "priority": "1",
            "imageFilename": "https://robinhood/01_EN.jpg",
            "deeplinkUrl": "http://img01-deeplink",
            "deeplinkType": "EXTERNAL",
            "function": "OTA_LANDING",
            "orderSection": "1"
          }
        ]
      },
      "status": {
        "code": "1000",
        "header": "Success",
        "description": "null"
      }
    }
  }
''';
