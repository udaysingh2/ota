import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/search/data_sources/search_remote_data_source.dart';
import 'package:ota/domain/search/repositories/search_repository_impl.dart';
import 'package:ota/domain/search/usecases/search_suggestion_use_cases.dart';
import 'package:ota/modules/search/hotel/bloc/hotel_suggestion_bloc.dart';
import 'package:ota/modules/search/hotel/view_model/hotel_suggestion_view_model.dart';

import '../../../hotel/repositories/internet_failure_mock.dart';
import '../repositories/search_repository_impl_success_mock.dart';

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

  HotelSuggestionBloc bloc = HotelSuggestionBloc();

  test("Hotel Suggestion Bloc with empty argument Test", () {
    ///default
    expect(bloc.state.suggestionState, HotelSuggestionViewModelState.none);

    // /Case when full data available
    bloc.suggestionUseCases = searchUseCase;
    bloc.fetchSuggestionData("");
    expect(bloc.state.suggestionState, HotelSuggestionViewModelState.failure);
  });

  test("Hotel Suggestion Bloc with argument Test", () {
    // /Case when full data available
    bloc.suggestionUseCases = searchUseCase;
    bloc.fetchSuggestionData("Hotel");
    expect(bloc.state.suggestionState, HotelSuggestionViewModelState.loading);

    bloc.fetchSuggestionData("Hotel");
    expect(bloc.state.suggestionState, HotelSuggestionViewModelState.loading);
    bloc.clearSuggestions();
    expect(bloc.state.suggestionState, HotelSuggestionViewModelState.failure);
  });

  test("Hotel Recommendation Failure Data test", () {
    ///Case of Failure
    bloc.suggestionUseCases = searchUseCaseFailureMock;
    bloc.fetchSuggestionData("searchText");
    expect(bloc.state.suggestionState, HotelSuggestionViewModelState.loading);
  });
}
