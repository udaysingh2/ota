import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/landing/view/widgets/popup_widget/popup_controller.dart';
import 'package:ota/modules/landing/view/widgets/popup_widget/popup_model.dart';

void main() {
  test('Popup Controller Test', () async {
    // Build our app and trigger a frame.
    PopupController popupController = PopupController();
    expect(popupController.state, PopupModelState.initial);
    await Future.delayed(const Duration(milliseconds: 100));
    popupController.setAsLoaded();
    await Future.delayed(const Duration(milliseconds: 100));
    expect(popupController.state, PopupModelState.loaded);
    await Future.delayed(const Duration(milliseconds: 100));
    expect(popupController.isLoaded(), true);
    popupController.setAsClosed();
  });
}
