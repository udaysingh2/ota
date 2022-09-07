import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/search/models/search_recommendation_model.dart';
import 'package:ota/domain/search/models/search_service_type.dart';
import 'package:ota/domain/search/usecases/search_recommendation_use_cases.dart';

import '../repositories/search_repository_impl_success_mock.dart';

void main() {
  SearchRecommendationUseCases? searchRecommendationUseCases;

  setUpAll(() async {
    /// Code coverage for default implementation.
    searchRecommendationUseCases = SearchRecommendationUseCasesImpl();

    /// Code coverage for mock class
    searchRecommendationUseCases = SearchRecommendationUseCasesImpl(
        repository: SearchRepositoryImplSuccessMock());
  });

  test(
      'Search analytics usecases '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResultRecommendadtion = await searchRecommendationUseCases!
        .getSearchRecommendationData(SearchServiceType.hotel);

    /// Get model from mock data.
    final SearchRecommendationModel recommendationModel =
        consentResultRecommendadtion!.right;

    /// Condition check for hotel value null
    expect(recommendationModel.getSearchRecommendation != null, true);
  });
}
