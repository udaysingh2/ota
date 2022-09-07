import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_reservation/view/widgets/car_reservation_info.dart';

void main() {
  group("Car Reservation Card Widget", () {
    testWidgets('Car Reservation Card Widget Test',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
            body: CarReservationInfo(
          subHeaderText: "",
          logo: "",
          headerText: "",
          imageUrl:
              'https://trbhmanage.travflex.com/imagedata/Car/800/vios-2-1.jpg',
        )),
      ));
      await tester.pumpAndSettle();
    });
  });
}
