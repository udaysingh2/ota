import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/facilities_details_widget.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Icon Text Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(const FacilityDetailsView());

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(AnimatedSwitcher), findsOneWidget);
  });
}
