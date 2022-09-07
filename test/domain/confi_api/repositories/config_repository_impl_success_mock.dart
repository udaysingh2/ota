import 'package:ota/common/network/internet_info.dart';
import 'package:ota/common/network/failures.dart';
import 'package:either_dart/src/either.dart';
import 'package:ota/domain/confi_api/data_sources/config_remote_data_source.dart';
import 'package:ota/domain/confi_api/models/config_result_model.dart';
import 'package:ota/domain/confi_api/repositories/config_repository_impl.dart';

import '../../../mocks/fixture_reader.dart';

class ConfigRepositoryImplSuccessMock implements ConfigRepositoryImpl {
  @override
  ConfigRemoteDataSource? configRemoteDataSource;

  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  Future<Either<Failure, ConfigResultModel>> getConfigDetails() async {
    String json = fixture("config/config_result_model.json");

    ///Convert into Model
    ConfigResultModel model = ConfigResultModel.fromJson(json);
    return Right(model);
  }
}
