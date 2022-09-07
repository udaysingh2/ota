import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/data_sources/recommended_location_mock_data_source.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/data_sources/recommended_location_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/repositories/recommended_location_repo_impl.dart';

import '../../../../modules/hotel/repositories/internet_success_mock.dart';

const String _kServiceTypeHotel = 'HOTEL_LANDING';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GraphQlResponse graphQlResponseMessage = GraphQlResponseMock(
      result: jsonDecode(RecommendedLocationMockDataSourceImpl.getMockData()));
  RecommendedLocationRepository? recommendedLocationRepository;

  RecommendedLocationRemoteDataSourceImpl.setMock(graphQlResponseMessage);
  recommendedLocationRepository = RecommendedLocationRepositoryImpl(
      remoteDataSource: RecommendedLocationRemoteDataSourceImpl());

  /// Code coverage for mock class
  recommendedLocationRepository = RecommendedLocationRepositoryImpl(
      remoteDataSource: RecommendedLocationRemoteDataSourceImpl(),
      internetInfo: InternetSuccessMock());
  test("Test Recommended Location....", () {
    RecommendedLocationRemoteDataSource recommendedLocationRemoteDataSource =
        RecommendedLocationRemoteDataSourceImpl();
    RecommendedLocationRemoteDataSourceImpl.setMock(graphQlResponseMessage);

    recommendedLocationRemoteDataSource
        .getRecommendedLocationData(_kServiceTypeHotel);
  });
  test('Test Recommended Location....', () async {
    final consentResult =
        await recommendedLocationRepository!.getRecommendedLocationData('');

    expect(consentResult.isLeft, false);
  });
}
