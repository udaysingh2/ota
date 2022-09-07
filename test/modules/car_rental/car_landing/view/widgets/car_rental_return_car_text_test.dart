import 'package:flutter_test/flutter_test.dart';

import 'package:ota/modules/car_rental/car_landing/view/widgets/car_rental_return_car_text.dart';

import '../../../../../helper.dart';

void main() {
  testWidgets('Car Rental Return Text Widget Test',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(getMaterialWrapper(const CarRentalReturnCarText('')));

    await tester.pumpAndSettle();
  });
}
