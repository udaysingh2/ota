import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/search/data_sources/search_remote_data_source.dart';
import 'package:ota/domain/search/models/search_service_type.dart';
import 'package:ota/domain/search/models/suggestion_data_argument.dart';
import 'package:ota/domain/search/repositories/search_repository_impl.dart';

import '../../../hotel/repositories/internet_success_mock.dart';
import '../repositories/search_mock_data_source.dart';

void main() {
  GraphQlResponse graphQlResponseRoom = MockSearchDetailGraphQl();
  SearchRepository? searchRepositoryMock;

  searchRepositoryMock = SearchRepositoryImpl();

  /// Code coverage for mock class
  SearchRemoteDataSourceImpl.setMock(graphQlResponseRoom);
  searchRepositoryMock = SearchRepositoryImpl(
      remoteDataSource: SearchRemoteDataSourceImpl(),
      internetInfo: InternetSuccessMock());
  test("Search Remote Data Source", () {
    SearchRemoteDataSource searchRemoteDataSource =
        SearchRemoteDataSourceImpl();
    SearchRemoteDataSourceImpl.setMock(graphQlResponseRoom);
    searchRemoteDataSource.getSearchRecommendationData(SearchServiceType.hotel);
    searchRemoteDataSource.getSearchSuggestionData(
        SuggestionDataArgument.fromHotelSuggestion(
            "searchText", 3, "hotel_key"));
  });
  test(
      'Search analytics Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResultRecommendation = await searchRepositoryMock!
        .getSearchRecommendationData(SearchServiceType.hotel);

    /// Condition check for hotel value null
    expect(consentResultRecommendation.isLeft, false);

    /// Consent user cases impl
    final consentResultSuggestion = await searchRepositoryMock
        .getSearchSuggestionData(SuggestionDataArgument.fromHotelSuggestion(
            "searchText", 3, "hotel_key"));

    /// Condition check for hotel value null
    expect(consentResultSuggestion.isLeft, false);
  });
}
