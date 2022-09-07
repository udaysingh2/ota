import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/splash/data_sources/splash_remote_data_source.dart';
import 'package:ota/domain/splash/models/splash_model.dart';

/// Interface for SplashRepository repository.
abstract class SplashRepository {
  /// Call API to get the splash Screen details.
  ///
  /// [Either<Failure, SplashModel>] to handle the Failure or result data.
  Future<Either<Failure, SplashModel>> getSplashData();
}

/// SplashRepositoryImpl will contain the SplashRepository implementation.
class SplashRepositoryImpl implements SplashRepository {
  SplashRemoteDataSource? splashRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  SplashRepositoryImpl(
      {SplashRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      splashRemoteDataSource = SplashRemoteDataSourceImpl();
    } else {
      splashRemoteDataSource = remoteDataSource;
    }
    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to get the splash Screen details.
  ///
  /// [shipId] to get the Splash Data for users.
  /// [Either<Failure, SplashModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, SplashModel>> getSplashData() async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final splashResult = await splashRemoteDataSource?.getSplashData();
        return Right(splashResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
