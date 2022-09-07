import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/confirm_booking/data_sources/hotel_confirm_booking_mock.dart';
import 'package:ota/domain/confirm_booking/data_sources/hotel_confirm_booking_remote_data_source.dart';
import 'package:ota/domain/confirm_booking/repositories/hotel_confirm_booking_repository_impl.dart';
import 'package:ota/domain/hotel/hotel_addon_service/data_sources/hotel_service_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_addon_service/data_sources/hotel_service_remote_mock.dart';
import 'package:ota/domain/hotel/hotel_addon_service/repositories/hotel_service_repository_impl.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/hotel_payment_main_argument_model.dart';

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
  testWidgets('Hotel Payment Error widget test ...', (tester) async {
    OtaCountDownController.setAsMock();
    HotelConfirmBookingRepositoryImpl.setMockInternet(
        InternetConnectionInfoMocked());
    HotelServiceRepositoryImpl.setMockInternet(InternetConnectionInfoMocked());

    Map<String, dynamic> map =
        jsonDecode(HotelConfirmBookingMockDataSourceImpl.getMockData());
    Map<String, dynamic> result = {"BookingConfirmation": map};
    HotelConfirmBookingRemoteDataSourceImpl.setMock(GraphQlResponseMock(
      result: result,
    ));
    printDebug(result);
    HotelServiceRemoteDataSourceImpl.setMock(GraphQlResponseMock(
      result: jsonDecode(HotelServicelMockDataSourceImpl.getMockData()),
    ));

    Widget widget = getWidgetPressButtonWithProvider(
      AppRoutes.hotelPaymentMainScreen,
      _getArgument(),
    );

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await tester.tap(find.text("press"));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(Duration(seconds: _kTestDelayTimer));
    await tester.tap(find.byKey(const Key("hotelPaymentMinMaxKey")));
    await tester.pumpAndSettle(Duration(seconds: _kTestDelayTimer));
    await tester.tap(find.byKey(const Key("BookNowButton")));
    await tester.pumpAndSettle(Duration(seconds: _kTestDelayTimer));
  });

  testWidgets('Hotel Payment Error widget test ...', (tester) async {
    OtaCountDownController.setAsMock();
    HotelConfirmBookingRepositoryImpl.setMockInternet(
        InternetConnectionInfoMockedFalse());
    HotelServiceRepositoryImpl.setMockInternet(
        InternetConnectionInfoMockedFalse());

    Map<String, dynamic> map =
        jsonDecode(HotelConfirmBookingMockDataSourceImpl.getMockData());
    Map<String, dynamic> result = {"BookingConfirmation": map};
    HotelConfirmBookingRemoteDataSourceImpl.setMock(GraphQlResponseMock(
      result: result,
    ));
    printDebug(result);
    HotelServiceRemoteDataSourceImpl.setMock(GraphQlResponseMock(
      result: jsonDecode(HotelServicelMockDataSourceImpl.getMockData()),
    ));

    Widget widget = getWidgetPressButtonWithProvider(
      AppRoutes.hotelPaymentMainScreen,
      _getArgument(),
    );

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await tester.tap(find.text("press"));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(Duration(seconds: _kTestDelayTimer));
  });
}

HotelPaymentMainArgumentModel _getArgument() {
  return HotelPaymentMainArgumentModel(
    bookingUrn: "url",
    roomCode: "123",
    hotelId: "123",
    additionalNeedsText: "123",
    membershipId: "123",
    firstGuestName: "sadas",
    secondGuestName: "asda",
    firstName: "adf",
    lastName: "asdf",
    freefoodDelivery: false,
    addonsModels: [
      HotelPaymentAddonsModel(
        imageUrl: "asd",
        description: "asd",
        serviceName: "Asd",
        cost: "123",
        uniqueId: "123",
        selectedDate: DateTime.now(),
        quantity: "12",
        isFlightRequired: true,
      )
    ],
    totalCost: "13",
    otaCountDownController: OtaCountDownController(durationInSecond: 5),
  );
}
