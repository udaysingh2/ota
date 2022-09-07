import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view_model/car_search_pickup_points_model.dart';

void main() {
  test('Car Search Pickup points View Model Test', () async {
    CarSearchPickUpPointsState stateNone = CarSearchPickUpPointsState.none;

    CarSearchPickUpPointsModel model =
        CarSearchPickUpPointsModel(cityId: '', locationList: []);

    expect(model.carSearchPickUpPointsState, stateNone);
  });
}
