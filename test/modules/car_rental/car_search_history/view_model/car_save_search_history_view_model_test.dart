import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_search_history/view_model/car_save_search_history_view_model.dart';

void main() {
  test('Car Save Search History View Model Tests', () async {
    CarSaveSearchHistoryViewModelState stateNone =
        CarSaveSearchHistoryViewModelState.none;

    CarSaveSearchHistoryViewModel model = CarSaveSearchHistoryViewModel();

    expect(model.carSaveSearchHistoryViewModelState, stateNone);
  });
}
