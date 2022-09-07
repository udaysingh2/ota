import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/search/models/search_recommendation_model.dart';
import 'package:ota/domain/search/models/search_service_type.dart';
import 'package:ota/domain/search/usecases/search_recommendation_use_cases.dart';
import 'package:ota/modules/search/hotel/helpers/search_helper.dart';
import 'package:ota/modules/search/ota/view_model/ota_recommendation_view_model.dart';

class OtaRecommendationBloc extends Bloc<OtaRecommendationViewModel> {
  SearchRecommendationUseCases recommendationUseCases =
      SearchRecommendationUseCasesImpl();
  @override
  OtaRecommendationViewModel initDefaultValue() {
    return OtaRecommendationViewModel(
        recommendationList: [], searchHistoryList: []);
  }

  void fetchRecommendationData() async {
    state.recommendationState = OtaRecommendationViewModelState.loading;
    emit(state);

    Either<Failure, SearchRecommendationModel>? result =
        await recommendationUseCases
            .getSearchRecommendationData(SearchServiceType.ota);
    if (result != null && result.isRight) {
      GetSearchRecommendation getHotelRecommendation =
          result.right.getSearchRecommendation ?? GetSearchRecommendation();

      if (getHotelRecommendation.data == null) {
        state.recommendationState = OtaRecommendationViewModelState.failure;
        emit(state);
      }
      OtaRecommendationViewModel searchRecommendedViewModelData =
          SearchHelper.getOtaRecommendationViewModel(getHotelRecommendation);
      state.recommendationList =
          searchRecommendedViewModelData.recommendationList;
      state.searchHistoryList =
          searchRecommendedViewModelData.searchHistoryList;
      state.recommendationState = OtaRecommendationViewModelState.success;
      emit(state);
    } else if (result?.left is InternetFailure) {
      state.recommendationState =
          OtaRecommendationViewModelState.internetFailure;
      emit(state);
    } else {
      state.recommendationState = OtaRecommendationViewModelState.failure;
      emit(state);
    }
  }

  void clearRecommendations() {
    state.recommendationState = OtaRecommendationViewModelState.failure;
    state.recommendationList.clear();
    state.searchHistoryList.clear();
    emit(state);
  }

  bool get isRecommendationsEmpty => state.recommendationList.isEmpty;
  bool get isSearchHistoryEmpty => state.searchHistoryList.isEmpty;
}
