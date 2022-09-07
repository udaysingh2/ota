import 'package:ota/domain/loading/data_sources/loading_shared_data_source.dart';
import 'package:ota/domain/loading/models/loading_model.dart';

import '../../../mocks/fixture_reader.dart';

class LoadingSharedMockDataSourceImpl implements LoadingSharedDataSource {
  @override
  Future<LoadingModelData> getLoadingData() async {
    String json = fixture("loading/loading_data.json");
    LoadingModelData loadingModelData = LoadingModelData.fromJson(json);
    return loadingModelData;
  }
}
