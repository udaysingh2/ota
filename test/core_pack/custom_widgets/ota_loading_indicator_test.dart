import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_loading_indicator.dart';

void main() {
  testWidgets(
    'OTA Loading Indicator test',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: OTALoadingIndicator(),
        ),
      ));
      await tester.pump();
    },
  );
}
