import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/tours/details/data_sources/tours_details_remote_data_source.dart';
import 'package:ota/domain/tours/details/repositories/tours_details_repository_impl.dart';
import 'package:ota/modules/tours/ota_bookings/booking_calendar/view_model/tour_booking_calendar_argument.dart';

import '../../../../helper.dart';
import '../../../../mocks/fixture_reader.dart';
import '../../../hotel/repositories/Internet_failure_mock.dart';
import '../../../hotel/repositories/Internet_success_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  Map<String, dynamic> fullData =
      json.decode(fixture("tour/tour_with_complete_data_mock.json"));
  Map<String, dynamic> tourData =
      json.decode(fixture("tour/tour_details_mock.json"));
  Map<String, dynamic> noPackageData =
      json.decode(fixture("tour/tour_with_no_packjage.json"));
  TourBookingCalendarArgument otaBookingCalendarArgument =
      TourBookingCalendarArgument(
          rateKey: "TUEyMTEwMDAwMzcz",
          currency: "THB",
          packageName: "packageName",
          childPrice: 123.00,
          adultPrice: 222.00,
          cityId: "MA05110041",
          countryId: "MA05110001",
          selectedDate: DateTime.now(),
          serviceType: ServiceType.tour,
          tourTicketId: "MA2110000413",
          serviceId: "MA21110100",
          zoneId: "MA21110009",
          refCode: "CL213",
          minimumSeats: 3,
          availableSeats: 10,
          startTime: "10:00",
          timeOfDay: "AM",
          serviceCategory: "SIC");

  group("OTA Booking calendar Screen", () {
    testWidgets('OTA Booking calendar Screen with full data',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        ToursDetailsRepositoryImpl.setMockInternet(InternetSuccessMock());
        TourDetailsRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: fullData));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.otaBookingCalenderScreen,
          otaBookingCalendarArgument,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(OtaTextButton).first);
      });
    });

    testWidgets('OTA Booking calendar Screen with no package',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        ToursDetailsRepositoryImpl.setMockInternet(InternetSuccessMock());
        TourDetailsRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: noPackageData));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.otaBookingCalenderScreen,
          otaBookingCalendarArgument,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
      });
    });

    testWidgets('OTA Booking calendar Screen with Failure state',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        ToursDetailsRepositoryImpl.setMockInternet(InternetSuccessMock());
        TourDetailsRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(exception: OperationException()));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.otaBookingCalenderScreen,
          otaBookingCalendarArgument,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
      });
    });

    testWidgets('OTA Booking calendar Screen with Internet Failure state',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        ToursDetailsRepositoryImpl.setMockInternet(InternetFailureMock());
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.otaBookingCalenderScreen,
          otaBookingCalendarArgument,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
      });
    });
  });
  group("OTA Booking calendar Screen", () {
    testWidgets('OTA Booking calendar Screen with tourData data',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        ToursDetailsRepositoryImpl.setMockInternet(InternetSuccessMock());
        TourDetailsRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: tourData));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.otaBookingCalenderScreen,
          otaBookingCalendarArgument,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(OtaTextButton).first);
      });
    });
    testWidgets('OTA Booking calendar Screen with complete data',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        ToursDetailsRepositoryImpl.setMockInternet(InternetSuccessMock());
        TourDetailsRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: fullData));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.otaBookingCalenderScreen,
          otaBookingCalendarArgument,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        // await tester.drag(find.byType(ListView), const Offset(0.0, -300));
        await tester.pump();
        // await tester
        //     .tap(find.byKey(Key(ButtonType.plusButton.toString())).last);
        await tester.pumpAndSettle();
      });
    });
  });
}
