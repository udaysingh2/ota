import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/favourites/models/favourites_model_domain.dart';
import 'package:ota/domain/favourites/models/favourites_result_model_domain.dart';
import 'package:ota/domain/favourites/repositories/favourites_repository_impl.dart';
import 'package:ota/domain/hotel/hotel_detail/models/delete_favorite_model_domain.dart';

/// Interface for Favourites use cases.
abstract class FavouritesUseCases {
  /// Call API to get the Favourites Screen details.
  ///
  /// [Either<Failure, FavouritesResultModel>] to handle the Failure or result data.
  Future<Either<Failure, FavouritesResultModelDomain>?> getFavouritesData({
    required String type,
    required int offset,
    required int limit,
  });

  /// Call API to remove Favourites Hotel.
  Future<Either<Failure, DeleteFavoriteModelDomain>?> unfavouritesHotel({
    required String type,
    required String hotelId,
  });

  /// [Either<Failure, FavoritesModelDomain>] to handle the Failure or result data.
  Future<Either<Failure, FavoritesModelDomain>?> getFavourites({
    required String type,
    required int offset,
    required int limit,
  });
}

/// FavouritesUseCasesImpl will contain the FavouritesUseCases implementation.
class FavouritesUseCasesImpl implements FavouritesUseCases {
  FavouritesRepository? favouritesRepository;

  /// Dependence injection via constructor
  FavouritesUseCasesImpl({FavouritesRepository? repository}) {
    if (repository == null) {
      favouritesRepository = FavouritesRepositoryImpl();
    } else {
      favouritesRepository = repository;
    }
  }

  /// Call API to get the Favourites Screen Details details.
  ///
  /// [Either<Failure, FavouritesResultModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, FavouritesResultModelDomain>?> getFavouritesData({
    required String type,
    required int offset,
    required int limit,
  }) async {
    return await favouritesRepository?.getFavouritesData(type, offset, limit);
  }

  /// Call API to remove Favourites Hotel.
  @override
  Future<Either<Failure, DeleteFavoriteModelDomain>?> unfavouritesHotel({
    required String type,
    required String hotelId,
  }) async {
    return await favouritesRepository?.unfavouritesHotel(
        type: type, hotelId: hotelId);
  }

  @override
  Future<Either<Failure, FavoritesModelDomain>?> getFavourites({
    required String type,
    required int offset,
    required int limit,
  }) async {
    return await favouritesRepository?.getFavourites(type, offset, limit);
  }
}
