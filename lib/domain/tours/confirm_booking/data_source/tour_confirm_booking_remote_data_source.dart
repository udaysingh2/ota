import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_tour_confirm_booking.dart';
import 'package:ota/domain/tours/confirm_booking/models/confirm_booking_argument_domain.dart';
import 'package:ota/domain/tours/confirm_booking/models/tour_confirm_booking_model_domain.dart';

/// Interface for Interesting attraction Data remote data source.
abstract class TourConfirmBookingRemoteDataSource {
  Future<TourConfirmBookingModelDomain> getTourConfirmBookingData(
      ConfirmBookingArgumentDomain argument);
}

class TourConfirmBookingRemoteDataSourceImpl
    implements TourConfirmBookingRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  TourConfirmBookingRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<TourConfirmBookingModelDomain> getTourConfirmBookingData(
      ConfirmBookingArgumentDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getTourConfirmBookingData,
        query:
            QueriesTourConfirmBookingData.getTourConfirmBookingData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return TourConfirmBookingModelDomain.fromMap(result.data!);
    }
  }
}
