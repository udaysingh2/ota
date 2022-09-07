import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/loading/data_sources/loading_remote_data_source.dart';
import 'package:ota/domain/loading/models/loading_model.dart';

class LoadingRemoteDataSourceFailureMock implements LoadingRemoteDataSource {
  @override
  Future<LoadingModelData> getLoadingData(String serviceName) {
    throw exp.ServerException(null);
  }
}
