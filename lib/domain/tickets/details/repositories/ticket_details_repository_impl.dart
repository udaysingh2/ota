import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tickets/details/data_source/ticket_details_remote_data_source.dart';
import 'package:ota/domain/tickets/details/models/ticket_detail_argument_domain.dart';
import 'package:ota/domain/tickets/details/models/ticket_details_model.dart';
import 'package:ota/domain/tickets/details/models/ticket_package_details_argument_domain.dart';

abstract class TicketDetailsRepository {
  Future<Either<Failure, TicketDetail>> getTicketDetails(
      TicketDetailArgumentDomain argument);

  Future<Either<Failure, TicketDetail>> getTicketPackageDetails(
      TicketPackageDetailsArgumentDomain argument);
}

class TicketDetailsRepositoryImpl extends TicketDetailsRepository {
  TicketDetailsRemoteDataSource? ticketDetailsRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  TicketDetailsRepositoryImpl(
      {TicketDetailsRemoteDataSource? remoteDtaSource,
      InternetConnectionInfo? internetConnection}) {
    if (remoteDtaSource == null) {
      ticketDetailsRemoteDataSource = TicketDetailsRemoteSourceDataImpl();
    } else {
      ticketDetailsRemoteDataSource = remoteDtaSource;
    }

    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetConnection == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetConnection;
    }
  }

  @override
  Future<Either<Failure, TicketDetail>> getTicketDetails(
      TicketDetailArgumentDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final result =
            await ticketDetailsRemoteDataSource?.getTicketDetails(argument);
        return Right(result!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, TicketDetail>> getTicketPackageDetails(
      TicketPackageDetailsArgumentDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final result = await ticketDetailsRemoteDataSource
            ?.getTicketPackageDetails(argument);
        return Right(result!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
