import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view_model/car_search_screen_suggestion_model.dart';

void main() {
  test('Car Search Screen Suggestion Model Test', () async {
    CarSearchScreenState stateNone = CarSearchScreenState.none;

    CarSearchScreenModel model = CarSearchScreenModel();

    expect(model.carSearchScreenState, stateNone);
  });
}
