import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/landing/data_sources/sync_car_recent_remote_data_source.dart';
import 'package:ota/domain/landing/models/sync_car_recent_search_model.dart';
import 'package:ota/modules/car_rental/car_landing/db_models/car_recent_search_model.dart';

abstract class SyncRecentSearchRepository {
  Future<Either<Failure, SyncCarRecentSearchDomainModel?>?>
      syncRecentSearchData(List<CarRecentSearchData> data, String userId,
          String searchKey, bool searchAvailableApi, bool includeDriver);
}

class SyncRecentSearchRepositoryImpl implements SyncRecentSearchRepository {
  SyncCarRecentRemoteDataSource? syncCarRecentRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  SyncRecentSearchRepositoryImpl(
      {SyncCarRecentRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      syncCarRecentRemoteDataSource = RecentSearchRemoteDataSourceImpl();
    } else {
      syncCarRecentRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, SyncCarRecentSearchDomainModel?>?>
      syncRecentSearchData(List<CarRecentSearchData> data, String userId,
          String searchKey, bool searchAvailableApi, bool includeDriver) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final result =
            await syncCarRecentRemoteDataSource?.syncRecentSearchData(
                data, userId, searchKey, searchAvailableApi, includeDriver);
        return Right(result);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
