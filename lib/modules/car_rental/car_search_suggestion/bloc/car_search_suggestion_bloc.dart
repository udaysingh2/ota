import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_argument_model.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_model_domain.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/usecases/car_searc_suggestion_use_cases.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view_model/car_search_suggestion_model.dart';

const int _kSuggestionLimit = 20;
const String _kServiceType = "CARRENTAL";
const List<String> _kSearchType = ["location", "city"];

class CarSearchSuggestionBloc extends Bloc<CarSearchSuggestionsViewModel> {
  int searchTypeIndex = 0;
  CarSearchSuggestionUseCases carSearchSuggestionUseCases =
      CarSearchSuggestionUseCasesImpl();

  @override
  initDefaultValue() {
    return CarSearchSuggestionsViewModel(location: [], city: []);
  }

  Future<void> fetchSuggestionData(String searchText) async {
    if (searchText.trim().isEmpty) {
      state.suggestionsState = CarSearchSuggestionsViewModelState.failure;
      emit(state);
      return;
    }

    state.suggestionsState = CarSearchSuggestionsViewModelState.loading;
    emit(state);

    final suggestionArgument = CarSearchSuggestionArgumentModelDomain.from(
      searchCondition: searchText,
      serviceType: _kServiceType,
      limit: _kSuggestionLimit,
      searchType: _kSearchType,
    );
    Either<Failure, CarSearchSuggestionData>? result =
        await carSearchSuggestionUseCases.getCarSearchSuggestionData(
            argument: suggestionArgument);

    if (result != null && result.isRight) {
      state.location!.clear();
      state.city!.clear();

      if (result.right.getDataScienceAutoCompleteSearch != null) {
        CarSearchSuggestionsViewModel model =
            CarSearchSuggestionsViewModel.fromData(
                data: result.right.getDataScienceAutoCompleteSearch!);
        model.suggestionsState = CarSearchSuggestionsViewModelState.success;
        emit(model);
        if (model.city!.isEmpty && model.location!.isEmpty) {
          model.suggestionsState = CarSearchSuggestionsViewModelState.failure;
          emit(state);
        }
      } else {
        state.suggestionsState = CarSearchSuggestionsViewModelState.success;
        emit(state);
      }
    } else {
      if (result?.left is InternetFailure) {
        state.suggestionsState =
            CarSearchSuggestionsViewModelState.failureNetwork;
        emit(state);
      } else {
        state.suggestionsState = CarSearchSuggestionsViewModelState.failure;
        emit(state);
      }
    }
  }

  bool get anySuggestions =>
      state.city!.isNotEmpty || state.location!.isNotEmpty;

  int get index => searchTypeIndex;

  void setIndex(int index) {
    searchTypeIndex = index;
  }

  void clearSuggestions() {
    state.suggestionsState = CarSearchSuggestionsViewModelState.none;
    state.city!.clear();
    state.location!.clear();
    emit(state);
  }
}
