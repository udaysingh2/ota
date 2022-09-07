import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/tickets/details/models/ticket_details_model.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_argument.dart';
import 'package:ota/modules/tickets/package_details/view_model/ticket_package_detail_view_model.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  Map<String, dynamic> fullData =
      json.decode(fixture("ticket/ticket_with_full_list_mock.json"));

  TicketDetail ticketDetail = TicketDetail.fromMap(fullData);
  TicketDetailArgument argument = TicketDetailArgument(
    cityId: "MA05110041",
    userType: TicketDetailUserType.guestUser,
    countryId: 'MA05110001',
    ticketId: 'MA2111000168',
    ticketDate: '2021-12-26',
  );
  TicketPackageDetailViewModel ticketPackageDetailViewModel =
      TicketPackageDetailViewModel.mapFromTicketPackage(
          ticketDetail.getTicketDetails!.data!.ticket!.packages![0], argument);

  TicketPackageDetailViewModel ticketPackageDetailViewErrorModel =
      TicketPackageDetailViewModel.mapFromTicketPackage(null, null);

  TestWidgetsFlutterBinding.ensureInitialized();
  group("Ticket package detail screen Test", () {
    testWidgets('Ticket package detail screen Test',
        (WidgetTester tester) async {
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
                    context, AppRoutes.ticketPackageDetailScreen,
                    arguments: ticketPackageDetailViewModel),
              );
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("BookNowButton")));
        await tester.pump();
      });
    });

    testWidgets('Ticket package detail error screen Test',
        (WidgetTester tester) async {
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
                    context, AppRoutes.ticketPackageDetailScreen,
                    arguments: ticketPackageDetailViewErrorModel),
              );
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.pump();
      });
    });
  });
  testWidgets('Ticket package detail screen guest user Test',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(MaterialApp(
        routes: AppRoutes.getRoutes(),
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
              onPressed: () => Navigator.pushNamed(
                  context, AppRoutes.ticketPackageDetailScreen,
                  arguments: ticketPackageDetailViewModel),
            );
          }),
        ),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      LoginModel loginModel = getLoginProvider();
      loginModel.setUserType(userType: 'GUEST');
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("BookNowButton")));
      await tester.pumpAndSettle();
      await tester.pump();
    });
  });
  testWidgets('Ticket package detail screen active user Test',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(MaterialApp(
        routes: AppRoutes.getRoutes(),
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
              onPressed: () => Navigator.pushNamed(
                  context, AppRoutes.ticketPackageDetailScreen,
                  arguments: ticketPackageDetailViewModel),
            );
          }),
        ),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      LoginModel loginModel = getLoginProvider();
      loginModel.setUserType(userType: 'ACTIVE');
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("BookNowButton")));
      await tester.pumpAndSettle();
      await tester.pump();
    });
  });
}
