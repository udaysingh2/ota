import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_landing/view/widgets/hotel_landing_app_bar.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Hotel Landing App Bar Test...', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(HotelLandingAppBar(
      child: Container(),
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await tester.pump();
  });
}
