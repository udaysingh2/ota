import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/landing/banner/data_sources/banner_remote_data_source.dart';
import 'package:ota/domain/landing/banner/repositories/banner_repository_impl.dart';

import '../../../mocks/fixture_reader.dart';
import '../../../modules/hotel/repositories/internet_success_mock.dart';

class MockBannerGraphQl implements GraphQlResponse {
  Map<String, dynamic> map = json.decode(fixture('banner/banner.json'));
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
  GraphQlResponse graphQlResponsePlayList = MockBannerGraphQl();
  LandingBannerRemoteDataSourceImpl.setMock(graphQlResponsePlayList);
  LandingBannerRepository landingBannerRepository = LandingBannerRepositoryImpl(
      remoteDataSource: LandingBannerRemoteDataSourceImpl(),
      internetInfo: InternetSuccessMock());

  test("hotel landing dynamic Data Source", () {
    LandingBannerRemoteDataSource landingBannerRemoteDataSource =
        LandingBannerRemoteDataSourceImpl();
    LandingBannerRemoteDataSourceImpl.setMock(graphQlResponsePlayList);
    landingBannerRemoteDataSource.getLandingBanner("bannerType");
  });
  test(
      'service card Repository '
      'When calling service card '
      'With response data', () async {
    /// Consent user cases impl
    final consentResult =
        await landingBannerRepository.getLandingBanner("bannerType");

    expect(consentResult.isRight, true);
  });
}
