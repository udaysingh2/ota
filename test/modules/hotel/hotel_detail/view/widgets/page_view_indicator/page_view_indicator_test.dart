import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/page_view_indicator/page_view_indicator.dart';

import '../../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Page View Indicator Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    const pageCount = 3;
    PageController pageController = PageController();
    Widget widget = getMaterialWrapper(
      PageViewIndicator(
        pageCount: pageCount,
        controller: pageController,
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(AnimatedContainer), findsNWidgets(pageCount));
  });
}
