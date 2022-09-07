import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/hotel/hotel_booking_cancellation/data_source/hotel_booking_cancellation_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_booking_cancellation/models/hotel_booking_cancellation_model.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/hotel_booking_cancellation_argument.dart';

abstract class HotelBookingCancellationRepository {
  Future<Either<Failure, HotelBookingCancellationModelDomain>>
      getHotelBookingCancellationData(
          HotelBookingCancellationArgument argument);
}

class HotelBookingCancellationRepositoryImpl
    implements HotelBookingCancellationRepository {
  HotelBookingCancellationRemoteDataSource?
      hotelBookingCancellationRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  HotelBookingCancellationRepositoryImpl(
      {HotelBookingCancellationRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      hotelBookingCancellationRemoteDataSource =
          HotelBookingCancellationRemoteDataSourceImpl();
    } else {
      hotelBookingCancellationRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, HotelBookingCancellationModelDomain>>
      getHotelBookingCancellationData(
          HotelBookingCancellationArgument argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final hotelBookingCancellationResult =
            await hotelBookingCancellationRemoteDataSource
                ?.getHotelBookingCancellationData(argument);
        return Right(hotelBookingCancellationResult!);
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
