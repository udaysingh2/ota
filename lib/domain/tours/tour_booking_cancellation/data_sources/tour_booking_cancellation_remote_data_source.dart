import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_tour_booking_cancellation.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/models/tours_booking_cancellation_argument_model.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/models/tours_booking_cancellation_model_domain.dart';

/// Interface for Hotel detail Data remote data source.
abstract class TourBookingCancellationRemoteDataSource {
  Future<TourBookingDetailCancellationDomain> getTourCancellationDetail(
      TourBookingCancellationArgumentDomain argument);
}

class TourBookingCancellationRemoteDataSourceImpl
    implements TourBookingCancellationRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  TourBookingCancellationRemoteDataSourceImpl(
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
  Future<TourBookingDetailCancellationDomain> getTourCancellationDetail(
      TourBookingCancellationArgumentDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getTourCancellationDetail,
        query: QueriesTourBookingCancellation.getTourBookingCancellationData(
            argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return TourBookingDetailCancellationDomain.fromMap(result.data!);
    }
  }
}
