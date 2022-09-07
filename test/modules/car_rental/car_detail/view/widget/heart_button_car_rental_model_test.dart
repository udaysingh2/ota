import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_detail/view/widget/heart_button_car_rental_model.dart';

void main() {
  test('Heart Button Model Test', () async {
    // Build our app and trigger a frame.
    HeartButtonCarRentalModel heartButtonCarRentalModel =
        HeartButtonCarRentalModel();
    expect(heartButtonCarRentalModel.heartButtonCarRentalState,
        HeartButtonCarRentalState.disabled);
    await Future.delayed(const Duration(milliseconds: 100));
    heartButtonCarRentalModel.heartButtonCarRentalState =
        HeartButtonCarRentalState.selected;
    expect(heartButtonCarRentalModel.heartButtonCarRentalState,
        HeartButtonCarRentalState.selected);
  });
}
