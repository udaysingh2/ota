import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/heart_button/heart_button_model.dart';

void main() {
  test('Heart Button Model Test', () async {
    // Build our app and trigger a frame.
    HeartButtonModel heartButtonController = HeartButtonModel();
    expect(heartButtonController.heartButtonState, HeartButtonState.disabled);
    await Future.delayed(const Duration(milliseconds: 100));
    heartButtonController.heartButtonState = HeartButtonState.selected;
    expect(heartButtonController.heartButtonState, HeartButtonState.selected);
  });
}
