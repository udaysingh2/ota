import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/ota_common/view/ota_no_result_booking_list.dart';
import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Car Booking No Result Test', (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(
      const OtaBookingNoResult(
        errorMsg: 'errorMsg',
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await tester.pump();
  });
}
