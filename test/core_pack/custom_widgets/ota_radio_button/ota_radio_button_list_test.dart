import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_option_list/ota_radio_option_list_bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_option_list/ota_radio_option_list_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_option_list/ota_radion_option_list.dart';

void main() {
  testWidgets(
    'ota radio list test',
    (WidgetTester tester) async {
      // given selected state
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OtaRadioButtonList(
              labelList: const ['object 1'],
              onPressed: (selectedItem) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("otaRadioButton")).first);
      await tester.pumpAndSettle();
    },
  );
  test("ota radio button list model", () {
    // check selected model test
    OtaRadioOptionListModel otaRadioOptionListModel =
        OtaRadioOptionListModel(
            selectedIndex: 4,
            otaRadioButtonController: OtaRadioButtonController());
    expect(otaRadioOptionListModel.selectedIndex, 4);

    expect(
        otaRadioOptionListModel
            .otaRadioButtonController?.state.otaRadioButtonState,
        OtaRadioButtonState.unselected);
  });
  group("Ota Radio Button Bloc", () {
    OtaRadioOptionListBloc otaRadioOptionListBloc = OtaRadioOptionListBloc();
    OtaRadioButtonController otaRadioButtonController =
        OtaRadioButtonController();
    test("Default emitter", () {
      expect(
          otaRadioOptionListBloc
              .state.otaRadioButtonController?.state.otaRadioButtonState,
          null);
    });
    test("set selected", () {
      otaRadioButtonController.setSelected();
      otaRadioOptionListBloc.setSelected(2, otaRadioButtonController);
      expect(
          otaRadioOptionListBloc.state.otaRadioButtonController != null, true);
    });
    test("select and unselect", () {
      otaRadioOptionListBloc.unSelect();
      expect(
          otaRadioOptionListBloc.state.otaRadioButtonController != null, true);
    });
  });
}
