import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view/widgets/booking_details_location_widget.dart';

import '../../../../../helper.dart';

const String _kLeadingOptionsKey = 'Leading_options_key';
const String _kTrailingOptionOptionsKey = 'Trailing_options_key';

void main() {
  testWidgets("booking details location widget test no phone number",
      (tester) async {
    Widget widget = getMaterialWrapper(
      const BookingDetailLocationWidget(
        longitude: 2,
        phoneNumber: "",
        latitude: 2,
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key(_kTrailingOptionOptionsKey)).first);
    await tester.pump();
  });

  testWidgets("booking details location widget test with phone number",
      (tester) async {
    Widget widget = getMaterialWrapper(
      const BookingDetailLocationWidget(
        longitude: 2,
        phoneNumber: "12345",
        latitude: 2,
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key(_kLeadingOptionsKey)).first);
    await tester.pump();
  });
}
