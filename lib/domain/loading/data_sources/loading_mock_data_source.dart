import 'package:ota/core_pack/caching/ota_preference.dart';
import 'package:ota/domain/loading/data_sources/loading_remote_data_source.dart';
import 'package:ota/domain/loading/models/loading_model.dart';

class LoadingMockDataSourceImpl implements LoadingRemoteDataSource {
  LoadingMockDataSourceImpl();
  @override
  Future<LoadingModelData> getLoadingData(String serviceName) async {
    await Future.delayed(const Duration(milliseconds: 10));
    OtaPreference.shared.setLoadingJsonData(_responseMock);
    return LoadingModelData.fromJson(_responseMock);
  }
}

var _responseMock = """
{
  "getLoadScreen": {
    "data": {
      "loadScreenUrl": "https://www.linkpicture.com/q/hotel_card.png"
    },
    "status": {
      "code": "1000",
      "header": "Success"
    }
  }
}
""";
