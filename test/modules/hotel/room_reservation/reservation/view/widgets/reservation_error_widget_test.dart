import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view/widgets/reservation_error_widget.dart';

void main() {
  testWidgets('Reservation Error widget test ...', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ReservationErrorWidget(
            height: 800,
            onRefresh: () async {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  });
}
