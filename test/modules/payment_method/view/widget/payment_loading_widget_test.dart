import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/payment_method/view/widgets/payment_loading_widget.dart';

void main() {
  testWidgets('Payment loading Widget Test ...', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PaymentLoadingScreenWidget(),
        ),
      ),
    );
  });
}
