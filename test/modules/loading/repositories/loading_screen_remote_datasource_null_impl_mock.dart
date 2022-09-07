import 'package:ota/domain/loading/data_sources/loading_remote_data_source.dart';
import 'package:ota/domain/loading/models/loading_model.dart';

import '../../../mocks/fixture_reader.dart';

class LoadingDataSourceImplNullDataMock implements LoadingRemoteDataSource {
  @override
  Future<LoadingModelData> getLoadingData(String serviceName) async {
    String json = fixture("loading/loading_null_data.json");
    LoadingModelData loadingModelData = LoadingModelData.fromJson(json);
    return loadingModelData;
  }
}
