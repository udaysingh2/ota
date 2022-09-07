import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/utils/navigation_helper.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/demo_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);

  var widget = ProviderInitializer(
    MaterialApp(
      navigatorKey: GlobalKeys.navigatorKey,
      supportedLocales: [
        Locale(LanguageCodes.english.code, LanguageCodes.english.countryCode),
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
      home: const Scaffold(
        body: DemoScreen(),
      ),
      routes: AppRoutes.getRoutes(),
    ),
  );
  testWidgets('Auth landing test', (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    await tester.pump();

    var floatingActionButton =
        find.widgetWithIcon(FloatingActionButton, Icons.translate);
    await tester.tap(floatingActionButton);
    await tester.pump();

    var iconButton = find.byType(IconButton);
    await tester.tap(iconButton);
    await tester.pump();

    await tester.pumpAndSettle(const Duration(seconds: 5));
  });

  testWidgets('Auth landing test with logout', (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    await tester.pump();

    var logoutButton = find.widgetWithText(TextButton, "Active");
    await tester.tap(logoutButton);
    await tester.pump();

    await tester.pumpAndSettle();
  });
}
