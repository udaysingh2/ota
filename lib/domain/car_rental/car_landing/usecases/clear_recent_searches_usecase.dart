import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';

import '../models/clear_recent_search_domain_model.dart';
import '../repositories/car_landing_repository_impl.dart';

abstract class ClearRecentSearchesUsecase {
  Future<Either<Failure, ClearRecentSearchDomainModel>?> clearRecentSearch(
      String serviceType, String dataSearchType);
}

class CarLandingClearUseCaseImpl implements ClearRecentSearchesUsecase {
  CarLandingRepository? carLandingRepository;
  CarLandingClearUseCaseImpl({CarLandingRepository? repository}) {
    if (repository == null) {
      carLandingRepository = CarLandingRepositoryImpl();
    } else {
      carLandingRepository = repository;
    }
  }

  @override
  Future<Either<Failure, ClearRecentSearchDomainModel>?> clearRecentSearch(
      String serviceType, String dataSearchType) async {
    return await carLandingRepository?.clearRecentSearch(
        serviceType, dataSearchType);
  }
}
