import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/hotel/room_reservation/contact_information/view_model/contact_information_argument_model.dart';

void main() {
  group("Contact information page test", () {
    testWidgets('Contact information page', (WidgetTester tester) async {
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
                      context, AppRoutes.contactInformationFormPage,
                      arguments: ContactInformationArgumentModel(
                        initialContactInformationArgumentData:
                            ContactInformationArgumentData(
                          firstName: 'firstName',
                          email: 'name@email.com',
                          phoneNumber: '01234567',
                          lastName: 'lastname',
                        ),
                        onOkClicked: (ContactInformationArgumentData
                            updatedContactInformationArgumentData) {},
                      )));
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
