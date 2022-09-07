import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/tours/review_reservation/models/pickup_point_model_domain.dart';
import 'package:ota/domain/tours/review_reservation/repositories/pickup_point_repository_impl.dart';

/// Interface for PickUpPoint use cases.
abstract class PickUpPointUseCases {
  Future<Either<Failure, PickUpPointDomain>?> getPickUpPointDetail(
      String zoneId);
}

class PickUpPointUseCasesImpl implements PickUpPointUseCases {
  PickUpPointRepository? repository;

  /// Dependence injection via constructor
  PickUpPointUseCasesImpl({PickUpPointRepository? repository}) {
    if (repository == null) {
      this.repository = PickUpPointRepositoryImpl();
    } else {
      this.repository = repository;
    }
  }

  @override
  Future<Either<Failure, PickUpPointDomain>?> getPickUpPointDetail(
      String zoneId) async {
    return await repository?.getPickUpPointDetail(zoneId);
  }
}
