import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tours/landing/data_sources/tour_attractions_remote_data_source.dart';
import 'package:ota/domain/tours/landing/models/tour_attractions_model_domain.dart';

abstract class TourAttractionsRepository {
  Future<Either<Failure, TourAttractionsModelDomain>?> getTourAttractionsData(
      String serviceType);
}

class TourAttractionsRepositoryImpl implements TourAttractionsRepository {
  TourAttractionsRemoteDataSource? remoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  TourAttractionsRepositoryImpl(
      {TourAttractionsRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      this.remoteDataSource = TourAttractionsRemoteDataSourceImpl();
    } else {
      this.remoteDataSource = remoteDataSource;
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
  Future<Either<Failure, TourAttractionsModelDomain>?> getTourAttractionsData(
      String serviceType) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final results =
            await remoteDataSource?.getTourAttractionsData(serviceType);
        return Right(results!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
