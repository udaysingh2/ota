import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_supplier/view/widgets/car_supplier_card_widget.dart';

void main() {
  group("Car Supplier Card Widget", () {
    testWidgets('Car Supplier Card Widget Test', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
            body: CarSupplierCardWidget(
          supplierName: '',
          totalPrice: 1999.0,
          gear: 'A',
          smallBags: '2',
          perDayPrice: 899,
          doors: '4',
          largeBags: '1',
          seats: '4',
          imageUrl:
              'https://trbhmanage.travflex.com/imagedata/Car/800/vios-2-1.jpg',
          returnLocation: 'Bangkok',
          pickupLocation: 'BangKok',
          returnExtraCharge: '500.00',
        )),
      ));
      await tester.pumpAndSettle();
    });
  });
}
