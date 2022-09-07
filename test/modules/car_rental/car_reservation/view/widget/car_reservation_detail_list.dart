import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_reservation/view/widgets/car_reservation_detail_list.dart';

void main() {
  group("Car Reservation Card Widget", () {
    testWidgets('Car Reservation Card Widget Test',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: CarReservationDetailList(
          noOfSeats: 2,
          noOfDoors: 2,
          noOfLargeBag: 2,
          gear: "",
          noOfSmallBag: 2,
        )),
      ));
      await tester.pumpAndSettle();
    });
  });
}
