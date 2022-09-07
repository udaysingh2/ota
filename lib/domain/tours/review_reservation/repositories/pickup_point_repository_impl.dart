import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tours/review_reservation/data_sources/pickup_point_remote_data_source.dart';
import 'package:ota/domain/tours/review_reservation/models/pickup_point_model_domain.dart';

/// Interface for PickUpPoint repository.
abstract class PickUpPointRepository {
  Future<Either<Failure, PickUpPointDomain>> getPickUpPointDetail(
      String zoneId);
}

class PickUpPointRepositoryImpl implements PickUpPointRepository {
  PickUpPointRemoteDataSource? remoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  PickUpPointRepositoryImpl(
      {PickUpPointRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      this.remoteDataSource = PickUpPointRemoteDataSourceImpl();
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
  Future<Either<Failure, PickUpPointDomain>> getPickUpPointDetail(
      String zoneId) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final reservationResult =
            await remoteDataSource?.getPickUpPointDetail(zoneId);
        return Right(reservationResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
