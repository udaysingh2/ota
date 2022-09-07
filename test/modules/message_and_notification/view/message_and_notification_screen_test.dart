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
import 'package:ota/domain/message_and_notification/data_source/message_and_notification_data_source.dart';
import 'package:ota/domain/message_and_notification/data_source/message_and_notification_mock_datasource.dart';
import 'package:ota/domain/message_and_notification/repository/message_and_notification_repository.dart';
import 'package:ota/modules/message_and_notification/view/message_and_notification_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/material_wrapper.dart';
import '../../../mocks/fixture_reader.dart';
import '../../hotel/repositories/internet_success_mock.dart';

const String _specialForYouKey = "specialForYouKey";
const String _newsPromotionKey = "newsPromotionKey";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);

  group("Message and Notification Screen", () {
    SharedPreferences.setMockInitialValues({"": ""});
    MessageAndNotificationRepositoryImpl.setMockInternet(InternetSuccessMock());
    Map<String, dynamic> emptyList = json
        .decode(fixture("message_and_notification/message_empty_list.json"));

    testWidgets('Message and Receipt Empty List', (WidgetTester tester) async {
      MessageAndNotificationRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(result: emptyList),
      );

      await tester.runAsync(() async {
        Widget widget = MaterialApp(
          routes: AppRoutes.getRoutes(),
          supportedLocales: [
            Locale(
              LanguageCodes.english.code,
              LanguageCodes.english.countryCode,
            ),
            Locale(
              LanguageCodes.thai.code,
              LanguageCodes.thai.countryCode,
            ),
          ],
          localizationsDelegates: const [
            Localization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            primarySwatch: Colors.purple,
            fontFamily: 'Kanit',
          ),
          localeResolutionCallback: (locale, supportedLocales) {
            return supportedLocales.elementAt(1);
          },
          home: const Material(
            child: MessageAndNotificationScreen(),
          ),
        );
        await tester.pumpWidget(widget);
        await tester.pump();
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_specialForYouKey)).first);
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_newsPromotionKey)).first);
        await tester.pumpAndSettle();
      });
    });
    testWidgets('Notification Data', (WidgetTester tester) async {
      MessageAndNotificationRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(
          result: jsonDecode(
            MessageAndNotificationMockDataSource.getMockNewsData(),
          ),
        ),
      );

      MessageAndNotificationRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(
          result: jsonDecode(
            MessageAndNotificationMockDataSource.getMockReceiptData(),
          ),
        ),
      );

      await tester.runAsync(() async {
        Widget widget = MaterialApp(
          routes: AppRoutes.getRoutes(),
          supportedLocales: [
            Locale(
              LanguageCodes.english.code,
              LanguageCodes.english.countryCode,
            ),
            Locale(
              LanguageCodes.thai.code,
              LanguageCodes.thai.countryCode,
            ),
          ],
          localizationsDelegates: const [
            Localization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            primarySwatch: Colors.purple,
            fontFamily: 'Kanit',
          ),
          localeResolutionCallback: (locale, supportedLocales) {
            return supportedLocales.elementAt(1);
          },
          home: const Material(
            child: MessageAndNotificationScreen(),
          ),
        );
        await tester.pumpWidget(widget);
        await tester.pump();
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_specialForYouKey)).first);
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_newsPromotionKey)).first);
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key("messageNewsTile0")));
        await Future.delayed(const Duration(seconds: 1));
        await tester.pumpAndSettle();
      });
    });

    testWidgets('Receipt Data', (WidgetTester tester) async {
      MessageAndNotificationRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(
          result: jsonDecode(
            MessageAndNotificationMockDataSource.getMockNewsData(),
          ),
        ),
      );

      MessageAndNotificationRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(
          result: jsonDecode(
            MessageAndNotificationMockDataSource.getMockReceiptData(),
          ),
        ),
      );

      await tester.runAsync(() async {
        Widget widget = MaterialApp(
          routes: AppRoutes.getRoutes(),
          supportedLocales: [
            Locale(
              LanguageCodes.english.code,
              LanguageCodes.english.countryCode,
            ),
            Locale(
              LanguageCodes.thai.code,
              LanguageCodes.thai.countryCode,
            ),
          ],
          localizationsDelegates: const [
            Localization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            primarySwatch: Colors.purple,
            fontFamily: 'Kanit',
          ),
          localeResolutionCallback: (locale, supportedLocales) {
            return supportedLocales.elementAt(1);
          },
          home: const Material(
            child: MessageAndNotificationScreen(),
          ),
        );
        await tester.pumpWidget(widget);
        await tester.pump();
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_specialForYouKey)).first);
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key("messageReceiptTile0")));
        await tester.pump();
      });
    });

    testWidgets('News Notification With Error', (WidgetTester tester) async {
      MessageAndNotificationRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(
          result: null,
          exception: OperationException(),
        ),
      );
      await tester.runAsync(() async {
        Widget widget = getMaterialWrapper(
          const MessageAndNotificationScreen(),
        );
        await tester.pumpWidget(widget);
        await tester.pump();
        await Future.delayed(const Duration(seconds: 4));
        await tester.pumpAndSettle();
      });
    });
  });
}
