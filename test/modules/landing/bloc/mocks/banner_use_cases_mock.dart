import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/landing/banner/models/banner_models.dart';
import 'package:ota/domain/landing/banner/usecases/banner_usecases.dart';

class LandingBannerUseCasesSuccessMock extends LandingBannerUseCasesImpl {
  @override
  Future<Either<Failure, LandingBannerModelDomain?>?> getLandingBanner(
      String bannerType) async {
    return Right(
      LandingBannerModelDomain(
        getBanners: GetBanners(
          data: GetBannersData(
            banner: [
              Banner(),
            ],
          ),
        ),
      ),
    );
  }
}

class LandingBannerUseCasesBannerEmptyMock extends LandingBannerUseCasesImpl {
  @override
  Future<Either<Failure, LandingBannerModelDomain?>?> getLandingBanner(
      String bannerType) async {
    return Right(
      LandingBannerModelDomain(
        getBanners: GetBanners(
          data: GetBannersData(
            banner: [],
          ),
        ),
      ),
    );
  }
}
