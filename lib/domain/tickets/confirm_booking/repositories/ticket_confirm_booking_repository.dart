import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tickets/confirm_booking/data_source/ticket_confirm_booking_remote_data_source.dart';
import 'package:ota/domain/tickets/confirm_booking/models/ticket_confirm_booking_model_domain.dart';
import 'package:ota/domain/tours/confirm_booking/models/confirm_booking_argument_domain.dart';

/// Interface for Ticket Confirm Booking repository.
abstract class TicketConfirmBookingRepository {
  Future<Either<Failure, TicketConfirmBookingModelDomain>>
      getTicketConfirmBookingData(ConfirmBookingArgumentDomain argument);
}

class TicketConfirmBookingRepositoryImpl
    implements TicketConfirmBookingRepository {
  TicketConfirmBookingRemoteDataSource? remoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  TicketConfirmBookingRepositoryImpl(
      {TicketConfirmBookingRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      this.remoteDataSource = TicketConfirmBookingRemoteDataSourceImpl();
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
  Future<Either<Failure, TicketConfirmBookingModelDomain>>
      getTicketConfirmBookingData(ConfirmBookingArgumentDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final reservationResult =
            await remoteDataSource?.getTicketConfirmBookingData(argument);
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
