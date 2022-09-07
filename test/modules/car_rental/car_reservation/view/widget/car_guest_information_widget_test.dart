import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_reservation/view/widgets/car_guest_information_widget.dart';

void main() {
  group("Car Guest  Widget", () {
    testWidgets('Car Guest  Widget Test', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
            body: CarGuestInformationFieldWidget(
          key: Key(""),
          headerText: '',
          isBookForSomeoneElse: true,
          firstName: '',
          phoneNumber: '',
          isDriverDetail: true,
          isWarningEnabled: true,
          subheadText: "",
          warningText: "",
          lastName: "",
        )),
      ));
      await tester.pumpAndSettle();
    });
    testWidgets('Car Guest  Widget Test', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
            body: CarGuestInformationFieldWidget(
          headerText: '',
          isBookForSomeoneElse: false,
          firstName: '',
          phoneNumber: '',
          isDriverDetail: false,
          isWarningEnabled: false,
          subheadText: "",
          warningText: "",
          lastName: "",
        )),
      ));
      await tester.pumpAndSettle();
    });
  });
}
