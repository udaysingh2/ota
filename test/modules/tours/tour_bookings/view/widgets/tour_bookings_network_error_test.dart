import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/tour_bookings/view/widgets/tour_bookings_network_error.dart';
import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Tour Booking Network Error Test', (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(const TourBookingsNetworkErrorWidget(
      height: 500,
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsOneWidget);
    await tester.pump();
  });
}
