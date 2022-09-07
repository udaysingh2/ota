import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/data_sources/car_search_suggestion_data_source_mock.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/data_sources/car_search_suggestion_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/repositories/car_search_suggestion_repsoitory_impl.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/usecases/car_searc_suggestion_use_cases.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/bloc/car_search_suggestion_bloc.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view_model/car_search_suggestion_model.dart';

import '../../../hotel/repositories/internet_failure_mock.dart';

void main() {
  CarSearchSuggestionUseCases searchUseCase;
  CarSearchSuggestionUseCases searchUseCaseFailureMock;

  /// Code coverage for mock class
  searchUseCase = CarSearchSuggestionUseCasesImpl(
      repository: CarSearchSuggestionRepositoryImpl(
          remoteDataSource: CarSearchSuggestionMockDataSourceImpl()));

  /// Internet Failure
  searchUseCaseFailureMock = CarSearchSuggestionUseCasesImpl(
      repository: CarSearchSuggestionRepositoryImpl(
          remoteDataSource: CarSearchSuggestionRemoteDataSourceImpl(),
          internetInfo: InternetFailureMock()));

  CarSearchSuggestionBloc bloc = CarSearchSuggestionBloc();

  test("Car Suggestion Bloc with empty argument Test", () {
    ///default
    expect(
        bloc.state.suggestionsState, CarSearchSuggestionsViewModelState.none);

    // /Case when full data available
    bloc.carSearchSuggestionUseCases = searchUseCase;
    bloc.fetchSuggestionData("");
  });

  test("Car Suggestion Bloc with argument Test", () {
    // /Case when full data available
    bloc.carSearchSuggestionUseCases = searchUseCase;
    bloc.fetchSuggestionData("Hotel");
    expect(bloc.state.suggestionsState,
        CarSearchSuggestionsViewModelState.loading);

    bloc.clearSuggestions();
  });

  test("Car Recommendation Failure Data test", () {
    ///Case of Failure
    bloc.carSearchSuggestionUseCases = searchUseCaseFailureMock;
    bloc.fetchSuggestionData("searchText");
    expect(bloc.state.suggestionsState,
        CarSearchSuggestionsViewModelState.loading);
  });
}
