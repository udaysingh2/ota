import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/car_rental/car_payment/data_source/car_payment_mock_data_source.dart';
import 'package:ota/domain/car_rental/car_payment/data_source/car_payment_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_payment/repositories/car_payment_repository_impl.dart';
import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_view_model.dart';
import 'package:ota/modules/car_rental/car_payment/view_model/car_payment_argument_view_model.dart';

import '../../../../helper.dart';

int _kTestDelayTimer = 10;

class InternetConnectionInfoMocked extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(true);
}

class InternetConnectionInfoMockedFalse extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(false);
}

void main() {
  testWidgets('Car Payment widget test ...', (tester) async {
    OtaCountDownController.setAsMock();
    CarPaymentRepositoryImpl.setMockInternet(InternetConnectionInfoMocked());

    Map<String, dynamic> map =
        jsonDecode(CarPaymentMockDataSourceImpl.getMockData());
    Map<String, dynamic> result = {
      "saveCarBookingConfirmationDetails":
          map['saveCarBookingConfirmationDetails']
    };
    CarPaymentRemoteDataSourceImpl.setMock(GraphQlResponseMock(
      result: result,
    ));
    printDebug(result);

    Widget widget = getWidgetPressButtonWithProvider(
      AppRoutes.carPaymentMainScreen,
      _getArgument(),
    );

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await tester.tap(find.text("press"));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(Duration(seconds: _kTestDelayTimer));
    await tester.tap(find.byKey(const Key('BookNowButton')).first);
    await tester.pumpAndSettle(Duration(seconds: _kTestDelayTimer));
  });

  testWidgets('Car Payment Error widget test ...', (tester) async {
    OtaCountDownController.setAsMock();
    CarPaymentRepositoryImpl.setMockInternet(InternetConnectionInfoMocked());

    Map<String, dynamic> map =
        jsonDecode(CarPaymentMockDataSourceImpl.getMockData());
    Map<String, dynamic> result = {"saveCarBookingConfirmationDetails": map};
    CarPaymentRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(exception: OperationException()));
    printDebug(result);

    Widget widget = getWidgetPressButtonWithProvider(
      AppRoutes.carPaymentMainScreen,
      _getArgument(),
    );

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await tester.tap(find.text("press"));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(Duration(seconds: _kTestDelayTimer));
  });
}

CarPaymentArgumentModel _getArgument() {
  return CarPaymentArgumentModel(
    totalPrice: 1.0,
    bookingUrn: "url",
    otaCountDownController: OtaCountDownController(durationInSecond: 5),
    carDetailInfoDataViewModel: CarInfoDataViewModel(
      carDetailsPickUp: [],
      pricing: CarDetailInfoPricing(totalCost: '1000', costPerDay: '499'),
      carDetails: [
        CarDetailInfoCell(
            title: 'Title1', imagePath: '', subTitle: 'Subtitle1'),
      ],
      facilities: [],
      carInfo: CarDetailInfoCarMainData(title: 'Title3', imagePath: ''),
      carDetailsDropOff: [
        CarDetailInfoCell(
            title: 'Title2', imagePath: '', subTitle: 'Subtitle2'),
      ],
    ),
  );
}
