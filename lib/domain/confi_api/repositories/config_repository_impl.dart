import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/confi_api/data_sources/config_remote_data_source.dart';
import 'package:ota/domain/confi_api/models/config_result_model.dart';

abstract class ConfigRepository {
  Future<Either<Failure, ConfigResultModel>> getConfigDetails();
}

class ConfigRepositoryImpl implements ConfigRepository {
  ConfigRemoteDataSource? configRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  /// Dependence injection via constructor
  ConfigRepositoryImpl(
      {ConfigRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      configRemoteDataSource = ConfigRemoteDataSourceImpl();
    } else {
      configRemoteDataSource = remoteDataSource;
    }

    if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  @override
  Future<Either<Failure, ConfigResultModel>> getConfigDetails() async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final configResult = await configRemoteDataSource?.getConfigDetails();
        return Right(configResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
