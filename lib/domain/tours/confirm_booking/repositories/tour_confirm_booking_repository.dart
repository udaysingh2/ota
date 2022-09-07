import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tours/confirm_booking/data_source/tour_confirm_booking_remote_data_source.dart';
import 'package:ota/domain/tours/confirm_booking/models/confirm_booking_argument_domain.dart';
import 'package:ota/domain/tours/confirm_booking/models/tour_confirm_booking_model_domain.dart';

/// Interface for Tours Confirm Booking repository.
abstract class ToursConfirmBookingRepository {
  Future<Either<Failure, TourConfirmBookingModelDomain>>
      getTourConfirmBookingData(ConfirmBookingArgumentDomain argument);
}

class ToursConfirmBookingRepositoryImpl
    implements ToursConfirmBookingRepository {
  TourConfirmBookingRemoteDataSource? remoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  ToursConfirmBookingRepositoryImpl(
      {TourConfirmBookingRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      this.remoteDataSource = TourConfirmBookingRemoteDataSourceImpl();
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
  Future<Either<Failure, TourConfirmBookingModelDomain>>
      getTourConfirmBookingData(ConfirmBookingArgumentDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final reservationResult =
            await remoteDataSource?.getTourConfirmBookingData(argument);
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
