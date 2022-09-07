import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/data_sources/tour_booking_cancellation_remote_data_source.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/models/tours_booking_cancellation_argument_model.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/models/tours_booking_cancellation_model_domain.dart';

///Interface for TourBookingDetailRepository repository
abstract class TourBookingCancellationRepository {
  Future<Either<Failure, TourBookingDetailCancellationDomain>>
      getTourCancellationDetail(TourBookingCancellationArgumentDomain argument);
}

class TourBookingCancellationRepositoryImpl
    implements TourBookingCancellationRepository {
  TourBookingCancellationRemoteDataSource?
      tourBookingCancellationRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  TourBookingCancellationRepositoryImpl(
      {TourBookingCancellationRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      tourBookingCancellationRemoteDataSource =
          TourBookingCancellationRemoteDataSourceImpl();
      // tourBookingDetailRemoteDataSource = TourBookingDetailMockDataSourceImpl();
    } else {
      tourBookingCancellationRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, TourBookingDetailCancellationDomain>>
      getTourCancellationDetail(
          TourBookingCancellationArgumentDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final tourResult = await tourBookingCancellationRemoteDataSource
            ?.getTourCancellationDetail(argument);
        return Right(tourResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      await Future.delayed(const Duration(seconds: 1));
      return Left(InternetFailure());
    }
  }
}
