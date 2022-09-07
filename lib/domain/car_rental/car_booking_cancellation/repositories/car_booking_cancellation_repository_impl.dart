import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/car_rental/car_booking_cancellation/data_source/car_booking_cancellation_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_booking_cancellation/models/car_booking_cancellation_model.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/view_model/car_booking_cancellation_argument.dart';

abstract class CarBookingCancellationRepository {
  Future<Either<Failure, CarBookingCancellationModelDomain>>
      getCarBookingCancellationData(CarBookingCancellationArgument argument);
}

class CarBookingCancellationRepositoryImpl
    implements CarBookingCancellationRepository {
  CarBookingCancellationRemoteDataSource?
      carBookingCancellationRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  CarBookingCancellationRepositoryImpl(
      {CarBookingCancellationRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      carBookingCancellationRemoteDataSource =
          CarBookingCancellationRemoteDataSourceImpl();
      // carBookingCancellationRemoteDataSource =
      //     CarBookingCancellationMockDataSourceImpl();
    } else {
      carBookingCancellationRemoteDataSource = remoteDataSource;
    }
    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo != null) {
      internetConnectionInfo = internetInfo;
    } else {
      internetConnectionInfo = InternetConnectionInfoImpl();
    }
  }

  @override
  Future<Either<Failure, CarBookingCancellationModelDomain>>
      getCarBookingCancellationData(
          CarBookingCancellationArgument argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final carBookingCancellationResult =
            await carBookingCancellationRemoteDataSource
                ?.getCarBookingCancellationData(argument);
        return Right(carBookingCancellationResult!);
      } on ServerException catch (error) {
        return Left(
          ServerFailure(exception: error.exception),
        );
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
