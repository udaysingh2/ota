import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/tickets/ticket_booking_details/models/ticket_booking_details_model_domain.dart';

import 'package:ota/modules/tickets/booking_details/view_model/ticket_booking_details_view_model.dart';

void main() {
  TicketBookingInformation argument =
      TicketBookingInformation.mapFromTourInformation(
          Information(
              closeTime: "8:00 pm",
              conditions: "Cancellation will charge 4% before 48 hours",
              description: "Activity is adventours",
              howToUse: "You can redeem the promotions",
              openTime: "10:00 am"),
          "JJ Hotel");

  TicketBookingInformation argumentWithoutName =
      TicketBookingInformation.mapFromTourInformation(
          Information(
              closeTime: "8:00 pm",
              conditions: "Cancellation will charge 4% before 48 hours",
              description: "Activity is adventours",
              howToUse: "You can redeem the promotions",
              openTime: "10:00 am"),
          null);

  TestWidgetsFlutterBinding.ensureInitialized();
  group("Tour Booking details Description Screen", () {
    testWidgets('Tour Booking  details Description Screen',
        (WidgetTester tester) async {
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
                    context, AppRoutes.ticketBookingDetailDescriptionScreen,
                    arguments: argument),
              );
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
      });
    });

    testWidgets('Tour Booking  details Description Screen',
        (WidgetTester tester) async {
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
                    context, AppRoutes.ticketBookingDetailDescriptionScreen,
                    arguments: argumentWithoutName),
              );
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
      });
    });
  });
}
