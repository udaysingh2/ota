import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tickets/ticket_booking_details/data_sources/ticket_booking_details_remote_data_source.dart';
import 'package:ota/domain/tickets/ticket_booking_details/models/ticket_booking_details_argument_model.dart';
import 'package:ota/domain/tickets/ticket_booking_details/models/ticket_booking_details_model_domain.dart';

///Interface for TourBookingDetailRepository repository
abstract class TicketBookingDetailRepository {
  Future<Either<Failure, TicketBookingDetailModelDomain>>
      getTicketBookingDetail(TicketBookingDetailArgumentDomain argument);
}

class TicketBookingDetailRepositoryImpl
    implements TicketBookingDetailRepository {
  TicketBookingDetailRemoteDataSource? ticketBookingDetailRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  TicketBookingDetailRepositoryImpl(
      {TicketBookingDetailRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      ticketBookingDetailRemoteDataSource =
          TicketBookingDetailRemoteDataSourceImpl();
    } else {
      ticketBookingDetailRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, TicketBookingDetailModelDomain>>
      getTicketBookingDetail(TicketBookingDetailArgumentDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final tourResult = await ticketBookingDetailRemoteDataSource
            ?.getTicketBookingDetail(argument);
        return Right(tourResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
