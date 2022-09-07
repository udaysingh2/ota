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
import 'package:ota/domain/room_gallery/data_sources/room_gallery_data_source_mock.dart';
import 'package:ota/domain/room_gallery/data_sources/room_gallery_remote_data_source.dart';
import 'package:ota/domain/room_gallery/repositories/room_gallery_repository_impl.dart';
import 'package:ota/modules/room_gallery/view_model/room_gallery_argument_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/get_customer_details/repositories/customer_repository_impl_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Hotel Room Gallery Screen", () {
    SharedPreferences.setMockInitialValues({"": ""});
    RoomGalleryRepositoryImpl.setMockInternet(InternetConnectionInfoMocked());
    testWidgets('Hotel Room Gallery Screen Widget Test', (WidgetTester tester) async {
      RoomGalleryRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(RoomGalleryMockDataSourceImpl.getMockData()),
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
                    Navigator.pushNamed(context, AppRoutes.roomGalleryScreen, arguments: RoomGalleryArgumentModel(
                        hotelId: '123',
                        roomId: '7777')),
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

    testWidgets('Hotel Room Gallery Screen Widget negative', (WidgetTester tester) async {
      RoomGalleryRemoteDataSourceImpl.setMock(GraphQlResponseMock(
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
                    Navigator.pushNamed(context, AppRoutes.roomGalleryScreen, arguments: RoomGalleryArgumentModel(
                        hotelId: '123',
                        roomId: '7777')),
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
