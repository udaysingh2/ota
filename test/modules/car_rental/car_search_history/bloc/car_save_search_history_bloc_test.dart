import 'package:flutter_test/flutter_test.dart';

import 'package:ota/domain/car_rental/car_save_search_history/models/car_save_search_domain_model.dart';
import 'package:ota/modules/car_rental/car_search_history/bloc/car_save_search_history_bloc.dart';
import 'package:ota/modules/car_rental/car_search_history/view_model/car_save_search_history_view_argument_model.dart';
import 'package:ota/modules/car_rental/car_search_history/view_model/car_save_search_history_view_model.dart';

void main() {
  test("Car save search history bloc test ", () {
    final CarSaveSearchHistoryBloc carSaveSearchHistoryBloc =
        CarSaveSearchHistoryBloc();
    CarSaveSearchHistoryViewArgumentModel argument =
        CarSaveSearchHistoryViewArgumentModel(
      cityId: "cityId",
      countryId: "countryId",
      locationId: "locationId",
      searchKey: "keyword",
    );
    carSaveSearchHistoryBloc.saveCarSearchHistoryData(argument);
    expect(carSaveSearchHistoryBloc.state.carSaveSearchHistoryViewModelState,
        CarSaveSearchHistoryViewModelState.none);
    carSaveSearchHistoryBloc.state.carSaveSearchHistoryViewModelState =
        CarSaveSearchHistoryViewModelState.failure;
    SaveRecentCarRentalSearchHistory domainModel =
        SaveRecentCarRentalSearchHistory(status: null);
    expect(domainModel.status, null);
    carSaveSearchHistoryBloc.dispose();
  });
}
