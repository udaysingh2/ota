import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/tours/details/models/tour_details_models.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_argument.dart';
import 'package:ota/modules/tours/package_detail/view_model/tour_package_detail_view_model.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  Map<String, dynamic> fullData =
      json.decode(fixture("tour/tour_with_full_list_mock.json"));

  TourDetail tourDetail = TourDetail.fromMap(fullData);
  TourDetailArgument argument = TourDetailArgument(
    cityId: "MA05110041",
    userType: TourDetailUserType.guestUser,
    countryId: 'MA05110001',
    tourId: 'MA2110000413',
    tourDate: '2021-12-26',
  );
  TourPackageDetailViewModel tourPackageDetailViewModel =
      TourPackageDetailViewModel.mapFromTourPackage(
          tourDetail.getTourDetails!.data!.tour!.packages![0], argument);

  TourPackageDetailViewModel tourPackageDetailErrorViewModel =
      TourPackageDetailViewModel.mapFromTourPackage(null, null);

  TestWidgetsFlutterBinding.ensureInitialized();
  group("Tour package detail screen Test", () {
    testWidgets('Tour package detail screen Test', (WidgetTester tester) async {
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
                    context, AppRoutes.tourPackageDetailScreen,
                    arguments: tourPackageDetailViewModel),
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

    testWidgets('Tour package detail error screen Test',
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
                    context, AppRoutes.tourPackageDetailScreen,
                    arguments: tourPackageDetailErrorViewModel),
              );
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
      });
    });

    testWidgets('Tour package detail guest screen Test',
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
                    context, AppRoutes.tourPackageDetailScreen,
                    arguments: tourPackageDetailViewModel),
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
  });

  testWidgets('Tour package detail active screen Test',
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
                  context, AppRoutes.tourPackageDetailScreen,
                  arguments: tourPackageDetailViewModel),
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
