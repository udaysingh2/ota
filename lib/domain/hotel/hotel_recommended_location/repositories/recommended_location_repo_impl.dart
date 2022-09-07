import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';

import '../data_sources/recommended_location_remote_data_source.dart';
import '../models/recommended_location_model_domain.dart';

///Interface for RecommendedLocationRepository repository
abstract class RecommendedLocationRepository {
  Future<Either<Failure, RecommendedLocationModelDomain>>
      getRecommendedLocationData(String serviceType);
}

class RecommendedLocationRepositoryImpl
    implements RecommendedLocationRepository {
  RecommendedLocationRemoteDataSource? recommendedLocationRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  RecommendedLocationRepositoryImpl(
      {RecommendedLocationRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      recommendedLocationRemoteDataSource =
          RecommendedLocationRemoteDataSourceImpl();
    } else {
      recommendedLocationRemoteDataSource = remoteDataSource;
    }
    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  @override
  Future<Either<Failure, RecommendedLocationModelDomain>>
      getRecommendedLocationData(String serviceType) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final recommendedResult = await recommendedLocationRemoteDataSource
            ?.getRecommendedLocationData(serviceType);
        return Right(recommendedResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
