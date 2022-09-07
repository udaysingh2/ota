import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/payment_method/data_sources/payment_method_remote_data_source.dart';
import 'package:ota/domain/payment_method/repositories/payment_method_repository_impl.dart';

import '../../../mocks/fixture_reader.dart';
import '../../../modules/hotel/repositories/internet_success_mock.dart';

class MockPaymentMethodGraphQl implements GraphQlResponse {
  Map<String, dynamic> map =
      json.decode(fixture('payment_method/payment_method.json'));
  @override
  Future<QueryResult> getGraphQlResponse(
      {String query = '',
      //This is mandatory for crashlytics
      required String queryName,
      FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
      String? acceptLanguage,
      String? bookingUrn,
      bool authRequired = true}) async {
    QueryResult queryResult = QueryResult(
      source: QueryResultSource.optimisticResult,
      data: map,
      options: QueryOptions(
        fetchPolicy: fetchPolicy,
        document: gql(query),
      ),
    );
    return queryResult;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GraphQlResponse graphQlResponseOtaSearch = MockPaymentMethodGraphQl();
  PaymentMethodRepository paymentMethodRepository = PaymentMethodRepositoryImpl(
      remoteDataSource: PaymentMethodRemoteDataSourceImpl(),
      internetInfo: InternetSuccessMock());
  test("Payment method Data Source", () {
    PaymentMethodRemoteDataSource paymentMethodRemoteDataSource =
        PaymentMethodRemoteDataSourceImpl(
            graphQlResponse: graphQlResponseOtaSearch);
    paymentMethodRemoteDataSource.getPaymentMethodListData('');
  });
  test(
      'Payment method Remote Repository '
      'When calling getPaymentMethodListData '
      'With response data', () async {
    /// Consent user cases impl
    final consentResult =
        await paymentMethodRepository.getPaymentMethodListData('');

    printDebug(consentResult);
    expect(consentResult.isLeft, true);
  });
}
