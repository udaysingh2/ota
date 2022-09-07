import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_detail/view/widget/car_detail_heart_button.dart';
import 'package:ota/modules/car_rental/car_detail/view/widget/heart_button_car_rental_controller.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Heart Button Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    HeartButtonCarRentalController heartButtonController =
        HeartButtonCarRentalController();
    Widget widget = getMaterialWrapper(
      CarDetailHeartButton(
        heartButtonController: heartButtonController,
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    heartButtonController.setUnselected();
    await tester.pumpAndSettle();
    heartButtonController.setSelected();
    await tester.pumpAndSettle();
  });
}
