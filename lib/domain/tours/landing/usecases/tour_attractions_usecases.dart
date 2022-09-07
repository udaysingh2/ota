import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/tours/landing/models/tour_attractions_model_domain.dart';
import 'package:ota/domain/tours/landing/repositories/tour_attractions_repository_impl.dart';

abstract class TourAttractionsUseCases {
  Future<Either<Failure, TourAttractionsModelDomain?>?> getTourAttractionsData(
      String serviceType);
}

class TourAttractionsUseCasesImpl implements TourAttractionsUseCases {
  TourAttractionsRepository? tourAttractionsRepository;

  TourAttractionsUseCasesImpl({TourAttractionsRepository? repository}) {
    if (repository == null) {
      tourAttractionsRepository = TourAttractionsRepositoryImpl();
    } else {
      tourAttractionsRepository = repository;
    }
  }
  @override
  Future<Either<Failure, TourAttractionsModelDomain?>?> getTourAttractionsData(
      String serviceType) async {
    return await tourAttractionsRepository?.getTourAttractionsData(serviceType);
  }
}
