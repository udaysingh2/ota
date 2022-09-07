import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/splash/channels/super_app_to_landing.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Custom ota search sort sheet test", () {
    testWidgets('splash sheet test', (WidgetTester tester) async {
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
                onPressed: () async {
                  SuperAppToLanding superAppToLanding = SuperAppToLanding();
                  superAppToLanding.handle(context: context);
                  superAppToLanding.onHandleSuccess;
                  superAppToLanding.dispose();
                },
              );
            }),
          ),
        ));

        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
      });
    });
  });
}
