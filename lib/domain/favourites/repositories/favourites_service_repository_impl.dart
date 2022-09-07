import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/favourites/data_sources/favourites_service_remote_data_source.dart';
import 'package:ota/domain/favourites/models/favourites_add_service_domain.dart';
import 'package:ota/domain/favourites/models/favourites_check_service_domain.dart';
import 'package:ota/domain/favourites/models/favourites_remove_service_domain.dart';
import 'package:ota/domain/favourites/models/ota_favourite_argument_model_domain.dart';
import 'package:ota/domain/favourites/models/unfavourite_model_domain.dart';

/// Interface for FavouritesRepository repository.
abstract class FavouritesServiceRepository {
  /// Call API to check Favourite service status.
  Future<Either<Failure, FavouriteCheckServiceDomain>?> checkFavorite(
      {required String serviceName, required String serviceId});

  /// Call API to remove Favourite service.
  Future<Either<Failure, FavouriteRemoveServiceDomain>?> removeFavorite(
      {required String serviceName, required String serviceId});

  /// Call API to add Favourite service.
  Future<Either<Failure, FavouriteAddServiceDomain>?> markFavorite(
      {required OtaFavoritesArgumentDomainModel favoriteArgumentModel});

  /// Call API to remove Favourites All.
  Future<Either<Failure, UnFavouriteModelDomain>?> unFavouriteCarRental(
      {required String serviceName,
      required String carId,
      required String supplierId});

  /// Call API to remove Favourites Hotel.
  Future<Either<Failure, UnFavouriteModelDomain>?> unfavouritesHotel({
    required String serviceName,
    required String hotelId,
  });

  /// Call API to remove Favourites Tour.
  Future<Either<Failure, UnFavouriteModelDomain>?> unfavouritesTour({
    required String serviceName,
    required String serviceId,
  });
}

/// FavouritesRepositoryImpl will contain the FavouritesRepository implementation.
class FavouritesServiceRepositoryImpl implements FavouritesServiceRepository {
  FavouritesServiceRemoteDataSource? _favouritesRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  FavouritesServiceRepositoryImpl(
      {FavouritesServiceRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      _favouritesRemoteDataSource = FavouritesServiceRemoteDataSourceImpl();
    } else {
      _favouritesRemoteDataSource = remoteDataSource;
    }

    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to check Favourites service status.
  @override
  Future<Either<Failure, FavouriteCheckServiceDomain>?> checkFavorite({
    required String serviceName,
    required String serviceId,
  }) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final result = await _favouritesRemoteDataSource?.checkFavorite(
            serviceName: serviceName, serviceId: serviceId);
        return Right(result!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }

  /// Call API to remove Favourite sservice.
  @override
  Future<Either<Failure, FavouriteRemoveServiceDomain>?> removeFavorite({
    required String serviceName,
    required String serviceId,
  }) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final result = await _favouritesRemoteDataSource?.removeFavorite(
            serviceName: serviceName, serviceId: serviceId);
        return Right(result!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }

  /// Call API to add Favourite sservice.
  @override
  Future<Either<Failure, FavouriteAddServiceDomain>?> markFavorite(
      {required OtaFavoritesArgumentDomainModel favoriteArgumentModel}) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final result = await _favouritesRemoteDataSource?.markFavorite(
            favoriteArgumentModel: favoriteArgumentModel);
        return Right(result!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }

  /// Call API to remove Favourites All.
  @override
  Future<Either<Failure, UnFavouriteModelDomain>?> unFavouriteCarRental(
      {required String serviceName,
      required String carId,
      required String supplierId}) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final result = await _favouritesRemoteDataSource?.unFavouriteCarRental(
            serviceName: serviceName, carId: carId, supplierId: supplierId);
        return Right(result!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }

  /// Call API to remove Favourites All.
  @override
  Future<Either<Failure, UnFavouriteModelDomain>?> unfavouritesHotel({
    required String serviceName,
    required String hotelId,
  }) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final result = await _favouritesRemoteDataSource?.unfavouritesHotel(
            serviceName: serviceName, hotelId: hotelId);
        return Right(result!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }

  /// Call API to remove Favourites All.
  @override
  Future<Either<Failure, UnFavouriteModelDomain>?> unfavouritesTour({
    required String serviceName,
    required String serviceId,
  }) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final result = await _favouritesRemoteDataSource?.unfavouritesTour(
            serviceName: serviceName, serviceId: serviceId);
        return Right(result!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
