import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_chip_button/ota_chip_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/insurance/data_source/insurance_data_source.dart';
import 'package:ota/domain/insurance/data_source/insurance_mock_data_source.dart';
import 'package:ota/domain/insurance/repositories/insurance_repository.dart';
import 'package:ota/modules/insurance/view/widgets/insurance_list_widget.dart';
import '../../../helper.dart';
import '../../hotel/repositories/internet_failure_mock.dart';
import '../../hotel/repositories/internet_success_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);

  group("Promo Detail Screen", () {
    testWidgets('Insuarance Landing Screen', (WidgetTester tester) async {
      await tester.runAsync(() async {
        InsuranceRepositoryImpl.setMockInternet(InternetSuccessMock());
        InsuranceRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result: json.decode(InsuranceMockDataSourceImpl.getMockData())));
        Widget widget = getMaterialWrapperWithPressButton(
            AppRoutes.insuranceLandingScreen, null);
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(InsuranceListWidget).first);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(OtaTextButton).last);
        await tester.pumpAndSettle();
      });
    });
    testWidgets('Insuarance Landing Screen', (WidgetTester tester) async {
      await tester.runAsync(() async {
        InsuranceRepositoryImpl.setMockInternet(InternetSuccessMock());
        InsuranceRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result:
                json.decode(InsuranceMockDataSourceImpl.getMockData1899())));
        Widget widget = getMaterialWrapperWithPressButton(
            AppRoutes.insuranceLandingScreen, null);
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
        InsuranceRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result:
                json.decode(InsuranceMockDataSourceImpl.getMockData1999())));
        Widget widget = getMaterialWrapperWithPressButton(
            AppRoutes.insuranceLandingScreen, null);
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
        InsuranceRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result: json.decode(InsuranceMockDataSourceImpl.getEmptyList())));
        Widget widget = getMaterialWrapperWithPressButton(
            AppRoutes.insuranceLandingScreen, null);
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
      });
    });
    testWidgets('Insuarance Landing Screen', (WidgetTester tester) async {
      await tester.runAsync(() async {
        InsuranceRepositoryImpl.setMockInternet(InternetFailureMock());

        Widget widget = getMaterialWrapperWithPressButton(
            AppRoutes.insuranceLandingScreen, null);
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(OtaChipButton));
        await tester.pumpAndSettle();
      });
    });
    testWidgets('Insuarance Landing Screen guest user',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        InsuranceRepositoryImpl.setMockInternet(InternetSuccessMock());
        InsuranceRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result: json.decode(InsuranceMockDataSourceImpl.getMockData())));
        Widget widget = getMaterialWrapperWithPressButton(
            AppRoutes.insuranceLandingScreen, null);
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(InsuranceListWidget).first);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(OtaTextButton).last);
        await tester.pumpAndSettle();
      });
    });
  });
}
