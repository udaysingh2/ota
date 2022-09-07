import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_guest_information_argument_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);

  TicketGuestInformationArgumentModel args = _getGuestInformation();
  group("Ticket Guest Information Screen", () {
    testWidgets('Ticket Guest Information Screen', (WidgetTester tester) async {
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
                    context, AppRoutes.ticketGuestInformationFormPage,
                    arguments: args),
              );
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await tester.pump();
        await tester.tap(find.byType(GestureDetector).first,
            warnIfMissed: false);
        await tester.pump();
        await tester.pump();
        await tester.tap(find.byType(GestureDetector).last,
            warnIfMissed: false);
        await tester.pump();
      });
    });
  });
}

TicketGuestInformationArgumentModel _getGuestInformation() {
  return TicketGuestInformationArgumentModel(
    guestIndex: 0,
    isGuestNameRequired: true,
    isAllNameRequired: true,
    isWeightRequired: true,
    isDateOfBirthRequired: true,
    isPassportIdRequired: true,
    isPassportCountryIssueRequired: true,
    isPassportCountryRequired: true,
    isPassportValidDateRequired: true,
    updateGuestInfo: TicketGuestInformationData(
        guestFirstName: 'first',
        guestLastName: 'last',
        guestWeight: "65",
        guestPassportId: "nvbg675f",
        selectedDob: DateTime.now(),
        selectedPassportValidityDate: DateTime.now(),
        selectedPassportCountry: "India",
        selectedPassportIssuingCountry: "India",
        guestMobileNumber: "0123456789",
        guestEmail: "a@b.com"),
  );
}
