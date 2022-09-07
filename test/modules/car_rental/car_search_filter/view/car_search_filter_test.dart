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
import 'package:ota/domain/car_rental/car_search_filter/data_sources/car_search_filter_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_search_filter/repositories/car_search_filter_repository_impl.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view_model/car_search_result_argument_model.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view_model/car_search_result_view_model.dart';
import 'package:ota/modules/car_rental/car_search_filter/view_model/car_search_filter_argument_view_model.dart';
import 'package:ota/modules/car_rental/car_search_filter/view_model/car_search_filter_view_model.dart';
import '../../../../mocks/fixture_reader.dart';
import '../../../hotel/repositories/internet_success_mock.dart';

const String _kResetButtonKey = "car_search_filter_reset_button_key";
const String _kSearchButtonKey = "car_search_filter_search_button_key";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  Map<String, dynamic> fullData =
      json.decode(fixture("carRental/car_search_filter_mock.json"));

  CarSearchFilterArgumentViewModel carSearchFilterArgumentModel =
      CarSearchFilterArgumentViewModel(
    availableFilterViewModel: AvailableFilterViewModel(
      minPrice: 0,
      maxPrice: 10000,
      carBrand: [
        FilterViewModel(id: '1', name: "CarBrandName1"),
        FilterViewModel(id: '2', name: "CarBrandName2")
      ],
      carType: [FilterViewModel(id: '1', name: "CarTypeName")],
      carSupplier: [FilterViewModel(id: '1', name: "CarSupplierName")],
      promotionList: [FilterViewModel(id: '1', name: "CarPromotionName")],
    ),
    selectedFilter: FilterValue(
      sortByValue: CriterionModel(
        value: 'value',
        displayTitle: "Display Title",
      ),
    ),
  );
  testWidgets('Car search result test with success',
      (WidgetTester tester) async {
    CarSearchFilterRepositoryImpl.setMockInternet(InternetSuccessMock());

    CarSearchFilterRemoteDataSourceImpl.setMock(
      GraphQlResponseMock(result: fullData),
    );
    await tester.runAsync(() async {
      Widget widget = MaterialApp(
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
                context,
                AppRoutes.carSearchFilter,
                arguments: carSearchFilterArgumentModel,
              ),
            );
          }),
        ),
      );
      await tester.pumpWidget(widget);
      await tester.pump(const Duration(seconds: 2));
      await tester.tap(find.text("press"));
      await tester.pump(const Duration(seconds: 1));
      await Future.delayed(const Duration(seconds: 2));
      await tester.pump(const Duration(seconds: 1));
      await tester.tap(find.byKey(const Key(_kResetButtonKey)));
      await tester.pump(const Duration(seconds: 1));
      await tester.tap(find.byKey(const Key(_kSearchButtonKey)));
    });
  });

  testWidgets('Car search filter test with Failure',
      (WidgetTester tester) async {
    CarSearchFilterRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(exception: OperationException()));
    await tester.runAsync(() async {
      Widget widget = MaterialApp(
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
                context,
                AppRoutes.carSearchFilter,
                arguments: carSearchFilterArgumentModel,
              ),
            );
          }),
        ),
      );
      await tester.pumpWidget(widget);
      await tester.pump(const Duration(seconds: 2));
      await tester.tap(find.text("press"));
      await tester.pump(const Duration(seconds: 1));
      await Future.delayed(const Duration(seconds: 2));
      await tester.pump(const Duration(seconds: 1));
    });
  });

  testWidgets('Car search filter test with NoFilterData Failure',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      Widget widget = MaterialApp(
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
                context,
                AppRoutes.carSearchFilter,
                arguments: CarSearchFilterArgumentViewModel(
                  availableFilterViewModel: null,
                ),
              ),
            );
          }),
        ),
      );
      await tester.pumpWidget(widget);
      await tester.pump(const Duration(seconds: 2));
      await tester.tap(find.text("press"));
      await tester.pump(const Duration(seconds: 1));
      await Future.delayed(const Duration(seconds: 2));
      await tester.pump(const Duration(seconds: 1));
    });
  });

  testWidgets('Car search result test with NoFilterValue Failure',
      (WidgetTester tester) async {
    CarSearchFilterRepositoryImpl.setMockInternet(InternetSuccessMock());

    CarSearchFilterRemoteDataSourceImpl.setMock(
      GraphQlResponseMock(result: {
        "getSortCriteriaForService": {
          "status": null,
          "data": null,
        },
      }),
    );
    await tester.runAsync(() async {
      Widget widget = MaterialApp(
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
                context,
                AppRoutes.carSearchFilter,
                arguments: carSearchFilterArgumentModel,
              ),
            );
          }),
        ),
      );
      await tester.pumpWidget(widget);
      await tester.pump(const Duration(seconds: 2));
      await tester.tap(find.text("press"));
      await tester.pump(const Duration(seconds: 1));
      await Future.delayed(const Duration(seconds: 2));
      await tester.pump(const Duration(seconds: 1));
    });
  });
}
