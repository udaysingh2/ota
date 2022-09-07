import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_ticket_review_reservation.dart';
import 'package:ota/domain/tickets/review_reservation/model/ticket_review_reservation_argument_domain.dart';
import 'package:ota/domain/tickets/review_reservation/model/ticket_review_reservation_models.dart';

/// Interface for Interesting attraction Data remote data source.
abstract class TicketReviewReservationRemoteDataSource {
  Future<TicketReviewReservation> getTicketReviewReservationData(
      TicketReviewReservationArgumentDomain argument);
}

class TicketReviewReservationRemoteDataSourceImpl
    implements TicketReviewReservationRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  TicketReviewReservationRemoteDataSourceImpl(
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
  Future<TicketReviewReservation> getTicketReviewReservationData(
      TicketReviewReservationArgumentDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getTicketReviewReservationData,
        query:
            QueriesTicketReviewReservationData.getTicketReviewReservationData(
                argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return TicketReviewReservation.fromMap(result.data!);
    }
  }
}
