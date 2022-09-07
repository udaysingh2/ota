import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/heart_button/heart_button.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/heart_button/heart_button_controller.dart';

import '../../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Heart Button Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    HeartButtonController heartButtonController = HeartButtonController();
    Widget widget = getMaterialWrapper(
      HeartButton(
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
