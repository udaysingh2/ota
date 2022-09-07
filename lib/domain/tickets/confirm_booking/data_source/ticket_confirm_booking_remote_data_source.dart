import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_ticket_confirm_booking.dart';
import 'package:ota/domain/tickets/confirm_booking/models/ticket_confirm_booking_model_domain.dart';
import 'package:ota/domain/tours/confirm_booking/models/confirm_booking_argument_domain.dart';

/// Interface for Interesting attraction Data remote data source.
abstract class TicketConfirmBookingRemoteDataSource {
  Future<TicketConfirmBookingModelDomain> getTicketConfirmBookingData(
      ConfirmBookingArgumentDomain argument);
}

class TicketConfirmBookingRemoteDataSourceImpl
    implements TicketConfirmBookingRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  TicketConfirmBookingRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<TicketConfirmBookingModelDomain> getTicketConfirmBookingData(
      ConfirmBookingArgumentDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getTicketConfirmBookingData,
        query: QueriesTicketConfirmBookingData.getTicketConfirmBookingData(
            argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return TicketConfirmBookingModelDomain.fromMap(result.data!);
    }
  }
}
