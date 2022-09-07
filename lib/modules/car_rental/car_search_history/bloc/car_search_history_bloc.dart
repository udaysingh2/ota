import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/car_rental/car_search_history/models/car_search_history_model.dart';
import 'package:ota/domain/car_rental/car_search_history/usecases/car_search_history_use_cases.dart';
import 'package:ota/modules/car_rental/car_search_history/view_model/car_search_history_view_model.dart';

class CarSearchHistoryBloc extends Bloc<CarSearchHistoryViewModel> {
  CarSearchHistoryUseCasesImpl searchHistoryUseCases =
      CarSearchHistoryUseCasesImpl();

  @override
  CarSearchHistoryViewModel initDefaultValue() {
    return CarSearchHistoryViewModel(searchHistoryList: []);
  }

  void fetchCarSearchHistoryData() async {
    state.recommendationState = CarSearchHistoryViewModelState.loading;
    emit(state);

    Either<Failure, CarSearchHistoryModelDomainData>? result =
        await searchHistoryUseCases.getCarSearchHistoryData();
    if (result != null && result.isRight) {
      GetCarRentalRecentSearchesData getCarSearchHistory =
          result.right.getCarRentalRecentSearches?.data ?? GetCarRentalRecentSearchesData();

      if (getCarSearchHistory.searchHistory == null) {
        state.recommendationState = CarSearchHistoryViewModelState.failure;
        emit(state);
      }

      state.searchHistoryList = _getCarSearchHistoryModel(getCarSearchHistory);
      state.recommendationState = CarSearchHistoryViewModelState.success;
      emit(state);
    } else {
      state.recommendationState = CarSearchHistoryViewModelState.failure;
      emit(state);
    }
  }

  List<CarRentalSearchHistoryModel> _getCarSearchHistoryModel(
      GetCarRentalRecentSearchesData data) {
    List<CarRecentSearchList> searchHistoryData = data.searchHistory?.first.carRental?.carRecentSearchList ?? [];

    return List<CarRentalSearchHistoryModel>.generate(
      searchHistoryData.length,
      (index) => CarRentalSearchHistoryModel.mapFromModel(
        searchHistoryData[index],
      ),
    );
  }

  bool get isSearchHistoryEmpty => state.searchHistoryList.isEmpty;
}
