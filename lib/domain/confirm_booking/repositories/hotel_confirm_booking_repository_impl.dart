import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/confirm_booking/data_sources/hotel_confirm_booking_remote_data_source.dart';
import 'package:ota/domain/confirm_booking/models/argument_data_model.dart';
import 'package:ota/domain/confirm_booking/models/booking_confirmation_data_model.dart';

/// Interface for HotelConfirmBookingRepository repository.
abstract class HotelConfirmBookingRepository {
  Future<Either<Failure, BookingConfirmationData>> getHotelConfirmBooking(
      HotelConfirmBookingArgumentModelDomain argument);
}

class HotelConfirmBookingRepositoryImpl
    implements HotelConfirmBookingRepository {
  HotelConfirmBookingRemoteDataSource? hotelConfirmBookingRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  HotelConfirmBookingRepositoryImpl(
      {HotelConfirmBookingRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      hotelConfirmBookingRemoteDataSource =
          HotelConfirmBookingRemoteDataSourceImpl();
    } else {
      hotelConfirmBookingRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, BookingConfirmationData>> getHotelConfirmBooking(
      HotelConfirmBookingArgumentModelDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final result = await hotelConfirmBookingRemoteDataSource
            ?.getHotelConfirmBooking(argument);
        return Right(result!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
