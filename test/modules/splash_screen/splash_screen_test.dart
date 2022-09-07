import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/splash/data_sources/splash_mock_data_source.dart';
import 'package:ota/domain/splash/data_sources/splash_remote_data_source.dart';
import 'package:ota/domain/splash/repositories/splash_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/ota_search_sort/repositories/ota_filter_sort_repo_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Splash Widget", () {
    SharedPreferences.setMockInitialValues({"": ""});
    SplashRepositoryImpl.setMockInternet(InternetConnectionInfoMocked());
    testWidgets('Splash widget', (WidgetTester tester) async {
      SplashRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(SplashMockDataSourceImpl.getMockData()),
      ));
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
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.splashScreen),
              );
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.pumpAndSettle();
      });
    });

    testWidgets('Splash widget negative', (WidgetTester tester) async {
      SplashRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        exception: OperationException(),
      ));
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
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.splashScreen),
              );
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.pumpAndSettle();
      });
    });
  });
}
