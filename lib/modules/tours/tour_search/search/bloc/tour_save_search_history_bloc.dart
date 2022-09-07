import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/tours/search/model/tour_save_search_history_argument_domain.dart';
import 'package:ota/domain/tours/search/model/tour_save_search_history_model_domain.dart';
import 'package:ota/domain/tours/search/usecases/tour_save_search_history_use_cases.dart';
import 'package:ota/modules/tours/tour_search/search/view_model/tour_save_search_history_argument_model.dart';
import 'package:ota/modules/tours/tour_search/search/view_model/tour_save_search_history_view_model.dart';

class TourSaveSearchHistoryBloc extends Bloc<TourSaveSearchHistoryViewModel> {
  TourSaveSearchHistoryUseCasesImpl saveSearchHistoryUseCases =
      TourSaveSearchHistoryUseCasesImpl();

  @override
  TourSaveSearchHistoryViewModel initDefaultValue() {
    return TourSaveSearchHistoryViewModel();
  }

  Future<void> saveTourSearchHistoryData(
      TourSaveSearchHistoryArgumentModel argumentModel) async {
    state.tourSaveSearchHistoryViewModelState =
        TourSaveSearchHistoryViewModelState.none;
    emit(state);

    Either<Failure, TourSaveSearchHistoryModelDomain>? result =
        await saveSearchHistoryUseCases.saveTourSearchHistoryData(
            TourSaveSearchHistoryArgumentDomain.from(
                argumentModel: argumentModel));
    if (result != null && result.isRight) {
      SaveRecentTourAndTicketSearchHistory saveSearchHistory =
          result.right.saveRecentTourAndTicketSearchHistory!;

      if (saveSearchHistory.status == null) {
        state.tourSaveSearchHistoryViewModelState =
            TourSaveSearchHistoryViewModelState.failure;
        emit(state);
      }
      state.tourSaveSearchHistoryViewModelState =
          TourSaveSearchHistoryViewModelState.success;
      emit(state);
    } else {
      state.tourSaveSearchHistoryViewModelState =
          TourSaveSearchHistoryViewModelState.failure;
      emit(state);
    }
  }
}
