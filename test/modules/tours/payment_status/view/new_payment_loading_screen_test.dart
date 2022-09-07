import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/payment_status/data_sources/payment_status_remote_data_source.dart';
import 'package:ota/domain/payment_status/data_sources/payment_status_remote_sata_source_mock.dart';
import 'package:ota/domain/payment_status/repositories/payment_status_repository_impl.dart';
import 'package:ota/modules/payment_method/view_model/payment_initiate_argument_model.dart';

import '../../../../helper.dart';
import '../../../hotel/repositories/internet_failure_mock.dart';
import '../../../hotel/repositories/internet_success_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late OtaCountDownController otaCountDownController;

  group("New Payment Loading Screen", () {
    setUp(() {
      debugPrint("setup payment loading");
      HttpOverrides.global = null;
      otaCountDownController =
          OtaCountDownController(durationInSecond: 2, onComplete: () {});
    });
    tearDown(() {
      debugPrint("tear down payment loading");
      otaCountDownController.dispose();
    });
    testWidgets('New Payment Loading Screen test', (WidgetTester tester) async {
      await tester.runAsync(() async {
        PaymentStatusRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result: getMockDataWithString(PaymentStatusMockDataSourceImpl
                .getMockDataForNewBookingUrn())));
        PaymentStatusRepositoryImpl.setMockInternet(InternetSuccessMock());

        PaymentStatusRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result: getMockDataWithString(
                PaymentStatusMockDataSourceImpl.getMockData())));
        PaymentStatusRepositoryImpl.setMockInternet(InternetSuccessMock());

        PaymentStatusRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result: getMockDataWithString(PaymentStatusMockDataSourceImpl
                .getMockDataForPaymentStatus())));
        PaymentStatusRepositoryImpl.setMockInternet(InternetSuccessMock());
        Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.newPaymentLoadingScreen,
          _getArgument(
            otaCountDownController,
          ),
        );

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await Future.delayed(Duration.zero);
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
      });
    });
  });

  group("New Payment Loading Screen with failure", () {
    setUp(() {
      debugPrint("setup payment loading");
      HttpOverrides.global = null;
      otaCountDownController =
          OtaCountDownController(durationInSecond: 2, onComplete: () {});
    });
    tearDown(() {
      debugPrint("tear down payment loading");
      otaCountDownController.dispose();
    });
    testWidgets('New Payment Loading Screen test', (WidgetTester tester) async {
      await tester.runAsync(() async {
        PaymentStatusRepositoryImpl.setMockInternet(InternetFailureMock());
        Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.newPaymentLoadingScreen,
          _getArgument1(
            otaCountDownController,
          ),
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
      });
    });
  });
}

PaymentMethodInitiateArgument _getArgument(
    OtaCountDownController otaCountDownController) {
  return PaymentMethodInitiateArgument(
    otaCountDownController: otaCountDownController,
    bookingUrn: "TR220302-AA-0005",
    currency: "TBH",
    newbookingUrn: "TR220302-AA-0007",
    paymentDetails: [
      PaymentMethodTypeArgument(
        paymentMethod: "paymentMethod",
        price: 100.0,
        paymentType: "paymentType",
        paymentMethodId: "paymentMethodId",
        cardRef: "cardRef",
        cardType: "VISA",
      )
    ],
  );
}

PaymentMethodInitiateArgument _getArgument1(
    OtaCountDownController otaCountDownController) {
  return PaymentMethodInitiateArgument(
    otaCountDownController: otaCountDownController,
    bookingUrn: "TR220302-AA-0005",
    currency: "TBH",
    newbookingUrn: "",
    paymentDetails: [
      PaymentMethodTypeArgument(
        paymentMethod: "paymentMethod",
        price: 100.0,
        paymentType: "paymentType",
        paymentMethodId: "paymentMethodId",
        cardRef: "cardRef",
        cardType: "VISA",
      )
    ],
  );
}
