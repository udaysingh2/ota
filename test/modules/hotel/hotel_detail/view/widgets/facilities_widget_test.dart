import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/facilities_widget.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Icon Text Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(const FacilityView(
      facilityList: {"key": "value"},
      facilityMain: {"key": "1"},
    ));

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Row), findsNWidgets(2));
    expect(find.byType(Container), findsNWidgets(2));
    // await tester.tap(find.byType(OtaNextButton));
    // await tester.pumpAndSettle();
  });
}
