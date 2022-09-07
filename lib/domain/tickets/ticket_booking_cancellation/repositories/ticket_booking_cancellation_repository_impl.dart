import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/data_sources/ticket_booking_cancellation_remote_data_source.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_argument_model.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_model_domain.dart';

///Interface for TicketBookingDetailRepository repository
abstract class TicketBookingCancellationRepository {
  Future<Either<Failure, TicketBookingDetailCancellationDomain>>
      getTicketCancellationDetail(
          TicketBookingCancellationArgumentDomain argument);
}

class TicketBookingCancellationRepositoryImpl
    implements TicketBookingCancellationRepository {
  TicketBookingCancellationRemoteDataSource?
      ticketBookingCancellationRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  TicketBookingCancellationRepositoryImpl(
      {TicketBookingCancellationRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      ticketBookingCancellationRemoteDataSource =
          TicketBookingCancellationRemoteDataSourceImpl();
      // ticketBookingDetailRemoteDataSource = TicketBookingDetailMockDataSourceImpl();
    } else {
      ticketBookingCancellationRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, TicketBookingDetailCancellationDomain>>
      getTicketCancellationDetail(
          TicketBookingCancellationArgumentDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final ticketResult = await ticketBookingCancellationRemoteDataSource
            ?.getTicketCancellationDetail(argument);
        return Right(ticketResult!);
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
