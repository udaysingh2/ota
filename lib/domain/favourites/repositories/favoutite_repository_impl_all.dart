import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/favourites/data_sources/favourite_remote_data_source_all.dart';
import 'package:ota/domain/favourites/models/favourites_all_model_domain.dart';

abstract class FavouritesAllRepository {
  /// Call API to get the Favourites Screen details.
  ///
  /// [Either<Failure, FavouritesResultModel>] to handle the Failure or result data.
  Future<Either<Failure, FavouritesAllModelDomain>> getFavouritesData(
    String type,
    int offset,
    int limit,
  );
}

/// FavouritesAllRepositoryImpl will contain the FavouritesAllRepository implementation.
class FavouritesAllRepositoryImpl implements FavouritesAllRepository {
  FavouriteAllRemoteDataSource? _favouritesRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  FavouritesAllRepositoryImpl(
      {FavouriteAllRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      _favouritesRemoteDataSource = FavouritesAllRemoteDataSourceImpl();
    } else {
      _favouritesRemoteDataSource = _favouritesRemoteDataSource;
    }

    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to get the Favourites Screen details.
  ///
  /// [Either<Failure, FavouritesResultModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, FavouritesAllModelDomain>> getFavouritesData(
      String type, int offset, int limit) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final favouritesResult = await _favouritesRemoteDataSource
            ?.getAllFavouritesData(type, offset, limit);
        return Right(favouritesResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
