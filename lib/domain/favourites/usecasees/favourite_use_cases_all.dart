import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/favourites/models/favourites_all_model_domain.dart';
import 'package:ota/domain/favourites/repositories/favoutite_repository_impl_all.dart';

abstract class FavouritesAllUseCases {
  /// [Either<Failure, FavouritesResultModel>] to handle the Failure or result data.
  Future<Either<Failure, FavouritesAllModelDomain>?> getFavouritesData({
    required String type,
    required int offset,
    required int limit,
  });
}

/// FavouritesUseCasesImpl will contain the FavouritesAllUseCases implementation.
class FavouritesAllUseCasesImpl implements FavouritesAllUseCases {
  FavouritesAllRepository? favouritesRepository;

  /// Dependence injection via constructor
  FavouritesAllUseCasesImpl({FavouritesAllRepository? repository}) {
    if (repository == null) {
      favouritesRepository = FavouritesAllRepositoryImpl();
    } else {
      favouritesRepository = repository;
    }
  }

  /// Call API to get the Favourites Screen Details details.
  ///
  /// [Either<Failure, FavouritesResultModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, FavouritesAllModelDomain>?> getFavouritesData({
    required String type,
    required int offset,
    required int limit,
  }) async {
    return await favouritesRepository?.getFavouritesData(type, offset, limit);
  }
}
