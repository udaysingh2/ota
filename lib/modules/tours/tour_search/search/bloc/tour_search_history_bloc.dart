import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/tours/search/model/tour_search_history_model_domain.dart';
import 'package:ota/domain/tours/search/usecases/tour_search_use_cases.dart';
import 'package:ota/modules/tours/tour_search/search/view_model/tour_search_history_view_model.dart';

class TourSearchHistoryBloc extends Bloc<TourSearchHistoryViewModel> {
  TourSearchHistoryUseCasesImpl searchHistoryUseCases =
      TourSearchHistoryUseCasesImpl();

  @override
  TourSearchHistoryViewModel initDefaultValue() {
    return TourSearchHistoryViewModel(
      searchHistoryList: [],
    );
  }

  void fetchTourSearchHistoryData() async {
    state.recommendationState = TourSearchHistoryViewModelState.loading;
    emit(state);

    Either<Failure, TourSearchHistoryModelDomain>? result =
        await searchHistoryUseCases.getTourSearchHistoryData();
    if (result != null && result.isRight) {
      TourSearchHistoryData getTourSearchHistory =
          result.right.getTourAndTicketRecentSearches ??
              TourSearchHistoryData();

      if (getTourSearchHistory.data == null) {
        state.recommendationState = TourSearchHistoryViewModelState.failure;
        emit(state);
      }

      state.searchHistoryList =
          _getTourSearchHistoryModel(getTourSearchHistory);
      state.recommendationState = TourSearchHistoryViewModelState.success;
      emit(state);
    } else if (result?.left is InternetFailure) {
      state.recommendationState =
          TourSearchHistoryViewModelState.internetFailure;
      emit(state);
    } else {
      state.recommendationState = TourSearchHistoryViewModelState.failure;
      emit(state);
    }
  }

  List<TourSearchHistoryModel> _getTourSearchHistoryModel(
      TourSearchHistoryData data) {
    List<SearchHistory> searchHistoryData = data.data?.searchHistory ?? [];

    return List<TourSearchHistoryModel>.generate(
      searchHistoryData.length,
      (index) => TourSearchHistoryModel.mapFromModel(
        searchHistoryData[index],
      ),
    );
  }

  bool get isSearchHistoryEmpty => state.searchHistoryList.isEmpty;
}
