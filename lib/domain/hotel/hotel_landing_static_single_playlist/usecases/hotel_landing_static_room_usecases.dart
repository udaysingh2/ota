import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/models/hotel_landing_static_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/repositories/hotel_landing_static_repository_impl.dart';

/// Interface for HotelDetail use cases.
abstract class HotelLandingStaticUseCase {
  Future<Either<Failure, HotelLandingStaticSingleData?>?> getPlaylist(
      HotelLandingStaticSingleDataArgument argument);
}

class HotelLandingStaticUseCasesImpl implements HotelLandingStaticUseCase {
  HotelLandingStaticRepository? repositoryAbs;

  /// Dependence injection via constructor
  HotelLandingStaticUseCasesImpl({HotelLandingStaticRepository? repository}) {
    if (repository == null) {
      repositoryAbs = HotelLandingStaticRepositoryImpl();
    } else {
      repositoryAbs = repository;
    }
  }

  @override
  Future<Either<Failure, HotelLandingStaticSingleData?>?> getPlaylist(
      HotelLandingStaticSingleDataArgument argument) async {
    return await repositoryAbs?.getPlaylist(argument);
  }
}
