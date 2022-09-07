import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_add_on_service_card.dart';

void main() {
  testWidgets('OTA Add on service card Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: OtaAddOnServiceCard(
            currency: '',
            hotelServiceName: 'hotel name 1',
            imageUrl: '',
            price: 200,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: OtaAddOnServiceCard(
            currency: '',
            hotelServiceName: 'hotel name 2',
            imageUrl: 'assets/images/icons/suggetion_card_palceholder.svg',
            price: 350,
            isInHorizonalScroll: false,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  });
}
