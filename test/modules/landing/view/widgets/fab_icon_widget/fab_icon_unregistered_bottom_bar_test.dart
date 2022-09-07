import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/landing/view/widgets/fab_icon_widget/fab_bottom_bar_unregistered_user.dart';

void main() {
  testWidgets(
    'FAB icon unregistered case',
    (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: OtaFabIconUnregistered(),
        ),
      ));
      await tester.pump();
      expect(find.byType(OtaFabIconUnregistered), findsOneWidget);
    },
  );
}
