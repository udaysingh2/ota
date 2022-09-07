import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/favourites/models/favourites_add_service_domain.dart';
import 'package:ota/domain/favourites/models/favourites_check_service_domain.dart';
import 'package:ota/domain/favourites/models/favourites_remove_service_domain.dart';
import 'package:ota/domain/favourites/models/ota_favourite_argument_model_domain.dart';
import 'package:ota/domain/favourites/models/unfavourite_model_domain.dart';
import 'package:ota/domain/favourites/repositories/favourites_service_repository_impl.dart';

/// Interface for Favourites use cases.
abstract class FavouritesServiceUseCases {
  /// Call API to check Favourite service status.
  Future<Either<Failure, FavouriteCheckServiceDomain>?> checkFavorite(
      {required String serviceName, required String serviceId});

  /// Call API to remove Favourite service.
  Future<Either<Failure, FavouriteRemoveServiceDomain>?> removeFavorite(
      {required String serviceName, required String serviceId});

  /// Call API to add Favourite service.
  Future<Either<Failure, FavouriteAddServiceDomain>?> markFavorite(
      {required OtaFavoritesArgumentDomainModel favoriteArgumentModel});

  /// Call API to remove Favourites Car Rental.
  Future<Either<Failure, UnFavouriteModelDomain>?> unFavouriteCarRental(
      {required String serviceName,
      required String carId,
      required String supplierId});

  /// Call API to remove Favourites Hotel.
  Future<Either<Failure, UnFavouriteModelDomain>?> unfavouriteHotel({
    required String serviceName,
    required String hotelId,
  });

  /// Call API to remove Favourites Hotel.
  Future<Either<Failure, UnFavouriteModelDomain>?> unfavouriteTours({
    required String serviceName,
    required String serviceId,
  });
}

/// FavouritesServiceUseCasesImpl will contain the FavouritesUseCases implementation.
class FavouritesServiceUseCasesImpl implements FavouritesServiceUseCases {
  FavouritesServiceRepository? favouritesRepository;

  /// Dependence injection via constructor
  FavouritesServiceUseCasesImpl({FavouritesServiceRepository? repository}) {
    if (repository == null) {
      favouritesRepository = FavouritesServiceRepositoryImpl();
    } else {
      favouritesRepository = repository;
    }
  }

  /// Call API to check Favourite service status.
  @override
  Future<Either<Failure, FavouriteCheckServiceDomain>?> checkFavorite(
      {required String serviceName, required String serviceId}) async {
    return await favouritesRepository?.checkFavorite(
        serviceName: serviceName, serviceId: serviceId);
  }

  /// Call API to remove Favourites Hotel.
  @override
  Future<Either<Failure, FavouriteRemoveServiceDomain>?> removeFavorite(
      {required String serviceName, required String serviceId}) async {
    return await favouritesRepository?.removeFavorite(
        serviceName: serviceName, serviceId: serviceId);
  }

  /// Call API to add Favourites service.
  @override
  Future<Either<Failure, FavouriteAddServiceDomain>?> markFavorite(
      {required OtaFavoritesArgumentDomainModel favoriteArgumentModel}) async {
    return await favouritesRepository?.markFavorite(
        favoriteArgumentModel: favoriteArgumentModel);
  }

  /// Call API to remove Favourites All.
  @override
  Future<Either<Failure, UnFavouriteModelDomain>?> unFavouriteCarRental(
      {required String serviceName,
      required String carId,
      required String supplierId}) async {
    return await favouritesRepository?.unFavouriteCarRental(
      serviceName: serviceName,
      carId: carId,
      supplierId: supplierId,
    );
  }

  /// Call API to remove Favourites All.
  @override
  Future<Either<Failure, UnFavouriteModelDomain>?> unfavouriteHotel({
    required String serviceName,
    required String hotelId,
  }) async {
    return await favouritesRepository?.unfavouritesHotel(
      serviceName: serviceName,
      hotelId: hotelId,
    );
  }

  /// Call API to remove Favourites All.
  @override
  Future<Either<Failure, UnFavouriteModelDomain>?> unfavouriteTours({
    required String serviceName,
    required String serviceId,
  }) async {
    return await favouritesRepository?.unfavouritesTour(
      serviceName: serviceName,
      serviceId: serviceId,
    );
  }
}
