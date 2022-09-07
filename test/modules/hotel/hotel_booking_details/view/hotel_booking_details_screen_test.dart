import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/hotel/hotel_booking_details/data_sources/hotel_booking_detail_mock.dart';
import 'package:ota/domain/hotel/hotel_booking_details/data_sources/hotel_booking_details_remote_data_source.dart';
import 'package:ota/domain/message_and_notification/repository/message_and_notification_repository.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view_model/hotel_booking_detail_argument.dart';

import '../../repositories/internet_success_mock.dart';
import '../mock/hotel_activity_status_response.dart';

void main() {
  HotelBookingDetailArgument hotelBookingDetailArgument =
      HotelBookingDetailArgument(
    bookingUrn: "bookingUrn",
    confirmationNo: "bookingUrn",
  );
  Widget widget = MaterialApp(
    routes: AppRoutes.getRoutes(),
    supportedLocales: [
      Locale(
        LanguageCodes.english.code,
        LanguageCodes.english.countryCode,
      ),
      Locale(
        LanguageCodes.thai.code,
        LanguageCodes.thai.countryCode,
      ),
    ],
    localizationsDelegates: const [
      Localization.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    theme: ThemeData(
      primarySwatch: Colors.purple,
      fontFamily: 'Kanit',
    ),
    localeResolutionCallback: (locale, supportedLocales) {
      return supportedLocales.elementAt(0);
    },
    home: Scaffold(
      body: Builder(builder: (context) {
        return TextButton(
          child: const Text("press"),
          onPressed: () => Navigator.pushNamed(
            context,
            AppRoutes.hotelBookingDetailScreen,
            arguments: hotelBookingDetailArgument,
          ),
        );
      }),
    ),
  );
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  Map<String, dynamic> map =
      jsonDecode(HotelBookingDetailMockDataSourceImpl.getMockData());
  Map<String, dynamic> activityStatusCheckedOut = jsonDecode(
      HotelDetailActivityStatusResponse.getDetailsActivityStatus("CHECKEDOUT"));
  Map<String, dynamic> hotelBookingDetailsDataActivityStatus = {
    "bookingDetailsV2": activityStatusCheckedOut
  };

  Map<String, dynamic> activityStatusUserCancelled = jsonDecode(
      HotelDetailActivityStatusResponse.getDetailsActivityStatus(
          "USER_CANCELLED"));
  Map<String, dynamic> hotelBookingDetailsActivityStatusUserCancelled = {
    "bookingDetailsV2": activityStatusUserCancelled
  };
  Map<String, dynamic> activityStatusPaymentFailed = jsonDecode(
      HotelDetailActivityStatusResponse.getDetailsActivityStatus(
          "PAYMENT_FAILED"));
  Map<String, dynamic> hotelBookingDetailsActivityStatusPaymentFailed = {
    "bookingDetailsV2": activityStatusPaymentFailed
  };

  Map<String, dynamic> activityStatusHotelRejected = jsonDecode(
      HotelDetailActivityStatusResponse.getDetailsActivityStatus(
          "HOTEL_REJECTED"));
  Map<String, dynamic> hotelBookingDetailsActivityStatusHotelRejected = {
    "bookingDetailsV2": activityStatusHotelRejected
  };

  Map<String, dynamic> activityStatusPaymentPending = jsonDecode(
      HotelDetailActivityStatusResponse.getDetailsActivityStatus(
          "PAYMENT_PENDING"));
  Map<String, dynamic> hotelBookingDetailsActivityStatusPaymentPending = {
    "bookingDetailsV2": activityStatusPaymentPending
  };

  Map<String, dynamic> activityStatusAwatingCancellation = jsonDecode(
      HotelDetailActivityStatusResponse.getDetailsActivityStatus(
          "AWAITING_CANCELLATION"));
  Map<String, dynamic> hotelBookingDetailsActivityAwatingCancellation = {
    "bookingDetailsV2": activityStatusAwatingCancellation
  };

  Map<String, dynamic> activityStatusAwatingReservation = jsonDecode(
      HotelDetailActivityStatusResponse.getDetailsActivityStatus(
          "AWAITING_RESERVATION"));
  Map<String, dynamic> hotelBookingDetailsActivityAwatingReservation = {
    "bookingDetailsV2": activityStatusAwatingReservation
  };

  Map<String, dynamic> hotelBookingDetailsData = {"bookingDetailsV2": map};
  group("Hotel Booking Details Screen", () {
    MessageAndNotificationRepositoryImpl.setMockInternet(InternetSuccessMock());
    testWidgets('Notification Data', (WidgetTester tester) async {
      HotelBookingDetailRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(result: hotelBookingDetailsData),
      );

      await tester.runAsync(() async {
        await tester.pumpWidget(widget);
        await Future.delayed(const Duration(seconds: 3));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 3));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("ReserveAgainButton")));
      });
    });
    testWidgets(
        'Hotel Booking Details Screen => activity status == checked out',
        (WidgetTester tester) async {
      HotelBookingDetailRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(result: hotelBookingDetailsDataActivityStatus),
      );

      await tester.runAsync(() async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 3));
        await tester.pumpAndSettle();
      });
    });

    testWidgets(
        'Hotel Booking Details Screen => activity status ==  User Cancelled',
        (WidgetTester tester) async {
      HotelBookingDetailRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(
            result: hotelBookingDetailsActivityStatusUserCancelled),
      );

      await tester.runAsync(() async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 3));
        await tester.pumpAndSettle();
      });
    });
    testWidgets(
        'Hotel Booking Details Screen => activity status == Payment Failed',
        (WidgetTester tester) async {
      HotelBookingDetailRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(
            result: hotelBookingDetailsActivityStatusPaymentFailed),
      );

      await tester.runAsync(() async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 3));
        await tester.pumpAndSettle();
      });
    });
    testWidgets(
        'Hotel Booking Details Screen => activity status == Hotel Rejected',
        (WidgetTester tester) async {
      HotelBookingDetailRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(
            result: hotelBookingDetailsActivityStatusHotelRejected),
      );

      await tester.runAsync(() async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 3));
        await tester.pumpAndSettle();
      });
    });

    testWidgets(
        'Hotel Booking Details Screen => activity status == Payment Pending',
        (WidgetTester tester) async {
      HotelBookingDetailRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(
            result: hotelBookingDetailsActivityStatusPaymentPending),
      );

      await tester.runAsync(() async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 3));
        await tester.pumpAndSettle();
      });
    });

    testWidgets(
        'Hotel Booking Details Screen => activity status == Awaiting Cancellation',
        (WidgetTester tester) async {
      HotelBookingDetailRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(
            result: hotelBookingDetailsActivityAwatingCancellation),
      );

      await tester.runAsync(() async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 3));
        await tester.pumpAndSettle();
      });
    });

    testWidgets(
        'Hotel Booking Details Screen => activity status == Awating Reservation',
        (WidgetTester tester) async {
      HotelBookingDetailRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(
            result: hotelBookingDetailsActivityAwatingReservation),
      );

      await tester.runAsync(() async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 3));
        await tester.pumpAndSettle();
      });
    });

    testWidgets('Hotel Booking Details Widget With Error',
        (WidgetTester tester) async {
      HotelBookingDetailRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(
          result: null,
          exception: OperationException(),
        ),
      );
      await tester.runAsync(() async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 3));
        await tester.pumpAndSettle();
      });
    });
  });
}
