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
import 'package:ota/domain/hotel/hotel_detail/data_sources/hotel_detail_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_detail/repositories/hotel_detail_repository_impl.dart';
import 'package:ota/modules/hotel/hotel_detail/model/hotel_update.dart';
import 'package:provider/provider.dart';

import '../../../../mocks/fixture_reader.dart';
import '../../../../mocks/hotel/hotel_details/hotel_detail_mock.dart';
import '../../repositories/internet_success_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  Map<String, dynamic> fullData =
      json.decode(fixture("hotel/hotel_with_full_list_mock.json"));
  Map<String, dynamic> noRoomData =
      json.decode(fixture("hotel/hotel_with_no_rooms_mock.json"));
  group("Hotel Widget", () {
    HotelDetailRepositoryImpl.setMockInternet(InternetSuccessMock());
    testWidgets('Hotel detail widget', (WidgetTester tester) async {
      HotelDetailRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(result: fullData));
      await tester.runAsync(() async {
        await tester.pumpWidget(MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) {
                return HotelDetailStatus();
              },
            ),
          ],
          child: MaterialApp(
            routes: AppRoutes.getRoutes(),
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
              body: Builder(builder: (context) {
                return TextButton(
                  child: const Text("press"),
                  onPressed: () => Navigator.pushNamed(
                      context, AppRoutes.hotelDetail,
                      arguments: getHotelDetailArgumentMock()),
                );
              }),
            ),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
      });
    });

    testWidgets('Hotel detail widget NO room Data',
        (WidgetTester tester) async {
      HotelDetailRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(result: noRoomData));
      await tester.runAsync(() async {
        await tester.pumpWidget(MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) {
                return HotelDetailStatus();
              },
            ),
          ],
          child: MaterialApp(
            routes: AppRoutes.getRoutes(),
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
              body: Builder(builder: (context) {
                return TextButton(
                  child: const Text("press"),
                  onPressed: () => Navigator.pushNamed(
                      context, AppRoutes.hotelDetail,
                      arguments: getHotelDetailArgumentMock()),
                );
              }),
            ),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
      });
    });
    testWidgets('Hotel detail widget failure state',
        (WidgetTester tester) async {
      HotelDetailRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(exception: OperationException()));
      await tester.runAsync(() async {
        await tester.pumpWidget(MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) {
                return HotelDetailStatus();
              },
            ),
          ],
          child: MaterialApp(
            routes: AppRoutes.getRoutes(),
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
              body: Builder(builder: (context) {
                return TextButton(
                  child: const Text("press"),
                  onPressed: () => Navigator.pushNamed(
                      context, AppRoutes.hotelDetail,
                      arguments: getHotelDetailArgumentMock()),
                );
              }),
            ),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
      });
    });
  });
}
