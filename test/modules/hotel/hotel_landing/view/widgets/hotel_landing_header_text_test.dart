import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_landing/view/widgets/hotel_landing_header_text.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('hotel landing header text ...', (tester) async {
    Widget widget = getMaterialWrapper(const HotelLandingHeaderText(
      text: 't',
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await tester.pump();
  });
}
