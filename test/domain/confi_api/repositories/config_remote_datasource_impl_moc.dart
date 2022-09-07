import 'package:ota/domain/confi_api/data_sources/config_remote_data_source.dart';
import 'package:ota/domain/confi_api/models/config_result_model.dart';

import '../../../mocks/fixture_reader.dart';

class ConfigRemoteDataSourceImplSuccessMock implements ConfigRemoteDataSource {
  @override
  Future<ConfigResultModel> getConfigDetails() async {
    String json = fixture("config/config_result_model.json");

    ///Convert into Model
    ConfigResultModel model = ConfigResultModel.fromJson(json);
    return model;
  }
}
