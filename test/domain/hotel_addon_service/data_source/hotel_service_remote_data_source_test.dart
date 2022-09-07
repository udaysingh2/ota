import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/hotel/hotel_addon_service/data_sources/hotel_service_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_data_argument.dart';

import '../../../mocks/fixture_reader.dart';

class MockHotelServiceGraphQl implements GraphQlResponse {
  Map<String, dynamic> map =
      json.decode(fixture("hotel/hotel_addon_service/hotel_service_mock.json"));
  @override
  Future<QueryResult> getGraphQlResponse(
      {String query = '',
      FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
      String? acceptLanguage,
      required String queryName,
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
  HotelServiceDataArgument argument = HotelServiceDataArgument(
      checkInDate: "",
      checkOutDate: "",
      currency: "",
      hotelId: "",
      limit: 8,
      offset: 0);

  group("Hotel Service remote data source group", () {
    test('Hotel Addon Service test', () async {
      HotelServiceRemoteDataSource preferenceQuestionsRemoteDataSource =
          HotelServiceRemoteDataSourceImpl();
      preferenceQuestionsRemoteDataSource = HotelServiceRemoteDataSourceImpl(
          graphQlResponse: MockHotelServiceGraphQl());
      HotelServiceRemoteDataSourceImpl.setMock(MockHotelServiceGraphQl());
      preferenceQuestionsRemoteDataSource.getHotelAddonServiceData(argument);
    });
  });
}
