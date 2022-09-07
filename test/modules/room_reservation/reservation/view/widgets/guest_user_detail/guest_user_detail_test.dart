import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_next_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_model.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view/widgets/guest_user_detail/guest_user_detail_controller.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view/widgets/guest_user_detail/guest_user_detail_widget.dart';

void main() {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  GuestUserDetailController guestUserDetailController =
      GuestUserDetailController();
  guestUserDetailController.state.otaRadioButtonBloc!.state
      .otaRadioButtonState = OtaRadioButtonState.selected;
  testWidgets("Recommendation Tile", (WidgetTester tester) async {
    Widget widget = MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            OtaNextButton(
              key: const Key("guestDetailWidgetTest"),
              onPress: () {
                guestUserDetailController.isReservingForSomeoneElse();
                guestUserDetailController.isValidationSuccess();
              },
            ),
            GuestUserDetailWidget(
              guestFirstName: FocusNode(),
              guestLastName: FocusNode(),
              firstNameController: firstNameController,
              lastNameController: lastNameController,
              guestUserDetailController: guestUserDetailController,
              onRadioBtnClicked: () {},
            ),
          ],
        ),
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.tap(find.byKey(
      const Key("guestDetailWidgetTest"),
    ));
    await tester.pump();
    await tester.tap(
      find.byType(OtaRadioButton),
    );
    await tester.pump();
    guestUserDetailController.state.otaRadioButtonBloc!.state
        .otaRadioButtonState = OtaRadioButtonState.unselected;
    await tester.tap(
      find.byType(OtaRadioButton),
    );
    await tester.pump();
    firstNameController.text = "abc";
    lastNameController.text = "abc";
    guestUserDetailController.state.otaRadioButtonBloc!.state
        .otaRadioButtonState = OtaRadioButtonState.selected;
    await tester.pump();
    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.tap(find.byKey(
      const Key("guestDetailWidgetTest"),
    ));
    await tester.pump();
  });
}
