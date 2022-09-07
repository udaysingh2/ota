import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/search/models/search_suggestion_model.dart';
import 'package:ota/domain/search/models/suggestion_data_argument.dart';
import 'package:ota/domain/search/usecases/search_suggestion_use_cases.dart';

import '../repositories/search_repository_impl_success_mock.dart';

void main() {
  SearchSuggestionUseCases? searchUseCase;

  setUpAll(() async {
    /// Code coverage for default implementation.
    searchUseCase = SearchSuggestionUseCasesImpl();

    /// Code coverage for mock class
    searchUseCase = SearchSuggestionUseCasesImpl(
        repository: SearchRepositoryImplSuccessMock());
  });

  test(
      'Search analytics usecases '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResultSuggestion = await searchUseCase!
        .getSearchSuggestionData(SuggestionDataArgument.fromHotelSuggestion(
            "searchText", 3, "hotel_key"));

    /// Get model from mock data.
    final SearchSuggestionModel suggestionModel =
        consentResultSuggestion!.right;

    /// Condition check for hotel value null
    expect(suggestionModel.getDataScienceAutoCompleteSearch != null, true);
  });
}
