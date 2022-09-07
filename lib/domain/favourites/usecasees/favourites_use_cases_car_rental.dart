import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/favourites/models/favourites_carrental_model_domain.dart';
import '../repositories/favourites_repository_imp_car_rental.dart';

abstract class FavouritesCarRentalUseCases {
  /// [Either<Failure, FavouritesResultModel>] to handle the Failure or result data.
  Future<Either<Failure, FavouritesCarRentalModelDomain>?> getFavouritesData({
    required String type,
    required int offset,
    required int limit,
  });
}

/// FavouritesUseCasesImpl will contain the FavouritesCarRentalUseCases implementation.
class FavouritesCarRentalUseCasesImpl implements FavouritesCarRentalUseCases {
  FavouritesCarRentalRepository? favouritesRepository;

  /// Dependence injection via constructor
  FavouritesCarRentalUseCasesImpl({FavouritesCarRentalRepository? repository}) {
    if (repository == null) {
      favouritesRepository = FavouritesCarRentalRepositoryImpl();
    } else {
      favouritesRepository = repository;
    }
  }

  /// Call API to get the Favourites Screen Details details.
  ///
  /// [Either<Failure, FavouritesResultModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, FavouritesCarRentalModelDomain>?> getFavouritesData({
    required String type,
    required int offset,
    required int limit,
  }) async {
    return await favouritesRepository?.getFavouritesData(type, offset, limit);
  }
}
