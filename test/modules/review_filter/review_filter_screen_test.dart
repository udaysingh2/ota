import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/drop_down_menu_widget.dart';
import 'package:ota/modules/review_filter/view/widget/review_filter_screen.dart';

void main() {
  testWidgets(
    'Review Filter Screen',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ReviewFilterScreen(),
          ),
        ),
      );

      await tester.pump();
      expect(find.byType(DropDownMenuButton), findsWidgets);
      await tester.tap(find.byType(DropDownMenuButton).last);
      await tester.pumpAndSettle();
    },
  );
}
