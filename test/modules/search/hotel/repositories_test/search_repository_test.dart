import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/search/data_sources/search_remote_mock.dart';
import 'package:ota/domain/search/models/search_recommendation_model.dart';
import 'package:ota/domain/search/models/search_service_type.dart';
import 'package:ota/domain/search/models/search_suggestion_model.dart';
import 'package:ota/domain/search/models/suggestion_data_argument.dart';
import 'package:ota/domain/search/repositories/search_repository_impl.dart';

import '../../../hotel/repositories/internet_failure_mock.dart';
import '../../../hotel/repositories/internet_success_mock.dart';
import '../repositories/search_remote_datasource_impl_failure_mock.dart';

void main() {
  SearchRepository? searchRepositoryServerException;
  SearchRepository? searchRepositoryMock;
  SearchRepository? searchRepositoryInternetFailure;

  setUpAll(() async {
    /// Code coverage for default implementation.
    searchRepositoryMock = SearchRepositoryImpl();

    /// Code coverage for mock class
    searchRepositoryMock = SearchRepositoryImpl(
        remoteDataSource: SearchMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    /// Server Exception
    searchRepositoryServerException = SearchRepositoryImpl(
        remoteDataSource: SearchRemoteDataSourceFailureMock(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    searchRepositoryInternetFailure = SearchRepositoryImpl(
        remoteDataSource: SearchMockDataSourceImpl(),
        internetInfo: InternetFailureMock());
  });

  test(
      'Search analytics Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResultRecommendation = await searchRepositoryMock!
        .getSearchRecommendationData(SearchServiceType.hotel);

    /// Get model from mock data.
    final SearchRecommendationModel recommendationModel =
        consentResultRecommendation.right;

    /// Condition check for hotel value null
    expect(recommendationModel.getSearchRecommendation != null, true);

    /// Consent user cases impl
    final consentResultSuggestion = await searchRepositoryMock!
        .getSearchSuggestionData(SuggestionDataArgument.fromHotelSuggestion(
            "searchText", 3, "hotel_key"));

    /// Get model from mock data.
    final SearchSuggestionModel suggestionModel = consentResultSuggestion.right;

    /// Condition check for hotel value null
    expect(suggestionModel.getDataScienceAutoCompleteSearch != null, false);
  });

  test(
      'Search analytics Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final consentResultRecommendation = await searchRepositoryInternetFailure!
        .getSearchRecommendationData(SearchServiceType.hotel);

    expect(consentResultRecommendation.isLeft, true);

    /// Consent user cases impl
    final consentResultSuggestion = await searchRepositoryInternetFailure!
        .getSearchSuggestionData(SuggestionDataArgument.fromOtaSuggestion(
            "searchText", 3, "hotel_key"));

    expect(consentResultSuggestion.isLeft, true);
  });

  test(
      'Search analytics Repository '
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final consentResultRecommendation = await searchRepositoryServerException!
        .getSearchRecommendationData(SearchServiceType.hotel);

    expect(consentResultRecommendation.isLeft, true);

    /// Consent user cases impl
    final consentResultSuggestion = await searchRepositoryServerException!
        .getSearchSuggestionData(SuggestionDataArgument.fromHotelSuggestion(
            "searchText", 3, "hotel_key"));

    expect(consentResultSuggestion.isLeft, true);
  });
}
