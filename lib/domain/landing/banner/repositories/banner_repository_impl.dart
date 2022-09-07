import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/landing/banner/data_sources/banner_remote_data_source.dart';
import 'package:ota/domain/landing/banner/models/banner_models.dart';

/// Interface for HotelDetailRepository repository.
abstract class LandingBannerRepository {
  Future<Either<Failure, LandingBannerModelDomain?>> getLandingBanner(
      String bannerType);
}

class LandingBannerRepositoryImpl implements LandingBannerRepository {
  LandingBannerRemoteDataSource? bannerRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  LandingBannerRepositoryImpl(
      {LandingBannerRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      bannerRemoteDataSource = LandingBannerRemoteDataSourceImpl();
      //bannerRemoteDataSource = LandingBannerMockDataSourceImpl();
    } else {
      bannerRemoteDataSource = remoteDataSource;
    }

    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  @override
  Future<Either<Failure, LandingBannerModelDomain?>> getLandingBanner(
      String bannerType) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final roomResult =
            await bannerRemoteDataSource?.getLandingBanner(bannerType);
        return Right(roomResult);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
