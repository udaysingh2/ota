import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/data_soruces/hotel_detail_interest_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/models/hotel_detail_interest_data_argument.dart';

import '../../../mocks/fixture_reader.dart';

class _MockHotelDetailInterestResponseImpl extends GraphQlResponse {
  Map<String, dynamic> map =
      json.decode(fixture("hotel_detail_interest/hotel_detail_interest.json"));

  @override
  Future<QueryResult> getGraphQlResponse({
    String query = '',
    //This is mandatory for crashlytics
    required String queryName,
    FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
    String? acceptLanguage,
    String? bookingUrn,
    bool authRequired = true,
  }) async {
    map["getHotelsYouMayLike"] = map;
    return QueryResult(
      source: QueryResultSource.optimisticResult,
      data: map,
      options: QueryOptions(
        fetchPolicy: fetchPolicy,
        document: gql(query),
      ),
    );
  }
}

void main() {
  group('For class HotelDetailInterestRemoteDataSource group test then ', () {
    test('For class Hotel Interest Data Source Test', () async {
      HotelDetailInterestRemoteDataSourceImpl.setMock(
          _MockHotelDetailInterestResponseImpl());

      HotelDetailInterestRemoteDataSource mockDataSource =
          HotelDetailInterestRemoteDataSourceImpl();

      mockDataSource.getHotelDetailInterestData(getArgs());
    });

    test('For class Hotel Interest Data Source Test', () async {
      HotelDetailInterestRemoteDataSource mockDataSource =
          HotelDetailInterestRemoteDataSourceImpl(
              graphQlResponse: _MockHotelDetailInterestResponseImpl());

      HotelDetailInterestRemoteDataSourceImpl.setMock(
          _MockHotelDetailInterestResponseImpl());

      mockDataSource.getHotelDetailInterestData(getArgs());
    });
  });
}

HotelDetailInterestDataArgument getArgs() => HotelDetailInterestDataArgument(
      hotelId: 'hotelId',
      lat: 0.0,
      long: 0.0,
      epoch: '1122334455',
      checkInDate: '10/05/2022',
      checkOutDate: '12/05/2022',
      maxHotel: 1,
      roomCapacity: [
        RoomCapacity(
          adult: 2,
          children: 2,
          childAge1: 6,
          childAge2: 10,
        ),
      ],
    );
