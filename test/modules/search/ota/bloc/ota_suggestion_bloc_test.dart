import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/search/data_sources/search_remote_data_source.dart';
import 'package:ota/domain/search/repositories/search_repository_impl.dart';
import 'package:ota/domain/search/usecases/search_suggestion_use_cases.dart';
import 'package:ota/modules/search/ota/bloc/ota_suggestion_bloc.dart';
import 'package:ota/modules/search/ota/view_model/ota_suggestion_view_model.dart';

import '../../../hotel/repositories/internet_failure_mock.dart';
import '../../hotel/repositories/search_repository_impl_success_mock.dart';

void main() {
  SearchSuggestionUseCases searchUseCase;
  SearchSuggestionUseCases searchUseCaseFailureMock;

  /// Code coverage for mock class
  searchUseCase = SearchSuggestionUseCasesImpl(
      repository: SearchRepositoryImplSuccessMock());

  /// Internet Failure
  searchUseCaseFailureMock = SearchSuggestionUseCasesImpl(
      repository: SearchRepositoryImpl(
          remoteDataSource: SearchRemoteDataSourceImpl(),
          internetInfo: InternetFailureMock()));

  OtaSuggestionBloc bloc = OtaSuggestionBloc();

  test("Ota Suggestion Bloc with empty argument Test", () {
    ///default
    expect(bloc.state.suggestionState, OtaSuggestionViewModelState.none);

    // /Case when full data available
    bloc.suggestionUseCases = searchUseCase;
    bloc.fetchSuggestionData("");
    expect(bloc.state.suggestionState, OtaSuggestionViewModelState.failure);
  });

  test("Ota Suggestion Bloc with argument Test", () {
    // /Case when full data available
    bloc.suggestionUseCases = searchUseCase;
    bloc.fetchSuggestionData("Hotel");
    expect(bloc.state.suggestionState, OtaSuggestionViewModelState.loading);

    bloc.fetchSuggestionData("Hotel", isLazyLoad: true);
    expect(bloc.state.suggestionState, OtaSuggestionViewModelState.loading);
    bloc.clearSuggestions();
    expect(bloc.state.suggestionState, OtaSuggestionViewModelState.failure);
  });

  test("Ota Recommendation Failure Data test", () {
    ///Case of Failure
    bloc.suggestionUseCases = searchUseCaseFailureMock;
    bloc.fetchSuggestionData("searchText");
    expect(bloc.state.suggestionState, OtaSuggestionViewModelState.loading);
  });
}
