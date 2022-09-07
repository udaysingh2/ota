import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/landing/banner/models/banner_models.dart';
import 'package:ota/domain/landing/banner/repositories/banner_repository_impl.dart';

/// Interface for HotelDetail use cases.
abstract class LandingBannerUseCases {
  Future<Either<Failure, LandingBannerModelDomain?>?> getLandingBanner(
      String bannerType);
}

class LandingBannerUseCasesImpl implements LandingBannerUseCases {
  LandingBannerRepository? bannerRepository;

  /// Dependence injection via constructor
  LandingBannerUseCasesImpl({LandingBannerRepository? repository}) {
    if (repository == null) {
      bannerRepository = LandingBannerRepositoryImpl();
    } else {
      bannerRepository = repository;
    }
  }

  @override
  Future<Either<Failure, LandingBannerModelDomain?>?> getLandingBanner(
      String bannerType) async {
    return await bannerRepository?.getLandingBanner(bannerType);
  }
}
