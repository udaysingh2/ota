import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_period_selector/ota_date_time_picker/ota_cupertino_time_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_period_selector/ota_date_time_picker/widget/localizations.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("Ota CupertinoDatePicker", () {
    testWidgets('Ota CupertinoDatePickerg test', (WidgetTester tester) async {
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
            DefaultCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            return supportedLocales.elementAt(0);
          },
          home: Scaffold(
            body: Builder(builder: (context) {
              return SizedBox(
                  height: 350,
                  child: OtaCupertinoTimeWidget(
                    date: DateTime.utc(2022),
                    isPickup: true,
                    onSumbit: (time) {},
                    pickerTitle: "test",
                  ));
            }),
          ),
        ));
        await tester.pumpAndSettle();
      });
    });
  });
}
