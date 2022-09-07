import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/loading/data_sources/loading_mock_data_source.dart';
import 'package:ota/domain/loading/repositories/loading_repository_impl.dart';
import 'package:ota/modules/loading/view/loading_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../hotel/repositories/internet_success_mock.dart';

const _serviceName = "CARRENTAL";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  testWidgets('Loading widget', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({"": ""});
    mockLoadingData(
        remoteDataSource: LoadingMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());
    await tester.runAsync(() async {
      await tester.pumpWidget(MaterialApp(
        routes: {
          "loading": (context) => const LoadingScreen(_serviceName),
        },
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
        home: Scaffold(
          body: Builder(builder: (context) {
            return TextButton(
              child: const Text("press"),
              onPressed: () => Navigator.pushNamed(context, "loading"),
            );
          }),
        ),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pump();
      await Future.delayed(const Duration(milliseconds: 20));
      await tester.pumpAndSettle();
    });
  });
}
