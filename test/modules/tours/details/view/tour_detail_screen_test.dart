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
import 'package:ota/domain/favourites/data_sources/favourites_service_remote_data_source.dart';
import 'package:ota/domain/favourites/repositories/favourites_service_repository_impl.dart';
import 'package:ota/domain/search/data_sources/ota_search_remote_data_source.dart';
import 'package:ota/domain/tours/details/data_sources/tours_details_remote_data_source.dart';
import 'package:ota/domain/tours/details/repositories/tours_details_repository_impl.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/heart_button/heart_button.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/slider_gallery_button.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_argument.dart';

import '../../../../helper.dart';
import '../../../../mocks/fixture_reader.dart';
import '../../../../mocks/tour/tour_details/tour_detail_mock.dart';
import '../../../hotel/repositories/Internet_success_mock.dart';
import '../../../hotel/repositories/internet_failure_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  Map<String, dynamic> fullData =
      json.decode(fixture("tour/tour_with_full_list_mock.json"));
  Map<String, dynamic> noPackageData =
      json.decode(fixture("tour/tour_with_no_packjage.json"));
  Map<String, dynamic> checkFav =
      json.decode(fixture("favourites/favorite_check.json"));
  group("Tour Widget", () {
    ToursDetailsRepositoryImpl.setMockInternet(InternetSuccessMock());
    testWidgets('Tour detail widget1', (WidgetTester tester) async {
      TourDetailsRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(result: fullData));
      OtaSearchRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(result: checkFav));
      FavouritesServiceRepositoryImpl.setMockInternet(InternetFailureMock());
      FavouritesServiceRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: getMockDataWithString(_markFavoriteMock)));
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
                    Navigator.pushNamed(context, AppRoutes.tourDetailScreen,
                        arguments: TourDetailArgument(
                          cityId: "MA05110041",
                          userType: TourDetailUserType.loggedInUser,
                          countryId: 'MA05110001',
                          tourId: 'MA05110042',
                          tourDate: '2021-12-26',
                        )),
              );
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(HeartButton));
        await tester.pumpAndSettle();
      });
    });

    testWidgets('Tour detail widget', (WidgetTester tester) async {
      TourDetailsRemoteDataSourceImpl.setMock(
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
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.tourDetailScreen,
                        arguments: TourDetailArgument(
                          cityId: "MA05110041",
                          userType: TourDetailUserType.guestUser,
                          countryId: 'MA05110001',
                          tourId: 'MA05110042',
                          tourDate: '2021-12-26',
                        )),
              );
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await tester.pumpAndSettle();
        await tester.tap(find.byType(HeartButton).first);
        await tester.pump();
        await tester.pump();
        await tester.tap(find.byKey(const Key("ChangeDateKey")));
      });
    });

    testWidgets('Tour detail widget with empty package',
        (WidgetTester tester) async {
      TourDetailsRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(result: noPackageData));
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
                    context, AppRoutes.tourDetailScreen,
                    arguments: getTourDetailArgumentMock()),
              );
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await tester.pumpAndSettle();
        await tester.tap(find.byType(SliderGalleryButton));
        await tester.pump();
      });
    });

    testWidgets('Tour detail widget failure state',
        (WidgetTester tester) async {
      TourDetailsRemoteDataSourceImpl.setMock(
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
                    context, AppRoutes.tourDetailScreen,
                    arguments: getTourDetailArgumentMock()),
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

var _markFavoriteMock = """
{
    "markFavorite": {
      "status": {
        "code": "1000",
        "header": "Success",
        "description": null
      }
    }
}
""";
