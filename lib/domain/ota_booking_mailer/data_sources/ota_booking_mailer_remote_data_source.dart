import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_ota_booking_mailer.dart';
import 'package:ota/domain/ota_booking_mailer/models/ota_booking_mailer_argument_domain.dart';
import 'package:ota/domain/ota_booking_mailer/models/ota_booking_mailer_model_domain.dart';

/// Interface for Ota detail Data remote data source.
abstract class OtaBookingMailerRemoteDataSource {
  Future<OtaBookingMailerModelDomain> sendOtaBookingMailer(
      OtaBookingMailerArgumentDomain argument);
}

class OtaBookingMailerRemoteDataSourceImpl
    implements OtaBookingMailerRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  OtaBookingMailerRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }
  @override
  Future<OtaBookingMailerModelDomain> sendOtaBookingMailer(
      OtaBookingMailerArgumentDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.sendOtaBookingMailer,
        bookingUrn: argument.bookingUrn,
        query: QueriesOtaBookingMailer.sendBookingMailer(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return OtaBookingMailerModelDomain.fromMap(result.data!);
    }
  }
}
