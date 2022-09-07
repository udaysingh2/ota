import 'package:flutter_test/flutter_test.dart';

import 'package:ota/modules/car_rental/car_landing/view/widgets/car_landing_location_box.dart';
import '../../../../../helper.dart';

void main() {
  testWidgets('Car Landing Location Box Widget Test',
      (WidgetTester tester) async {
    await tester.pumpWidget(getMaterialWrapper(CarLandingLocationBox(
      headerText: '',
      onTap: () {},
      placeholderText: '',
    )));

    await tester.pumpAndSettle();
  });
}
