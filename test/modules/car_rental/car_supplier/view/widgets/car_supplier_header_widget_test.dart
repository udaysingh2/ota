import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_supplier/view/widgets/car_supplier_header_widget.dart';

void main() {
  group("Car Supplier header Card Widget", () {
    testWidgets('Car Supplier header Card Widget Test',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
          home: Scaffold(
              body: CarSupplierHeaderWidget(
        imageUrl: "",
        craftType: "",
        brandName: "",
        amenitiesList: [],
        carName: "",
      ))));
      await tester.pumpAndSettle();
    });
  });
}
