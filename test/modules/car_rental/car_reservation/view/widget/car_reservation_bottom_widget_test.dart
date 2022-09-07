import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_reservation/view/widgets/car_reservation_bottom_widget.dart';

void main() {
  group("Car Reservation Card Widget", () {
    testWidgets('Car Reservation Card Widget Test',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
            body: CarReservationBottomWidget(
          pricePerDay: 2,
          isWarningVisible: true,
          pickupLocation: 'Bangkok',
          dropLocation: 'Don Muang',
          returnExtraCharge: 200,
        )),
      ));
      await tester.pumpAndSettle();
    });
  });
}
