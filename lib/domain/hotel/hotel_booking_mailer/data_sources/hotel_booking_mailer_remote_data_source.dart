import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_hotel_booking_mailer.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/models/hotel_booking_mailer_argument_domain.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/models/hotel_booking_mailer_model_domain.dart';

/// Interface for Hotel detail Data remote data source.
abstract class HotelBookingMailerRemoteDataSource {
  Future<HotelBookingMailerModelDomain> sendHotelBookingMailer(
      HotelBookingMailerArgumentDomain argument);
}

class HotelBookingMailerRemoteDataSourceImpl
    implements HotelBookingMailerRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  HotelBookingMailerRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }
  @override
  Future<HotelBookingMailerModelDomain> sendHotelBookingMailer(
      HotelBookingMailerArgumentDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.sendEmailConfirmation,
        bookingUrn: argument.bookingUrn,
        query: QueriesHotelBookingMailer.sendtHotelBookingMailer(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return HotelBookingMailerModelDomain.fromMap(result.data!);
    }
  }
}
