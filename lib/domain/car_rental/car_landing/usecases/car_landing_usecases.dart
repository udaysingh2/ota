import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';

import '../models/landing_recent_search_domain_model.dart';
import '../repositories/car_landing_repository_impl.dart';

abstract class CarLandingUseCase {
  Future<Either<Failure, LandingRecentSearchDomainModel>?> getRecentSearches(
      String serviceType, String dataSearchType);
}

class CarLandingUseCaseImpl implements CarLandingUseCase {
  CarLandingRepository? carLandingRepository;
  CarLandingUseCaseImpl({CarLandingRepository? repository}) {
    if (repository == null) {
      carLandingRepository = CarLandingRepositoryImpl();
    } else {
      carLandingRepository = repository;
    }
  }

  @override
  Future<Either<Failure, LandingRecentSearchDomainModel>?> getRecentSearches(
      String serviceType, String dataSearchType) async {
    return await carLandingRepository?.getRecentSearchData(
        serviceType, dataSearchType);
  }
}
