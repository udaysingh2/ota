import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_car_booking_mailer.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/models/car_booking_mailer_argument_domain.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/models/car_booking_mailer_model_domain.dart';

/// Interface for Car detail Data remote data source.
abstract class CarBookingMailerRemoteDataSource {
  Future<CarBookingMailerModelDomain> sendCarBookingMailer(
      CarBookingMailerArgumentDomain argument);
}

class CarBookingMailerRemoteDataSourceImpl
    implements CarBookingMailerRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  CarBookingMailerRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }
  @override
  Future<CarBookingMailerModelDomain> sendCarBookingMailer(
      CarBookingMailerArgumentDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        bookingUrn: argument.bookingUrn,
        query: QueriesCarBookingMailer.sendCarBookingMailer(argument),
        queryName: QueryNames.shared.sendCarBookingMailer);
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return CarBookingMailerModelDomain.fromMap(result.data!);
    }
  }
}
