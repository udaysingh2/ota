import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_landing/view/widgets/car_landing_no_internet_widget.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Car Landing Error Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(getMaterialWrapper(const CarLandingErrorWidget(
      height: 300,
      key: Key(""),
    )));

    await tester.pumpAndSettle();
  });
}
