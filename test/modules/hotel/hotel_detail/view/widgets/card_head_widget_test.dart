import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/card_head_widget.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Card Header Item Count Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(const CardHeadCalender(
      sectionTwoFooter: "test",
      sectionThreeFooter: "test",
      sectionFourFooter: "test",
      sectionOneFooter: "test",
      sectionOneHeader: "test",
      sectionFourHeader: "test",
      sectionThreeHeader: "test",
      sectionTwoHeader: "test",
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.text("test"), findsNWidgets(8));
  });

  testWidgets('Card Header Item  Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(const CardHeadCalender(
      sectionTwoFooter: "test1",
      sectionThreeFooter: "test2",
      sectionFourFooter: "test3",
      sectionOneFooter: "test4",
      sectionOneHeader: "test5",
      sectionFourHeader: "test6",
      sectionThreeHeader: "test7",
      sectionTwoHeader: "test8",
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.text("test1"), findsOneWidget);
    expect(find.text("test2"), findsOneWidget);
    expect(find.text("test3"), findsOneWidget);
    expect(find.text("test4"), findsOneWidget);
    expect(find.text("test5"), findsOneWidget);
    expect(find.text("test6"), findsOneWidget);
    expect(find.text("test7"), findsOneWidget);
    expect(find.text("test8"), findsOneWidget);
  });
}
