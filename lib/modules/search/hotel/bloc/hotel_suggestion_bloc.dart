import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/search/models/search_suggestion_model.dart';
import 'package:ota/domain/search/models/suggestion_data_argument.dart';
import 'package:ota/domain/search/usecases/search_suggestion_use_cases.dart';
import 'package:ota/modules/search/hotel/helpers/search_helper.dart';
import 'package:ota/modules/search/hotel/view_model/hotel_suggestion_view_model.dart';

class HotelSuggestionBloc extends Bloc<HotelSuggestionViewModel> {
  SearchSuggestionUseCases suggestionUseCases = SearchSuggestionUseCasesImpl();

  @override
  initDefaultValue() {
    return HotelSuggestionViewModel(suggestionList: []);
  }

  void fetchSuggestionData(String searchText) async {
    if (searchText.trim().isEmpty) {
      state.suggestionState = HotelSuggestionViewModelState.failure;
      emit(state);
      return;
    }

    state.suggestionState = HotelSuggestionViewModelState.loading;
    emit(state);

    final suggestionArgument = SuggestionDataArgument.fromHotelSuggestion(
        searchText,
        AppConfig().configModel.hotelSearchSuggestionMaxLimit,
        AppConfig().configModel.otaSearchServicesEnabled);
    Either<Failure, SearchSuggestionModel>? result =
        await suggestionUseCases.getSearchSuggestionData(suggestionArgument);

    if (result != null && result.isRight) {
      Suggestions? suggestions =
          result.right.getDataScienceAutoCompleteSearch?.data?.suggestions;

      List<HotelSuggestionModel> cityLocationSuggestionList =
          SearchHelper.getHotelSuggestionViewModelList(
              cityLocationList: suggestions?.cityLocation);
      List<HotelSuggestionModel> hotelSuggestionList =
          SearchHelper.getHotelSuggestionViewModelList(
              hotelList: suggestions?.hotel);

      cityLocationSuggestionList.addAll(hotelSuggestionList);

      state.suggestionList = cityLocationSuggestionList;
      state.suggestionState = HotelSuggestionViewModelState.success;
      emit(state);
    } else if (result?.left is InternetFailure) {
      state.suggestionState = HotelSuggestionViewModelState.internetFailure;
      emit(state);
    } else {
      state.suggestionState = HotelSuggestionViewModelState.failure;
      emit(state);
    }
  }

  void clearSuggestions() {
    state.suggestionState = HotelSuggestionViewModelState.failure;
    state.suggestionList.clear();
    emit(state);
  }

  bool get isSuccess =>
      state.suggestionState == HotelSuggestionViewModelState.success;

  bool get isLazyLoading =>
      state.suggestionState == HotelSuggestionViewModelState.loading &&
      state.suggestionList.isNotEmpty;
}
