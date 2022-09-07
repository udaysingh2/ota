import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_payment_status.dart';
import 'package:ota/domain/payment_status/models/payment_initiate_argument_domain.dart';
import 'package:ota/domain/payment_status/models/payment_initiate_new_model.dart';
import 'package:ota/domain/payment_status/models/payment_new_booking_urn_model_domain.dart';
import 'package:ota/domain/payment_status/models/payment_status_model.dart';

/// Interface for Room detail Data remote data source.
/// Change the argument model
abstract class PaymentStatusRemoteDataSource {
  Future<PaymentStatusModelDomain> getPaymentStatus(String bookingUrn);
  Future<PaymentInitiateNewModelDomain> getPaymentInitiateV2(
      PaymentInitiateArgumentModelDomain argument);
  Future<PaymentNewBookingUrnModelDomain> getNewBookingUrn(String bookingUrn);
  Future<PaymentNewCarBookingUrnModelDomain> getNewCarBookingUrn(
      String bookingUrn);
}

class PaymentStatusRemoteDataSourceImpl
    implements PaymentStatusRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  PaymentStatusRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }
  @override
  Future<PaymentNewBookingUrnModelDomain> getNewBookingUrn(
      String bookingUrn) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.generateNewBookingUrn,
        query: QueriesPaymentStatus.getNewBookingUrn(bookingUrn));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return PaymentNewBookingUrnModelDomain.fromMap(result.data!);
    }
  }

  @override
  Future<PaymentNewCarBookingUrnModelDomain> getNewCarBookingUrn(
      String bookingUrn) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.generateNewBookingUrn,
        query: QueriesPaymentStatus.getCarNewBookingUrn(bookingUrn));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return PaymentNewCarBookingUrnModelDomain.fromMap(result.data!);
    }
  }

  @override
  Future<PaymentStatusModelDomain> getPaymentStatus(String bookingUrn) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.paymentStatus,
        query: QueriesPaymentStatus.getPaymentStatus(bookingUrn));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return PaymentStatusModelDomain.fromMap(result.data!);
    }
  }

  @override
  Future<PaymentInitiateNewModelDomain> getPaymentInitiateV2(
      PaymentInitiateArgumentModelDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.initiatePaymentV2,
        query: QueriesPaymentStatus.getPaymentInitiateV2(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return PaymentInitiateNewModelDomain.fromMap(result.data!);
    }
  }
}
