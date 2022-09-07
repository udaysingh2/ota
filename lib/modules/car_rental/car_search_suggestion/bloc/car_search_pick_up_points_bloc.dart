import 'package:either_dart/either.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/car_rental/car_save_search_history/models/car_save_search_argument_domain.dart';
import 'package:ota/domain/car_rental/car_save_search_history/usecases/car_save_search_use_cases.dart';
import 'package:ota/modules/car_rental/car_search_history/view_model/car_save_search_history_view_argument_model.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view_model/car_search_suggestion_model.dart';

import '../../../../common/network/failures.dart';
import '../../../../domain/car_rental/car_search_suggestion/models/car_search_suggestion_argument_model.dart';
import '../../../../domain/car_rental/car_search_suggestion/models/car_search_suggestion_model_domain.dart';
import '../../../../domain/car_rental/car_search_suggestion/usecases/car_searc_suggestion_use_cases.dart';
import '../view_model/car_search_pickup_points_model.dart';

const int _kSuggestionLimit = 20;
const String _kServiceType = "CARRENTAL";
const List<String> _kSearchType = ["location"];

class CarSearchPickUpPointsBloc extends Bloc<CarSearchPickUpPointsModel> {
  @override
  CarSearchPickUpPointsModel initDefaultValue() {
    return CarSearchPickUpPointsModel(cityId: "", locationList: []);
  }

  CarSearchSuggestionUseCases carSearchSuggestionUseCases =
      CarSearchSuggestionUseCasesImpl();
  CarSaveSearchHistoryUseCasesImpl saveSearchHistoryUseCases =
      CarSaveSearchHistoryUseCasesImpl();

  set setCityId(value) => state.cityId = value;
  set locationList(value) => state.locationList = value;
  get cityId => state.cityId;

  List get pickUpPointsList => state.locationList;
  bool get isPickUpPointsAvailable => pickUpPointsList.isNotEmpty;
  bool get isStateNone =>
      state.carSearchPickUpPointsState == CarSearchPickUpPointsState.none;
  bool get isStateLoading =>
      state.carSearchPickUpPointsState == CarSearchPickUpPointsState.loading;
  bool get isStateFailure =>
      state.carSearchPickUpPointsState == CarSearchPickUpPointsState.failure ||
      state.carSearchPickUpPointsState ==
          CarSearchPickUpPointsState.internetFailure;
  bool get isStatePickUpsAvailable =>
      state.carSearchPickUpPointsState ==
      CarSearchPickUpPointsState.pickUpPointsAvailable;

  clearSelection() {
    setCityId = "";
    locationList = [];
  }

  void saveCarSearchHistoryData(
      CarSaveSearchHistoryViewArgumentModel argumentModel) {
    saveSearchHistoryUseCases.saveCarSearchHistoryData(
      CarSaveSearchHistoryArgumentDomain.from(argumentModel: argumentModel),
    );
  }

  Future<void> fetchPickUpLocations(String cityName) async {
    if (cityName.trim().isEmpty) {
      state.carSearchPickUpPointsState = CarSearchPickUpPointsState.failure;
      emit(state);
      return;
    }
    state.carSearchPickUpPointsState = CarSearchPickUpPointsState.loading;
    emit(state);

    final suggestionArgument = CarSearchSuggestionArgumentModelDomain.from(
      searchCondition: cityName,
      serviceType: _kServiceType,
      limit: _kSuggestionLimit,
      searchType: _kSearchType,
    );
    Either<Failure, CarSearchSuggestionData>? result =
        await carSearchSuggestionUseCases.getCarSearchSuggestionData(
            argument: suggestionArgument);
    if (result != null && result.isRight) {
      state.locationList.clear();
      if (result.right.getDataScienceAutoCompleteSearch != null) {
        CarSearchSuggestionsViewModel model =
            CarSearchSuggestionsViewModel.fromData(
                data: result.right.getDataScienceAutoCompleteSearch!);
        state.carSearchPickUpPointsState =
            CarSearchPickUpPointsState.pickUpPointsAvailable;
        state.locationList = model.location?.cast<dynamic>() ?? [];
        emit(state);
      } else {
        state.carSearchPickUpPointsState =
            CarSearchPickUpPointsState.pickUpPointsAvailable;
        emit(state);
      }
    } else if (result?.left is InternetFailure) {
      state.carSearchPickUpPointsState =
          CarSearchPickUpPointsState.internetFailure;
      emit(state);
    } else {
      state.carSearchPickUpPointsState = CarSearchPickUpPointsState.failure;
      emit(state);
    }
  }
}
