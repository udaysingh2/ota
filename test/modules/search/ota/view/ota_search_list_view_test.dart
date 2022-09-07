import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_playlist_amenities/ota_suggestion_card_with_amentities.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/search/data_sources/ota_search_mock_data_source.dart';
import 'package:ota/domain/search/repositories/ota_search_repository_impl.dart';
import 'package:ota/modules/search/filters/view_model/filter_argument.dart';
import 'package:ota/modules/search/hotel/helpers/search_suggestion_type.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_state_model.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_view_model.dart';
import 'package:ota/modules/search/ota/view_model/ota_suggestion_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../hotel/repositories/internet_failure_mock.dart';
import '../../../hotel/repositories/internet_success_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  testWidgets('Hotel list view widget', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({"": ""});
    mockOtaSearchData(
        remoteDataSource: OtaSearchMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());
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
                  context, AppRoutes.hotelListView,
                  arguments: OtaSearchStateModel(
                      pageType: PageType.search,
                      suggestion: OtaSuggestionModel(
                          id: "id",
                          hotelId: "MA2008000090",
                          countryId: "MA05110001",
                          name: "Monotel Aonang",
                          cityId: "MA05110062",
                          locationId: "locationId",
                          searchSuggestionType:
                              SearchSuggestionType.cityLocation),
                      hotelView: HotelView(
                          hotelList: [HotelListResult(hotelId: "hotelid")],
                          filter: FilterResult(maxPrice: 1000)))),
            );
          }),
        ),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pump();
      await Future.delayed(const Duration(milliseconds: 20));
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
    });
  });

  testWidgets('Hotel list view 2nd case widget', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({"": ""});
    AppConfig().appLocale =
        Locale(LanguageCodes.english.code, LanguageCodes.english.countryCode);

    mockOtaSearchData(
        remoteDataSource: OtaSearchMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

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
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.hotelListView,
                        arguments: OtaSearchStateModel(
                          pageType: PageType.filter,
                          filterArgument: FilterArgument(
                              hotelId: "MA2008000090",
                              countryCode: "MA05110001",
                              name: "Monotel Aonang",
                              cityId: "MA05110062",
                              locationId: "locationId",
                              roomList: [],
                              checkOutDate: '2021-11-13',
                              checkInDate: '2021-11-12'),
                        )));
          }),
        ),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(milliseconds: 20));
      await tester.pumpAndSettle();
      await tester.tap(find.text("12 Nov - 13 Nov"));
    });
  });

  testWidgets('Hotel list view 2nd case widget search',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({"": ""});
    AppConfig().appLocale =
        Locale(LanguageCodes.english.code, LanguageCodes.english.countryCode);

    mockOtaSearchData(
        remoteDataSource: OtaSearchMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

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
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.hotelListView,
                        arguments: OtaSearchStateModel(
                          pageType: PageType.search,
                          suggestion: OtaSuggestionModel(
                              id: "id",
                              hotelId: "MA2008000090",
                              countryId: "MA05110001",
                              name: "Monotel Aonang",
                              cityId: "MA05110062",
                              locationId: "locationId",
                              searchSuggestionType:
                                  SearchSuggestionType.cityLocation),
                          hotelView: HotelView(
                              hotelList: [HotelListResult(hotelId: "hotelid")],
                              filter: FilterResult(maxPrice: 1000)),
                        )));
          }),
        ),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(milliseconds: 20));
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
    });
  });

  testWidgets('Hotel list view hotel page type case widget',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({"": ""});
    AppConfig().appLocale =
        Locale(LanguageCodes.english.code, LanguageCodes.english.countryCode);

    mockOtaSearchData(
        remoteDataSource: OtaSearchMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

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
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.hotelListView,
                        arguments: OtaSearchStateModel(
                          pageType: PageType.hotel,
                          suggestion: OtaSuggestionModel(
                              id: "id",
                              hotelId: "MA2008000090",
                              countryId: "MA05110001",
                              name: "Monotel Aonang",
                              cityId: "MA05110062",
                              locationId: "locationId",
                              searchSuggestionType:
                                  SearchSuggestionType.cityLocation),
                          hotelView: HotelView(
                              hotelList: [HotelListResult(hotelId: "hotelid")],
                              filter: FilterResult(maxPrice: 1000)),
                          filterArgument: FilterArgument(
                              hotelId: "MA2008000090",
                              countryCode: "MA05110001",
                              name: "Monotel Aonang",
                              cityId: "MA05110062",
                              locationId: "locationId",
                              roomList: [],
                              checkOutDate: '2021-11-13',
                              checkInDate: '2021-11-12'),
                        )));
          }),
        ),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(milliseconds: 20));
      await tester.pumpAndSettle();
      await tester.tap(find.text("12 Nov - 13 Nov"));
    });
  });

  testWidgets('Hotel list view hotel page amenities type case widget',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({"": ""});
    AppConfig().appLocale =
        Locale(LanguageCodes.english.code, LanguageCodes.english.countryCode);

    mockOtaSearchData(
        remoteDataSource: OtaSearchMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    await tester.runAsync(() async {
      var widget = OtaSuggestionCardHorizontalAmenities(
        isInHorizontalScroll: false,
        headerText: "hotelListResult.hotelName",
        ratingText: "4",
        addressText: "hotelListResult.address",
        reviewText: "hotelListResult.reviewText",
        ratingTitle: "hotelListResult.ratingTitle",
        offerPercent: "50",
        discount: "80",
        imageUrl: "assets/images/icons/suggetion_card_palceholder.svg",
        score: "100",
        adminPromotionLine1: "offer",
        adminPromotionLine2: "free food",
        onPress: () {},
      );

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return MaterialApp(
              home: Material(
                child: Center(
                  child: widget,
                ),
              ),
            );
          },
        ),
      );

      // await tester.pumpWidget(_wrapWithMaterialApp(widget));

      //  then
      expect(find.byType(OtaSuggestionCardHorizontalAmenities), findsOneWidget);
    });
  });

  testWidgets('Hotel list view negative case widget',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({"": ""});
    AppConfig().appLocale =
        Locale(LanguageCodes.english.code, LanguageCodes.english.countryCode);

    mockOtaSearchData(internetInfo: InternetFailureMock());

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
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.hotelListView,
                        arguments: OtaSearchStateModel(
                          pageType: PageType.filter,
                          filterArgument: FilterArgument(
                              hotelId: "MA2008000090",
                              countryCode: "MA05110001",
                              name: "Monotel Aonang",
                              cityId: "MA05110062",
                              locationId: "locationId",
                              roomList: [],
                              checkOutDate: '2021-11-13',
                              checkInDate: '2021-11-12'),
                        )));
          }),
        ),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(milliseconds: 20));
      await tester.pumpAndSettle();
    });
  });
}
