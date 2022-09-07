import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/repositories/recommended_location_repo_impl.dart';

import '../models/recommended_location_model_domain.dart';

/// Interface for RecommendedLocation use cases.
abstract class RecommendedLocationUseCases {
  /// Call API to get the RecommendedLocation Screen details.
  ///
  /// [userId] to get the RecommendedLocation Data for users.
  /// [Either<Failure, RecommendedLocationModelDomain>] to handle the Failure or result data.
  Future<Either<Failure, RecommendedLocationModelDomain>?>
      getRecommendedLocationData(String serviceType);
}

/// RecommendedLocationUseCasesImpl will contain the RecommendedLocationUseCases implementation.
class RecommendedLocationUseCasesImpl implements RecommendedLocationUseCases {
  RecommendedLocationRepository? recommendedLocationRepository;

  /// Dependence injection via constructor
  RecommendedLocationUseCasesImpl({RecommendedLocationRepository? repository}) {
    if (repository == null) {
      recommendedLocationRepository = RecommendedLocationRepositoryImpl();
    } else {
      recommendedLocationRepository = repository;
    }
  }

  /// Call API to get the RecommendedLocation details.
  ///
  /// [userId] to get the RecommendedLocation Data for users.
  /// [Either<Failure, RecommendedLocationModelDomain>] to handle the Failure or result data.
  @override
  Future<Either<Failure, RecommendedLocationModelDomain>?>
      getRecommendedLocationData(serviceType) async {
    return await recommendedLocationRepository
        ?.getRecommendedLocationData(serviceType);
  }
}
