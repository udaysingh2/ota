import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_hotel_booking_cancellation.dart';
import 'package:ota/domain/hotel/hotel_booking_cancellation/models/hotel_booking_cancellation_model.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/hotel_booking_cancellation_argument.dart';

abstract class HotelBookingCancellationRemoteDataSource {
  Future<HotelBookingCancellationModelDomain> getHotelBookingCancellationData(
      HotelBookingCancellationArgument argument);
}

class HotelBookingCancellationRemoteDataSourceImpl
    implements HotelBookingCancellationRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  HotelBookingCancellationRemoteDataSourceImpl(
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
  Future<HotelBookingCancellationModelDomain> getHotelBookingCancellationData(
      HotelBookingCancellationArgument argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
      //This is mandatory for crashlytics provide the query name here
      queryName: QueryNames.shared.rejectBooking,
      query:
          QueriesHotelBookingCancellation.getHotelBookingCancellation(argument),
    );
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return HotelBookingCancellationModelDomain.fromMap(
          result.data!["rejectBooking"]);
    }
  }
}
