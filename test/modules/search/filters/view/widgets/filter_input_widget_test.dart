import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/search/filters/view/widgets/filter_input_widget.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Filter Input Widget", () {
    Widget widget = MaterialApp(
      home: Scaffold(
        body: FilterInputWidget(
          title: 'test',
          initialValue: 13,
          onAgreeClicked: (value) {},
          onClose: () {},
          hintText: 'Enter age',
          maxInputValueLimit: 15,
        ),
      ),
    );
    testWidgets('Filter Input Widget test', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(IconButton));
        await tester.tap(find.byType(InkWell));
      });
    });
    testWidgets('Filter Input Widget enter text', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField), '');
        await tester.enterText(find.byType(TextField), '12');
        await tester.pump(const Duration(milliseconds: 100));
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();
      });
    });
  });
}
