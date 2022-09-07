import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/search/models/search_suggestion_model.dart';
import 'package:ota/domain/search/models/suggestion_data_argument.dart';
import 'package:ota/domain/search/usecases/search_suggestion_use_cases.dart';
import 'package:ota/modules/search/hotel/helpers/search_helper.dart';
import 'package:ota/modules/search/ota/view_model/ota_suggestion_view_model.dart';

class OtaSuggestionBloc extends Bloc<OtaSuggestionViewModel> {
  SearchSuggestionUseCases suggestionUseCases = SearchSuggestionUseCasesImpl();

  @override
  initDefaultValue() {
    return OtaSuggestionViewModel(suggestionList: []);
  }

  void fetchSuggestionData(String searchText, {bool isLazyLoad = false}) async {
    if (searchText.trim().isEmpty) {
      state.suggestionState = OtaSuggestionViewModelState.failure;
      emit(state);
      return;
    }

    state.suggestionState = OtaSuggestionViewModelState.loading;
    emit(state);

    final suggestionArgument = SuggestionDataArgument.fromOtaSuggestion(
        searchText,
        AppConfig().configModel.otaSearchSuggestionMaxLimit,
        AppConfig().configModel.otaSearchServicesEnabled);
    Either<Failure, SearchSuggestionModel>? result =
        await suggestionUseCases.getSearchSuggestionData(suggestionArgument);
    if (result != null && result.isRight) {
      Suggestions? suggestions =
          result.right.getDataScienceAutoCompleteSearch?.data?.suggestions;

      List<OtaSuggestionModel> cityLocationSuggestionList =
          SearchHelper.getOtaSuggestionViewModelList(
              cityLocationList: suggestions?.cityLocation);

      state.suggestionList = cityLocationSuggestionList;
      state.suggestionState = OtaSuggestionViewModelState.success;
      emit(state);
    } else if (result?.left is InternetFailure) {
      state.suggestionState = OtaSuggestionViewModelState.internetFailure;
      emit(state);
    } else {
      state.suggestionState = OtaSuggestionViewModelState.failure;
      emit(state);
    }
  }

  void clearSuggestions() {
    state.suggestionState = OtaSuggestionViewModelState.failure;
    state.suggestionList.clear();
    emit(state);
  }
}
