import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';

import '../data_source/car_reservation_remote_data_source.dart';
import '../models/car_reservation_argument_model.dart';
import '../models/car_reservation_domain_model.dart';

abstract class CarReservationRepository {
  Future<Either<Failure, CarReservationScreenDomainData>> getCarReservationData(
      CarReservationDomainArgumentModel argument);
}

/// CarReservationRepositoryImpl will contain the CarReservationRepository implementation.
class CarReservationRepositoryImpl implements CarReservationRepository {
  CarReservationRemoteDataSource? carReservationRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  CarReservationRepositoryImpl(
      {CarReservationRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (carReservationRemoteDataSource != null) {
      carReservationRemoteDataSource = _carReservationRemoteDataSource;
    } else if (remoteDataSource == null) {
      carReservationRemoteDataSource = CarReservationRemoteDataSourceImpl();
    } else {
      carReservationRemoteDataSource = remoteDataSource;
    }

    if (_internetConnectionInfo != null) {
      internetConnectionInfo = _internetConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  @override
  Future<Either<Failure, CarReservationScreenDomainData>> getCarReservationData(
      CarReservationDomainArgumentModel argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final carReservationResult = await carReservationRemoteDataSource
            ?.getCarReservationData(argument);

        return Right(carReservationResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      return Left(InternetFailure());
    }
  }
}

CarReservationRemoteDataSource? _carReservationRemoteDataSource;
InternetConnectionInfo? _internetConnectionInfo;
void mockDynamicPlaylistPageData(
    {CarReservationRemoteDataSource? remoteDataSource,
    InternetConnectionInfo? internetInfo}) {
  _carReservationRemoteDataSource = remoteDataSource;
  _internetConnectionInfo = internetInfo;
}
