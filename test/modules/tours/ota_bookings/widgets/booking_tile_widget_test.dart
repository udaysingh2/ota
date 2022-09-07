import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/ota_bookings/booking_calendar/widgets/booking_tile_widget.dart';

import '../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Booking tile test', (tester) async {
    Widget widget = getMaterialWrapper(const BookingTileWidget(
      currency: "TBH",
      price: 123.00,
      title: "Title",
      ageRange: "ageRange",
      childAgeList: [1, 12],
      maxValue: 100,
      minValue: 0,
      postTitle: "postTitle",
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
