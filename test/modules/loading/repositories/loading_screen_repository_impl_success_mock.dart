import 'package:either_dart/src/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/loading/data_sources/loading_remote_data_source.dart';
import 'package:ota/domain/loading/data_sources/loading_shared_data_source.dart';
import 'package:ota/domain/loading/models/loading_model.dart';
import 'package:ota/domain/loading/repositories/loading_repository_impl.dart';

import '../../../mocks/fixture_reader.dart';

class LoadingRepositoryImplSuccessMock implements LoadingRepositoryImpl {
  @override
  InternetConnectionInfo? internetConnectionInfo;
  @override
  LoadingRemoteDataSource? loadingRemoteDataSource;
  @override
  LoadingSharedDataSource? loadingSharedDataSource;

  @override
  Future<Either<Failure, LoadingModelData>> getLoadingData(
      String serviceName) async {
    String json = fixture("loading/loading_data.json");
    LoadingModelData loadingModelData = LoadingModelData.fromJson(json);
    return Right(loadingModelData);
  }
}
