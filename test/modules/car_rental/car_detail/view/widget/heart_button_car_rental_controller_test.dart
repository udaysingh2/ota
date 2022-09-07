import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_detail/view/widget/heart_button_car_rental_controller.dart';
import 'package:ota/modules/car_rental/car_detail/view/widget/heart_button_car_rental_model.dart';

void main() {
  test('Heart Button Controller Test', () async {
    // Build our app and trigger a frame.
    HeartButtonCarRentalController heartButtonController =
        HeartButtonCarRentalController();
    expect(heartButtonController.state.heartButtonCarRentalState,
        HeartButtonCarRentalState.disabled);
    await Future.delayed(const Duration(milliseconds: 100));
    heartButtonController.setSelected();
    await Future.delayed(const Duration(milliseconds: 100));
    expect(heartButtonController.state.heartButtonCarRentalState,
        HeartButtonCarRentalState.selected);
    heartButtonController.setUnselected();
    await Future.delayed(const Duration(milliseconds: 100));
    expect(heartButtonController.state.heartButtonCarRentalState,
        HeartButtonCarRentalState.unselected);
    heartButtonController.setDisabled();
    await Future.delayed(const Duration(milliseconds: 100));
    expect(heartButtonController.state.heartButtonCarRentalState,
        HeartButtonCarRentalState.disabled);
    expect(
        heartButtonController.getState(), HeartButtonCarRentalState.disabled);
    await Future.delayed(const Duration(milliseconds: 100));
    heartButtonController.toggle();
    expect(heartButtonController.state.heartButtonCarRentalState,
        HeartButtonCarRentalState.selected);
    await Future.delayed(const Duration(milliseconds: 100));
    heartButtonController.toggle();
    expect(heartButtonController.state.heartButtonCarRentalState,
        HeartButtonCarRentalState.unselected);
  });
}
