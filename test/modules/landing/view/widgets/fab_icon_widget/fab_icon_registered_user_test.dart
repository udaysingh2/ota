import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ota/modules/landing/view/widgets/fab_icon_widget/fab_icon_registered_user.dart';

void main() {
  testWidgets(
    'FAB icon registered case',
    (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: OtaFabIcon(),
        ),
      ));
      await tester.pump();
      expect(find.byType(OtaFabIcon), findsOneWidget);
    },
  );
}
