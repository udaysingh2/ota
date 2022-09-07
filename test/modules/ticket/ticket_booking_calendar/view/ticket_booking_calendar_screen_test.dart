import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/tickets/details/data_source/ticket_details_remote_data_source.dart';
import 'package:ota/domain/tickets/details/repositories/ticket_details_repository_impl.dart';
import 'package:ota/domain/tickets/review_reservation/data_source/ticket_review_reservation_remote_data_source.dart';
import 'package:ota/domain/tickets/review_reservation/data_source/ticket_review_reservation_remote_data_source_mock.dart';
import 'package:ota/domain/tickets/review_reservation/repositories/ticket_review_reservation_repository_impl.dart';
import 'package:ota/modules/tickets/ticket_booking_calendar/view_model/ticket_booking_calendar_argument.dart';
import 'package:ota/modules/tickets/ticket_booking_calendar/view_model/ticket_booking_calendar_view_model.dart';

import '../../../../helper.dart';
import '../../../../mocks/fixture_reader.dart';
import '../../../hotel/repositories/Internet_failure_mock.dart';
import '../../../hotel/repositories/Internet_success_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  Map<String, dynamic> fullData =
      json.decode(fixture("ticket/ticket_with_complete_data_mock.json"));
  Map<String, dynamic> noPackageData =
      json.decode(fixture("ticket/ticket_with_no_package_data.json"));
  TicketBookingCalendarArgument ticketBookingCalendarArgument =
      TicketBookingCalendarArgument(
          rateKey: "TUEyMTEwMDAwMzcz",
          currency: "THB",
          packageName: "packageName",
          cityId: "MA05110041",
          countryId: "MA05110001",
          selectedDate: DateTime.now(),
          serviceId: "MA21110100",
          zoneId: "MA21110009",
          refCode: "CL213",
          ticketId: "MA2111000157",
          timeOfDay: "AM",
          startTime: "10:00",
          serviceType: "SIC",
          availableSeats: 5,
          ticketTypes: [
        TicketTypes(
            ticketCount: 4,
            price: 222.00,
            minimum: 2,
            available: 7,
            name: "VIP",
            paxId: "MA01010003")
      ]);
  group("Ticket Booking calendar Screen", () {
    TicketReviewReservationRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(
            TicketReviewReservationMockDataSourceImpl.getMockData())));
    TicketDetailsRepositoryImpl.setMockInternet(InternetSuccessMock());
    TicketsReviewReservationRepositoryImpl.setMockInternet(
        InternetSuccessMock());
    testWidgets('Ticket Booking calendar Screen with Complete data',
        (WidgetTester tester) async {
      TicketDetailsRemoteSourceDataImpl.setMock(
          GraphQlResponseMock(result: fullData));
      await tester.runAsync(() async {
        Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.ticketBookingCalenderScreen,
          ticketBookingCalendarArgument,
        );

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await tester.pumpAndSettle();
        await tester.tap(find.byType(OtaTextButton).first);
        await tester.pump();
      });
    });

    testWidgets('Ticket Booking calendar Screen with failure state',
        (WidgetTester tester) async {
      TicketDetailsRemoteSourceDataImpl.setMock(
          GraphQlResponseMock(exception: OperationException()));
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(
          routes: AppRoutes.getRoutes(),
          supportedLocales: [
            Locale(
                LanguageCodes.english.code, LanguageCodes.english.countryCode),
            Locale(LanguageCodes.thai.code, LanguageCodes.thai.countryCode),
          ],
          localizationsDelegates: const [
            Localization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            return supportedLocales.elementAt(0);
          },
          home: Scaffold(
            body: Builder(builder: (context) {
              return TextButton(
                child: const Text("press"),
                onPressed: () => Navigator.pushNamed(
                    context, AppRoutes.ticketBookingCalenderScreen,
                    arguments: ticketBookingCalendarArgument),
              );
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await tester.pumpAndSettle();
      });
    });

    testWidgets('Ticket Booking calendar Screen with empty package',
        (WidgetTester tester) async {
      TicketDetailsRemoteSourceDataImpl.setMock(
          GraphQlResponseMock(result: noPackageData));
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(
          routes: AppRoutes.getRoutes(),
          supportedLocales: [
            Locale(
                LanguageCodes.english.code, LanguageCodes.english.countryCode),
            Locale(LanguageCodes.thai.code, LanguageCodes.thai.countryCode),
          ],
          localizationsDelegates: const [
            Localization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            return supportedLocales.elementAt(0);
          },
          home: Scaffold(
            body: Builder(builder: (context) {
              return TextButton(
                child: const Text("press"),
                onPressed: () => Navigator.pushNamed(
                    context, AppRoutes.ticketBookingCalenderScreen,
                    arguments: ticketBookingCalendarArgument),
              );
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await tester.pumpAndSettle();
      });
    });

    testWidgets('Ticket Booking calendar Screen with Internet failure',
        (WidgetTester tester) async {
      TicketDetailsRepositoryImpl.setMockInternet(InternetFailureMock());
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(
          routes: AppRoutes.getRoutes(),
          supportedLocales: [
            Locale(
                LanguageCodes.english.code, LanguageCodes.english.countryCode),
            Locale(LanguageCodes.thai.code, LanguageCodes.thai.countryCode),
          ],
          localizationsDelegates: const [
            Localization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            return supportedLocales.elementAt(0);
          },
          home: Scaffold(
            body: Builder(builder: (context) {
              return TextButton(
                child: const Text("press"),
                onPressed: () => Navigator.pushNamed(
                    context, AppRoutes.ticketBookingCalenderScreen,
                    arguments: ticketBookingCalendarArgument),
              );
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await tester.pumpAndSettle();
      });
    });
  });
}
