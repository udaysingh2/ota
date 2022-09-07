import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_tour_review_reservation.dart';
import 'package:ota/domain/tours/review_reservation/models/tours_review_reservation_argument_domain.dart';
import 'package:ota/domain/tours/review_reservation/models/tours_review_reservation_models.dart';

/// Interface for Interesting attraction Data remote data source.
abstract class TourReviewReservationRemoteDataSource {
  Future<TourReviewReservation> getTourReviewReservationData(
      TourReviewReservationArgumentDomain argument);
}

class TourReviewReservationRemoteDataSourceImpl
    implements TourReviewReservationRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  TourReviewReservationRemoteDataSourceImpl(
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
  Future<TourReviewReservation> getTourReviewReservationData(
      TourReviewReservationArgumentDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getTourReviewReservationData,
        query: QueriesTourReviewReservationData.getTourReviewReservationData(
            argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return TourReviewReservation.fromMap(result.data!);
    }
  }
}
