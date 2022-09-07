import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/heart_button/heart_button_controller.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/heart_button/heart_button_model.dart';

void main() {
  test('Heart Button Controller Test', () async {
    // Build our app and trigger a frame.
    HeartButtonController heartButtonController = HeartButtonController();
    expect(heartButtonController.state.heartButtonState,
        HeartButtonState.disabled);
    await Future.delayed(const Duration(milliseconds: 100));
    heartButtonController.setSelected();
    await Future.delayed(const Duration(milliseconds: 100));
    expect(heartButtonController.state.heartButtonState,
        HeartButtonState.selected);
    heartButtonController.setUnselected();
    await Future.delayed(const Duration(milliseconds: 100));
    expect(heartButtonController.state.heartButtonState,
        HeartButtonState.unselected);
    heartButtonController.setDisabled();
    await Future.delayed(const Duration(milliseconds: 100));
    expect(heartButtonController.state.heartButtonState,
        HeartButtonState.disabled);
    expect(heartButtonController.getState(), HeartButtonState.disabled);
    await Future.delayed(const Duration(milliseconds: 100));
    heartButtonController.toggle();
    expect(heartButtonController.state.heartButtonState,
        HeartButtonState.selected);
    await Future.delayed(const Duration(milliseconds: 100));
    heartButtonController.toggle();
    expect(heartButtonController.state.heartButtonState,
        HeartButtonState.unselected);
  });
}
