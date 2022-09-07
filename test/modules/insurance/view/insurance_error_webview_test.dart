import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_chip_button/ota_chip_button.dart';
import 'package:ota/domain/insurance/repositories/insurance_repository.dart';
import '../../../helper.dart';
import '../../hotel/repositories/internet_success_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);

  testWidgets('Insuarance Landing Screen', (WidgetTester tester) async {
    await tester.runAsync(() async {
      InsuranceRepositoryImpl.setMockInternet(InternetSuccessMock());
      Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.insuranceErrorWebViewScreen, "1899");
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(OtaChipButton));
      await tester.pumpAndSettle();
    });
  });
  testWidgets('Insuarance Landing Screen', (WidgetTester tester) async {
    await tester.runAsync(() async {
      InsuranceRepositoryImpl.setMockInternet(InternetSuccessMock());
      Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.insuranceErrorWebViewScreen, "Error_Network");
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(OtaChipButton));
      await tester.pumpAndSettle();
    });
  });
}
