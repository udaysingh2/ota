import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/tours/ota_contact_information/view_model/ota_contact_information_argument_model.dart';

void main() {
  group("Ota Contact information page test", () {
    testWidgets('Ota Contact information page', (WidgetTester tester) async {
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
                      context, AppRoutes.otaContactInformationFormPage,
                      arguments: OtaContactInformationArgumentModel(
                        initialContactInformationArgumentData:
                            OtaContactInformationArgumentData(
                          firstName: 'Steve',
                          email: 'steve@email.com',
                          phoneNumber: '0123456789',
                          lastName: 'Smith',
                        ),
                        onOkClicked: (OtaContactInformationArgumentData
                            updatedContactInformationArgumentData) {},
                      )));
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await tester.pumpAndSettle();
        await tester.tap(find.byType(OtaRadioButton).first);
        await tester.pump();
      });
    });
  });
}
