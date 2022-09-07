import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/tour_bookings/view/widgets/tour_booking_no_result.dart';
import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Tour Booking No Result Test', (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(const TourBookingNoResultWithRefresh(
      height: 500,
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsOneWidget);
    await tester.pump();
  });
}
