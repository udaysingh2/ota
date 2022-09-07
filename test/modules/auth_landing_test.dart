import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/utils/navigation_helper.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/auth_landing.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Auth landing test', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        ProviderInitializer(
          MaterialApp(
            navigatorKey: GlobalKeys.navigatorKey,
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
              body: Consumer<LoginModel>(
                builder: (context, value, child) {
                  return const AuthLanding();
                },
              ),
            ),
            routes: AppRoutes.getRoutes(),
          ),
        ),
      );

      await tester.pumpAndSettle(const Duration(seconds: 10));
    });
  });
}
