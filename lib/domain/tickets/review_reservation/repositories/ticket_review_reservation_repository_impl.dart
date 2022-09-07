import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tickets/review_reservation/data_source/ticket_review_reservation_remote_data_source.dart';
import 'package:ota/domain/tickets/review_reservation/model/ticket_review_reservation_argument_domain.dart';
import 'package:ota/domain/tickets/review_reservation/model/ticket_review_reservation_models.dart';

/// Interface for TicketReviewReservationRepository repository.
abstract class TicketsReviewReservationRepository {
  Future<Either<Failure, TicketReviewReservation>>
      getTicketReviewReservationData(
          TicketReviewReservationArgumentDomain argument);
}

class TicketsReviewReservationRepositoryImpl
    implements TicketsReviewReservationRepository {
  TicketReviewReservationRemoteDataSource? remoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  TicketsReviewReservationRepositoryImpl(
      {TicketReviewReservationRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      this.remoteDataSource = TicketReviewReservationRemoteDataSourceImpl();
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
  Future<Either<Failure, TicketReviewReservation>>
      getTicketReviewReservationData(
          TicketReviewReservationArgumentDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final reservationResult =
            await remoteDataSource?.getTicketReviewReservationData(argument);
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
