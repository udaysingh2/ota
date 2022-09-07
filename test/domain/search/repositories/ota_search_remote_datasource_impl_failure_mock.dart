import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/search/data_sources/ota_search_remote_data_source.dart';
import 'package:ota/domain/search/models/ota_search_argument.dart';
import 'package:ota/domain/search/models/ota_search_model.dart';

class OtaSearchRemoteDataSourceFailureMock
    implements OtaSearchRemoteDataSource {
  @override
  Future<OtaSearchData> getOtaSearchData(OtaSearchDataArgument argument) async {
    throw exp.ServerException(null);
  }
}
