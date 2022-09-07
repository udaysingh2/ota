import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/utils/navigation_helper.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/car_rental/car_search_result/data_sources/car_search_result_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_search_result/repositories/car_search_result_repository_impl.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/car_rental/car_landing/view_model/car_landing_view_model.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view/widget/car_search_result_tile.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view_model/car_dates_location_update_view_model.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view_model/car_search_result_argument_model.dart';
import 'package:provider/provider.dart';
import '../../../../mocks/fixture_reader.dart';
import '../../../hotel/repositories/internet_success_mock.dart';

const String _kFilterIconKey = "filter_icon_key";
const String _kSubmitButtonKey = "submitt_button_key";
const String _kCarSearchResultListKey = "car_search_result_list_key";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  Map<String, dynamic> fullData =
      json.decode(fixture("carRental/car_search_result_mock.json"));

  CarSearchResultArgumentModel _getArgument({bool isOtaLandingSearch = false}) {
    return CarSearchResultArgumentModel(
      staticSearchValue: StaticFilterValue(userId: 'userId'),
      landingFilterValue: LandingFilterValue(
        pickupLocationId: "MA06080006",
        returnLocationId: "MA06080006",
        pickupLocation: "pickupLocation",
        returnLocation: "returnLocation",
        age: 30,
        includeDriver: false,
      ),
      isOtaLandingSearch: isOtaLandingSearch,
    );
  }

  testWidgets('Car search result test with success',
      (WidgetTester tester) async {
    CarSearchResultRepositoryImpl.setMockInternet(InternetSuccessMock());

    CarSearchResultRemoteDataSourceImpl.setMock(
      GraphQlResponseMock(result: fullData),
    );
    await tester.runAsync(() async {
      await tester.pumpWidget(
        ProviderInitializer(
          MaterialApp(
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
                    context,
                    AppRoutes.carSearchResult,
                    arguments: _getArgument(isOtaLandingSearch: true),
                  ),
                );
              }),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pump();
      await tester.pumpAndSettle();

      await tester.tap(find.byType(CarSearchResultTile).first);
    });
  });

  testWidgets('Car search result test with success and filter',
      (WidgetTester tester) async {
    CarSearchResultRepositoryImpl.setMockInternet(InternetSuccessMock());

    CarSearchResultRemoteDataSourceImpl.setMock(
      GraphQlResponseMock(result: fullData),
    );

    await tester.runAsync(() async {
      await tester.pumpWidget(
        ProviderInitializer(
          MaterialApp(
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
                    context,
                    AppRoutes.carSearchResult,
                    arguments: _getArgument(isOtaLandingSearch: true),
                  ),
                );
              }),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pump();
      await tester.pumpAndSettle();

      await tester.drag(
        find.byKey(const Key(_kCarSearchResultListKey)),
        const Offset(0, -100),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key(_kFilterIconKey)));
    });
  });

  testWidgets('Car search result test with Failure',
      (WidgetTester tester) async {
    CarSearchResultRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(exception: OperationException()));
    await tester.runAsync(() async {
      await tester.pumpWidget(
        ProviderInitializer(
          MaterialApp(
            navigatorKey: GlobalKeys.navigatorKey,
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
                    context,
                    AppRoutes.carSearchResult,
                    arguments: _getArgument(),
                  ),
                );
              }),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pump();
      await tester.pumpAndSettle();

      CarDatesLocationUpdateViewModel dateUpdate =
          Provider.of<CarDatesLocationUpdateViewModel>(
        GlobalKeys.navigatorKey.currentContext!,
        listen: false,
      );
      dateUpdate.updateCarLocation(
        locationModelDropOff: LocationModel(
          locationId: 'locationIdDropOff',
          location: 'locationDropOff',
        ),
        locationModelPickup: LocationModel(
          locationId: 'locationIdPickup',
          location: 'locationPickup',
        ),
      );
      await tester.pump();
      await tester.pumpAndSettle();
      await tester.pump();

      await tester.tap(find.byKey(const Key(_kSubmitButtonKey)));
      await tester.pumpAndSettle();
    });
  });
}
