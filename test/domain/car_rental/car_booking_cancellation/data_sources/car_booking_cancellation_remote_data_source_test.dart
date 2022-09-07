import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/car_rental/car_booking_cancellation/data_source/car_booking_cancellation_remote_data_source.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/view_model/car_booking_cancellation_argument.dart';

import '../../../../mocks/fixture_reader.dart';

class _MockedGraphQlResponseImpl extends GraphQlResponse {
  ///Users/deekosur/scb-ota-app/test/mocks/car_booking_cancellation
  Map<String, dynamic> map = json.decode(
      fixture("car_booking_cancellation/car_booking_cancellation.json"));

  @override
  Future<QueryResult> getGraphQlResponse(
      {String query = '',
      FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
      String? acceptLanguage,
      String? bookingUrn,
      bool authRequired = true,
      required String queryName}) async {
    map["getCarRejectBookingResponse"] = map;
    return QueryResult(
      source: QueryResultSource.optimisticResult,
      data: map,
      options: QueryOptions(
        fetchPolicy: fetchPolicy,
        document: gql(query),
      ),
      // parserFn: (Map<String, dynamic> data) {
      //   return data;
      // },
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  CarBookingCancellationArgument argument =
      CarBookingCancellationArgument(confirmNo: '', reason: 'Testing file');

  group("Car booking cancellation remote data source group", () {
    test('Car booking cancellation remote data source', () async {
      CarBookingCancellationRemoteDataSource
          carBookingCancellationRemoteDataSource =
          CarBookingCancellationRemoteDataSourceImpl();
      carBookingCancellationRemoteDataSource =
          CarBookingCancellationRemoteDataSourceImpl(
              graphQlResponse: _MockedGraphQlResponseImpl());
      carBookingCancellationRemoteDataSource
          .getCarBookingCancellationData(argument);
    });
  });
}
