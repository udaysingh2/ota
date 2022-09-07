import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_ticket_booking_cancellation.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_argument_model.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_model_domain.dart';

/// Interface for Hotel detail Data remote data source.
abstract class TicketBookingCancellationRemoteDataSource {
  Future<TicketBookingDetailCancellationDomain> getTicketCancellationDetail(
      TicketBookingCancellationArgumentDomain argument);
}

class TicketBookingCancellationRemoteDataSourceImpl
    implements TicketBookingCancellationRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  TicketBookingCancellationRemoteDataSourceImpl(
      {GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }
  @override
  Future<TicketBookingDetailCancellationDomain> getTicketCancellationDetail(
      TicketBookingCancellationArgumentDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getTicketCancellationDetail,
        query:
            QueriesTicketBookingCancellation.getTicketBookingCancellationData(
                argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return TicketBookingDetailCancellationDomain.fromMap(result.data!);
    }
  }
}
