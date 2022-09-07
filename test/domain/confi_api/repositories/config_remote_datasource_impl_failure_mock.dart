import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/confi_api/data_sources/config_remote_data_source.dart';
import 'package:ota/domain/confi_api/models/config_result_model.dart';

class ConfigRemoteDataSourceFailureMock implements ConfigRemoteDataSource {
  @override
  Future<ConfigResultModel> getConfigDetails() {
    throw exp.ServerException(null);
  }
}
