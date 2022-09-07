import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/models/hotel_landing_dynamic_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/repositories/hotel_landing_dynamic_repository_impl.dart';

/// Interface for HotelDetail use cases.
abstract class HotelLandingDynamicUseCase {
  Future<Either<Failure, HotelLandingDynamicSingleData?>?> getPlaylist(
      HotelLandingDynamicSingleDataArgument argument);
}

class HotelLandingDynamicUseCasesImpl implements HotelLandingDynamicUseCase {
  HotelLandingDynamicRepository? repositoryAbs;

  /// Dependence injection via constructor
  HotelLandingDynamicUseCasesImpl({HotelLandingDynamicRepository? repository}) {
    if (repository == null) {
      repositoryAbs = HotelLandingDynamicRepositoryImpl();
    } else {
      repositoryAbs = repository;
    }
  }

  @override
  Future<Either<Failure, HotelLandingDynamicSingleData?>?> getPlaylist(
      HotelLandingDynamicSingleDataArgument argument) async {
    return await repositoryAbs?.getPlaylist(argument);
  }
}
