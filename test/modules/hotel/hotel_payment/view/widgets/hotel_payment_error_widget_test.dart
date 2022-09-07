import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_payment/view/widgets/hotel_payment_error_widget.dart';

void main() {
  testWidgets('Hotel Payment Error widget test ...', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HotelPaymentErrorWidget(
            height: 800,
            onRefresh: () async {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  });
}
