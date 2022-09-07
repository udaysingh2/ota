import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_landing/view/widgets/ota_switch_button.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Ota Switch', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OtaSwitchButton(
            onTap: () {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OtaSwitchButton(
            onTap: () {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  });
}
