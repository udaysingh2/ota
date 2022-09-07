import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/favourites/data_sources/favourites_remote_data_source.dart';
import 'package:ota/domain/favourites/models/favourites_model_domain.dart';
import 'package:ota/domain/favourites/models/favourites_result_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/delete_favorite_model_domain.dart';

/// Interface for FavouritesRepository repository.
abstract class FavouritesRepository {
  /// Call API to get the Favourites Screen details.
  ///
  /// [Either<Failure, FavouritesResultModel>] to handle the Failure or result data.
  Future<Either<Failure, FavouritesResultModelDomain>> getFavouritesData(
    String type,
    int offset,
    int limit,
  );

  /// Call API to remove Favourites Hotel.
  Future<Either<Failure, DeleteFavoriteModelDomain>?> unfavouritesHotel({
    required String type,
    required String hotelId,
  });

  /// [Either<Failure, FavoritesModelDomain>] to handle the Failure or result data.
  Future<Either<Failure, FavoritesModelDomain>> getFavourites(
    String type,
    int offset,
    int limit,
  );
}

/// FavouritesRepositoryImpl will contain the FavouritesRepository implementation.
class FavouritesRepositoryImpl implements FavouritesRepository {
  FavouritesRemoteDataSource? favouritesRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  FavouritesRepositoryImpl(
      {FavouritesRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      favouritesRemoteDataSource = FavouritesRemoteDataSourceImpl();
    } else {
      favouritesRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, FavouritesResultModelDomain>> getFavouritesData(
      String type, int offset, int limit) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final favouritesResult = await favouritesRemoteDataSource
            ?.getFavouritesData(type, offset, limit);
        return Right(favouritesResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }

  /// Call API to remove Favourites Hotel.
  @override
  Future<Either<Failure, DeleteFavoriteModelDomain>?> unfavouritesHotel({
    required String type,
    required String hotelId,
  }) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final result = await favouritesRemoteDataSource?.unfavouritesHotel(
            type: type, hotelId: hotelId);
        return Right(result!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }

// call the Api to get favorites data
  @override
  Future<Either<Failure, FavoritesModelDomain>> getFavourites(
      String type, int offset, int limit) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final favouritesResult = await favouritesRemoteDataSource
            ?.getFavourites(type, offset, limit);
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
