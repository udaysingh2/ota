import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_confirm_booking.dart';
import 'package:ota/domain/confirm_booking/models/argument_data_model.dart';
import 'package:ota/domain/confirm_booking/models/booking_confirmation_data_model.dart';

/// Interface for Hotel detail Data remote data source.
abstract class HotelConfirmBookingRemoteDataSource {
  Future<BookingConfirmationData> getHotelConfirmBooking(
      HotelConfirmBookingArgumentModelDomain argument);
}

class HotelConfirmBookingRemoteDataSourceImpl
    implements HotelConfirmBookingRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  HotelConfirmBookingRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }
  @override
  Future<BookingConfirmationData> getHotelConfirmBooking(
      HotelConfirmBookingArgumentModelDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.bookingConfirmation,
        query: QueriesConfirmBooking.getHotelConfirmBookingData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return BookingConfirmationData.fromMap(
          result.data!["BookingConfirmation"]);
    }
  }
}
