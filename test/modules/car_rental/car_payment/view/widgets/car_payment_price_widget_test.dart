import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_payment/view/widgets/car_payment_price_widget.dart';

void main() {
  group("Car payment header Card Widget", () {
    testWidgets('Car payment header Card Widget Test',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: CarPaymentPriceWidget(
        totalPrice: 2.0,
        isRightAlign: true,
        percentageDiscount: 20,
        priceBeforeDiscount: 120,
      ))));
      await tester.pumpAndSettle();
    });
    testWidgets('Car payment header Card Widget Test',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: CarPaymentPriceWidget(
        totalPrice: 2.0,
        isRightAlign: false,
        percentageDiscount: 20,
        priceBeforeDiscount: 120,
      ))));
      await tester.pumpAndSettle();
    });
  });
}
