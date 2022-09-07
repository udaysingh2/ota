import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/tours/reservation/view_model/guest_information_argument_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GuestInformationArgumentModel args = _getGuestInformation();
  group("Guest Information Screen", () {
    testWidgets('Guest Information Screen', (WidgetTester tester) async {
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
                    context, AppRoutes.guestInformationFormPage,
                    arguments: args),
              );
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.text("Select country", skipOffstage: true).first,
            warnIfMissed: false);
        await tester.pumpAndSettle();
      });
    });

    testWidgets('Guest Information Screen', (WidgetTester tester) async {
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
                    context, AppRoutes.guestInformationFormPage,
                    arguments: args),
              );
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(GestureDetector).at(1));
        await tester.pumpAndSettle();
      });
    });
  });
}

GuestInformationArgumentModel _getGuestInformation() {
  return GuestInformationArgumentModel(
      guestIndex: 0,
      isForAdult: true,
      isGuestNameRequired: true,
      isAllnameRequired: true,
      isDateofBirthRequired: true,
      isPassportCountryIssueRequired: true,
      isPassportCountryRequired: true,
      isPassportIdRequired: true,
      isPassportValidDateRequired: true,
      isWeightRequired: true,
      updateGuestInfo:
      GuestInformationData(guestFirstName: 'first', guestLastName: 'last'));
}

