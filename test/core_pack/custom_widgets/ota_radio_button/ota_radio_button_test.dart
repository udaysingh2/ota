import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_model.dart';

void main() {
  testWidgets(
    'ota radio button test',
    (WidgetTester tester) async {
      // given selected state
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: OtaRadioButton(
              textWidget: Text("data"),
              label: "test 1",
              isSelected: true,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      //given unseleceted state
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: OtaRadioButton(
              label: "test 1",
              isSelected: false,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    },
  );
  test("ota radio button model", () {
    // check selected model test
    OtaRadioButtonModel otaRadioButtonModel = OtaRadioButtonModel(
        otaRadioButtonState: OtaRadioButtonState.selected);
    expect(
        otaRadioButtonModel.otaRadioButtonState, OtaRadioButtonState.selected);

    // check unselected model test
    otaRadioButtonModel.otaRadioButtonState = OtaRadioButtonState.unselected;
    expect(otaRadioButtonModel.otaRadioButtonState,
        OtaRadioButtonState.unselected);
  });
  group("Ota Radio Button Controller", () {
    OtaRadioButtonController otaRadioButtonController =
        OtaRadioButtonController();
    test("Default emitter", () {
      expect(otaRadioButtonController.state.otaRadioButtonState,
          OtaRadioButtonState.unselected);
    });
    test("set selected emitter", () {
      otaRadioButtonController.setSelected();
      otaRadioButtonController.getState();
      expect(otaRadioButtonController.state.otaRadioButtonState,
          OtaRadioButtonState.selected);
    });
    test("set unselected emitter", () {
      otaRadioButtonController.setUnSelected();
      otaRadioButtonController.getState();
      expect(otaRadioButtonController.state.otaRadioButtonState,
          OtaRadioButtonState.unselected);
    });
  });
}
