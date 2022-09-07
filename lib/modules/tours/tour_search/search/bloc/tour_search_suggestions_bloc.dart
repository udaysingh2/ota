import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/tours/search/model/tour_search_suggestions_argument_domain.dart';
import 'package:ota/domain/tours/search/model/tour_search_suggestions_model_domain.dart';
import 'package:ota/domain/tours/search/usecases/tour_search_suggestions_use_case.dart';
import 'package:ota/modules/tours/tour_search/search/helper/tour_search_suggestions_helpers.dart';
import 'package:ota/modules/tours/tour_search/search/view_model/tour_search_suggestions_view_model.dart';

const int _kSuggestionLimit = 20;
const String _kServiceType = "TOUR";

class TourSearchSuggestionBloc extends Bloc<TourSearchSuggestionsViewModel> {
  int searchTypeIndex = 0;
  TourSearchSuggestionsUseCases suggestionUseCases =
      TourSearchSuggestionsUseCasesImpl();

  @override
  initDefaultValue() {
    return TourSearchSuggestionsViewModel(tour: [], ticket: [], location: []);
  }

  void fetchSuggestionData(String searchText) async {
    if (searchText.trim().isEmpty) {
      state.suggestionsState = TourSearchSuggestionsViewModelState.failure;
      emit(state);
      return;
    }

    state.suggestionsState = TourSearchSuggestionsViewModelState.loading;
    emit(state);

    final suggestionArgument = TourSearchSuggestionsArgumentDomain.from(
      searchCondition: searchText,
      serviceType: _kServiceType,
      limit: _kSuggestionLimit,
      searchType: TourSearchSuggestionsHelper.getSearchType(index),
    );
    Either<Failure, TourSearchSuggestionsModelDomain>? result =
        await suggestionUseCases
            .getTourSearchSuggestionsData(suggestionArgument);

    if (result != null && result.isRight) {
      state.tour!.clear();
      state.ticket!.clear();
      state.location!.clear();
      if (result.right.getDataScienceAutoCompleteSearch!.data!.suggestions !=
          null) {
        TourSearchSuggestionsViewModel model =
            TourSearchSuggestionsViewModel.fromData(
                data: result.right.getDataScienceAutoCompleteSearch!.data!);
        model.suggestionsState = TourSearchSuggestionsViewModelState.success;
        emit(model);
      } else {
        state.suggestionsState = TourSearchSuggestionsViewModelState.success;
        emit(state);
      }
    } else if (result?.left is InternetFailure) {
      state.suggestionsState =
          TourSearchSuggestionsViewModelState.internetFailure;
      emit(state);
    } else {
      state.suggestionsState = TourSearchSuggestionsViewModelState.failure;
      emit(state);
    }
  }

  bool get anySuggestions =>
      state.tour!.isNotEmpty ||
      state.ticket!.isNotEmpty ||
      state.location!.isNotEmpty;

  int get index => searchTypeIndex;

  void setIndex(int index) {
    searchTypeIndex = index;
  }

  void clearSuggestions() {
    state.suggestionsState = TourSearchSuggestionsViewModelState.failure;
    state.tour!.clear();
    state.ticket!.clear();
    state.location!.clear();
    emit(state);
  }
}
