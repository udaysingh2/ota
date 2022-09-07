import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/tours/loading/data_sources/tour_loading_remote_data_source.dart';
import 'package:ota/domain/tours/loading/repositories/tour_loading_repository_impl.dart';
import 'package:ota/modules/tours/tour_search/results/view_model/tour_search_result_argument_model.dart';

import '../../../../mocks/fixture_reader.dart';
import '../../../hotel/repositories/Internet_success_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  Map<String, dynamic> fullData =
      json.decode(fixture("tour/loading/tour_loading_success_mock.json"));
  setUpAll(() => HttpOverrides.global = null);
  TourSearchResultArgumentModel argument = TourSearchResultArgumentModel(
      playlistName: "tour",
      pageNumber: 1,
      countryId: "MA05110001",
      cityId: "MA05110062",
      latitude: 10.00,
      longitude: 20.00,
      pageSize: 10,
      searchKey: "searchKey");
  group("Tour Loading Screen", () {
    TourLoadingRepositoryImpl.setMockInternet(InternetSuccessMock());
    testWidgets('Tour Loading Screen with Success data',
        (WidgetTester tester) async {
      TourLoadingRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(result: fullData));
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
                    context, AppRoutes.tourLoadingScreen,
                    arguments: argument),
              );
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await tester.pumpAndSettle();
      });
    });
  });
}
