import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/car_rental/guest_driver_details/view_model/driver_information_argument_model.dart';

const _kDriverContactSubmit = "DriverContactSubmit";

void main() {
  group("Guest Driver Detail List", () {
    testWidgets('Guest Driver Detail List Screen Test',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(
            routes: AppRoutes.getRoutes(),
            supportedLocales: [
              Locale(LanguageCodes.english.code,
                  LanguageCodes.english.countryCode),
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
                    onPressed: () {
                      Navigator.pushNamed(
                          context, AppRoutes.guestDriverDetailsScreen,
                          arguments: DriverInformationArgumentModel(
                              onOkClicked: (data) {},
                              isMaterialBannerShown: false,
                              submitDriverDetailsState:
                                  SubmitDriverDetailsState.success,
                              initialContactInformationArgumentData:
                                  DriverInformationArgumentData(
                                      firstName: "Test",
                                      phoneNumber: "8787676754",
                                      flightNumber: "1234",
                                      age: 36,
                                      lastName: "Test")));
                    });
              }),
            )));
      });
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pump();
      await tester.tap(find.byType(GestureDetector).last, warnIfMissed: false);
      await tester.pump();
      await tester.tap(find.byType(GestureDetector).first, warnIfMissed: false);
      await tester.pump();
      await tester.tap(find.byKey(const Key('driver_age_selection')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key(_kDriverContactSubmit)));
      await tester.pumpAndSettle();
    });
  });
}
