import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_ticket_booking_detail.dart';
import 'package:ota/domain/tickets/ticket_booking_details/models/ticket_booking_details_argument_model.dart';
import 'package:ota/domain/tickets/ticket_booking_details/models/ticket_booking_details_model_domain.dart';

/// Interface for Hotel detail Data remote data source.
abstract class TicketBookingDetailRemoteDataSource {
  Future<TicketBookingDetailModelDomain> getTicketBookingDetail(
      TicketBookingDetailArgumentDomain argument);
}

class TicketBookingDetailRemoteDataSourceImpl
    implements TicketBookingDetailRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  TicketBookingDetailRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }
  @override
  Future<TicketBookingDetailModelDomain> getTicketBookingDetail(
      TicketBookingDetailArgumentDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getTicketBookingDetail,
        query: QueriesTicketBookingDetail.getTicketBookingDetailData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return TicketBookingDetailModelDomain.fromMap(result.data!);
    }
  }
}
