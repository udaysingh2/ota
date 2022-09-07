import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/landing/data_sources/landing_page_remote_data_source.dart';
import 'package:ota/domain/landing/models/landing_models.dart';

/// Interface for HotelDetailRepository repository.
abstract class LandingPageRepository {
  Future<Either<Failure, LandingData?>> getLandingPage();
}

class LandingPageRepositoryImpl implements LandingPageRepository {
  LandingPageRemoteDataSource? roomDetailRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  LandingPageRepositoryImpl(
      {LandingPageRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      roomDetailRemoteDataSource = LandingPageRemoteDataSourceImpl();
      //roomDetailRemoteDataSource = LandingPageMockDataSourceImpl();
    } else {
      roomDetailRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, LandingData?>> getLandingPage() async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final roomResult = await roomDetailRemoteDataSource?.getLandingPage();
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
