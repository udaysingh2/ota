import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/tours/loading/models/tour_loading_model.dart';
import 'package:ota/domain/tours/loading/repositories/tour_loading_repository_impl.dart';

/// Interface for Hotel addon services use cases.
abstract class TourLoadingUseCases {
  /// Call API to get the Hotel addon services Screen details.
  ///
  /// [serviceDataArgument] to get the Hotel addon services Data for users.
  /// [Either<Failure, HotelServiceResultModel>] to handle the Failure or result data.
  Future<Either<Failure, TourLoadingData>?> getLoadingData();
}

/// HotelServiceUseCasesImpl will contain the HotelServiceUseCases implementation.
class TourLoadingUseCasesImpl implements TourLoadingUseCases {
  TourLoadingRepository? tourLoadingRepository;

  /// Dependence injection via constructor
  TourLoadingUseCasesImpl({TourLoadingRepository? repository}) {
    if (repository == null) {
      tourLoadingRepository = TourLoadingRepositoryImpl();
    } else {
      tourLoadingRepository = repository;
    }
  }

  /// Call API to get the Hotel addon services Screen Details details.
  ///
  /// [serviceDataArgument] to get the Hotel addon services Data for users.
  /// [Either<Failure, HotelServiceResultModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, TourLoadingData>?> getLoadingData() async {
    return await tourLoadingRepository
        ?.getLoadingData();
  }
}
