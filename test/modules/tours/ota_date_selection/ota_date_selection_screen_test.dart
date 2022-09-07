import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/modules/tours/ota_date_selection/view/ota_date_selection_screen.dart';

import '../../../helper/material_wrapper.dart';

void main() {
  DateTime argument = DateTime.now().add(const Duration(days: 1));
  testWidgets('ota date selection screen  test', (WidgetTester tester) async {
    Widget widget = getMaterialWrapperWithArguments(
      const OtaDateSelectionScreen(),
      AppRoutes.otaDateSelectionScreen,
      argument,
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
