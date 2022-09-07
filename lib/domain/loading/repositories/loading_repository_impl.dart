import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/core_pack/caching/ota_preference.dart';
import 'package:ota/domain/loading/data_sources/loading_remote_data_source.dart';
import 'package:ota/domain/loading/data_sources/loading_shared_data_source.dart';
import 'package:ota/domain/loading/models/loading_model.dart';

abstract class LoadingRepository {
  /// Call API to get the loading Screen details.
  ///
  /// [tourId] to get the loading Data for users.
  /// [Either<Failure, loadingResultModel>] to handle the Failure or result data.
  Future<Either<Failure, LoadingModelData>> getLoadingData(String serviceName);
}

/// loadingRepositoryImpl will contain the loadingRepository implementation.
class LoadingRepositoryImpl implements LoadingRepository {
  LoadingRemoteDataSource? loadingRemoteDataSource;
  LoadingSharedDataSource? loadingSharedDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  /// Dependence injection via constructor
  LoadingRepositoryImpl(
      {LoadingRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo,
      LoadingSharedDataSource? sharedDataSource}) {
    if (_loadingRemoteDataSource != null) {
      loadingRemoteDataSource = _loadingRemoteDataSource;
    } else if (remoteDataSource == null) {
      loadingRemoteDataSource = LoadingRemoteDataSourceImpl();
    } else {
      loadingRemoteDataSource = remoteDataSource;
    }

    if (sharedDataSource == null) {
      loadingSharedDataSource = LoadingSharedDataSourceImpl();
    } else {
      loadingSharedDataSource = sharedDataSource;
    }

    if (_internetConnectionInfo != null) {
      internetConnectionInfo = _internetConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to get the loading Screen details.
  ///
  /// [tourId] to get the loading Data for users.
  /// [Either<Failure, loadingResultModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, LoadingModelData>> getLoadingData(
      String serviceName) async {
    final DateTime dateTime = DateTime.now();
    final String dateString =
        "${dateTime.day}-${dateTime.month}-${dateTime.year}";

    if (await OtaPreference.shared.getLoadingJsonData() == null ||
        await OtaPreference.shared.getLoadingApiFetchedDate() == null) {
      if (await (internetConnectionInfo?.isConnected) ?? false) {
        try {
          final loadingResult =
              await loadingRemoteDataSource?.getLoadingData(serviceName);
          OtaPreference.shared.setLoadingApiFetchedDate(dateString);
          return Right(loadingResult!);
        } on ServerException catch (error) {
          return Left(ServerFailure(exception: error.exception));
        }
      } else {
        /// Change this To Local dataSource if internet fails Sqlite or SharePreference
        return Left(InternetFailure());
      }
    } else if (await OtaPreference.shared.getLoadingApiFetchedDate() !=
            dateString &&
        await OtaPreference.shared.getLoadingJsonData() != null) {
      if (await (internetConnectionInfo?.isConnected) ?? false) {
        try {
          final loadingResult =
              await loadingRemoteDataSource?.getLoadingData(serviceName);
          OtaPreference.shared.setLoadingApiFetchedDate(dateString);
          return Right(loadingResult!);
        } on ServerException catch (error) {
          return Left(ServerFailure(exception: error.exception));
        }
      } else {
        final loadingResult = await loadingSharedDataSource?.getLoadingData();
        return Right(loadingResult!);
      }
    } else {
      final loadingResult = await loadingSharedDataSource?.getLoadingData();
      return Right(loadingResult!);
    }
  }
}

LoadingRemoteDataSource? _loadingRemoteDataSource;
InternetConnectionInfo? _internetConnectionInfo;
void mockLoadingData(
    {LoadingRemoteDataSource? remoteDataSource,
    InternetConnectionInfo? internetInfo}) {
  _loadingRemoteDataSource = remoteDataSource;
  _internetConnectionInfo = internetInfo;
}
