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
import 'package:ota/domain/preferences/data_sources/preferences_mock_data_sources.dart';
import 'package:ota/domain/preferences/data_sources/preferences_remote_data_sources.dart';
import 'package:ota/domain/preferences/repositories/preferences_submit_repository_impl.dart';

import '../../../mocks/preferences/preferences_argument_mock.dart';
import '../../hotel/repositories/internet_success_mock.dart';

const String _kSubmitPreferencesButtonKey = "submit_preferences_button_key";
const String _kPreferencesCardKey = "preference_card_1";
const String _kPreferencesChipKey = "preference_chip_1";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Hotel Widget", () {
    PreferencesSubmitRepositoryImpl.setMockInternet(InternetSuccessMock());
    // mockLandingPageData(
    //     remoteDataSource: LandingPageMockDataSourceImpl(),
    //     internetInfo: InternetSuccessMock());
    testWidgets('Hotel detail widget', (WidgetTester tester) async {
      PreferencesSubmitRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(PreferencesMockDataSourceImpl.getMockData())));
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
                    context, AppRoutes.preferencesScreen,
                    arguments: getPreferencesArgumentModel()),
              );
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_kPreferencesCardKey)));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_kSubmitPreferencesButtonKey)));
        await tester.pumpAndSettle();

        await tester.tap(find.byType(IconButton).first);
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_kSubmitPreferencesButtonKey)));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_kPreferencesChipKey)));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_kSubmitPreferencesButtonKey)));
      });
    });

    testWidgets('Hotel detail widget failure state',
        (WidgetTester tester) async {
      PreferencesSubmitRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(exception: OperationException()));
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
                    context, AppRoutes.preferencesScreen,
                    arguments: getPreferencesArgumentModel()),
              );
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_kPreferencesCardKey)));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_kSubmitPreferencesButtonKey)));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_kPreferencesChipKey)));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_kSubmitPreferencesButtonKey)));
        // await Future.delayed(Duration(seconds: 1));
        // await tester.pumpAndSettle();
      });
    });
  });
}
