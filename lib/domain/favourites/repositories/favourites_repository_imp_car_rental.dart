import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/favourites/data_sources/favourites_remote_data_source_car_rental.dart';
import 'package:ota/domain/favourites/models/favourites_carrental_model_domain.dart';

abstract class FavouritesCarRentalRepository {
  /// Call API to get the Favourites Screen details.
  ///
  /// [Either<Failure, FavouritesResultModel>] to handle the Failure or result data.
  Future<Either<Failure, FavouritesCarRentalModelDomain>> getFavouritesData(
    String type,
    int offset,
    int limit,
  );
}

/// FavouritesRepositoryImpl will contain the FavouritesCarRentalRepository implementation.
class FavouritesCarRentalRepositoryImpl
    implements FavouritesCarRentalRepository {
  FavouriteCarRentalRemoteDataSource? _favouritesRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  FavouritesCarRentalRepositoryImpl(
      {FavouriteCarRentalRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      _favouritesRemoteDataSource = FavouritesCarRentalRemoteDataSourceImpl();
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
  Future<Either<Failure, FavouritesCarRentalModelDomain>> getFavouritesData(
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
