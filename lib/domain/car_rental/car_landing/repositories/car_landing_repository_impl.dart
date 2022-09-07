import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/car_rental/car_landing/models/landing_recent_search_domain_model.dart';

import '../../../../common/network/exceptions.dart';
import '../../../../common/network/internet_info.dart';
import '../data_source/car_landing_remote_data_source.dart';
import '../models/clear_recent_search_domain_model.dart';

abstract class CarLandingRepository {
  Future<Either<Failure, LandingRecentSearchDomainModel>> getRecentSearchData(
      String serviceType, String dataSearchType);
  Future<Either<Failure, ClearRecentSearchDomainModel>> clearRecentSearch(
      String serviceType, String dataSearchType);
}

class CarLandingRepositoryImpl implements CarLandingRepository {
  CarLandingRemoteDataSource? carLandingRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  CarLandingRepositoryImpl(
      {CarLandingRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      carLandingRemoteDataSource = CarLandingRemoteDataSourceImpl();
    } else {
      carLandingRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, LandingRecentSearchDomainModel>> getRecentSearchData(
      String serviceType, String dataSearchType) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final result = await carLandingRemoteDataSource?.getRecentSearches(
            serviceType, dataSearchType);
        return Right(result!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, ClearRecentSearchDomainModel>> clearRecentSearch(
      String serviceType, String dataSearchType) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final result = await carLandingRemoteDataSource?.clearRecentSearch(
            serviceType, dataSearchType);
        return Right(result!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
