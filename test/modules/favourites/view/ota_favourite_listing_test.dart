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
import 'package:ota/domain/favourites/data_sources/favourite_mock_carrental.dart';
import 'package:ota/domain/favourites/data_sources/favourite_remote_data_source_all.dart';
import 'package:ota/domain/favourites/data_sources/favourites_mock_data_source.dart';
import 'package:ota/domain/favourites/data_sources/favourites_mock_data_source_all.dart';
import 'package:ota/domain/favourites/data_sources/favourites_remote_data_source.dart';
import 'package:ota/domain/favourites/data_sources/favourites_remote_data_source_car_rental.dart';
import 'package:ota/domain/favourites/data_sources/favourites_service_mock_data_source.dart';
import 'package:ota/domain/favourites/data_sources/favourites_service_remote_data_source.dart';
import 'package:ota/domain/favourites/repositories/favourites_repository_imp_car_rental.dart';
import 'package:ota/domain/favourites/repositories/favourites_repository_impl.dart';
import 'package:ota/domain/favourites/repositories/favoutite_repository_impl_all.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/favourites/view/ota_favourite_listing_screen.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_options/favourites_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/ota_search_sort/repositories/ota_filter_sort_repo_test.dart';
import '../../../helper/material_wrapper.dart';

const String _kFavouriteHotelTileKey = 'favourite_hotel_tile_key';
const String _kHeartIconButtonKey = 'heart_icon_button_key';
const String _kFavouriteAllTileKey = 'favourite_all_tile_key';
const String _kFavouriteCarTileKey = 'favourite_car_tile_key';
const String _kFavouriteTourTileKey = 'favourite_tour_tile_key';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  Widget widget = ProviderInitializer(
    MaterialApp(
      navigatorKey: GlobalKeys.navigatorKey,
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
              AppRoutes.otaFavouritesListingScreen,
            ),
          );
        }),
      ),
    ),
  );

  group("Hotel Favourites List", () {
    SharedPreferences.setMockInitialValues({"": ""});
    FavouritesRepositoryImpl.setMockInternet(InternetConnectionInfoMocked());
    FavouritesAllRepositoryImpl.setMockInternet(InternetConnectionInfoMocked());
    FavouritesCarRentalRepositoryImpl.setMockInternet(
        InternetConnectionInfoMocked());

    testWidgets('Favourites Hotel List Widget With Empty data',
        (WidgetTester tester) async {
      FavouritesRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result:
            jsonDecode(FavouritesMockDataSourceImpl.getHotelEmptyMockData()),
      ));
      await tester.runAsync(() async {
        Widget widget = ProviderInitializer(
          getMaterialWrapper(
            const OtaFavouritesListingScreen(),
          ),
        );
        await tester.pumpWidget(widget);
        await tester.pump();
        await tester.pump();
        await tester.tap(find.byType(FavouritesOptions));
        await tester.pump();
        await tester.tap(find.byKey(const Key("hotel_key")));
        await tester.pump();
      });
    });

    testWidgets('Favourites Hotel List Widget With failure',
        (WidgetTester tester) async {
      FavouritesRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(exception: OperationException()));
      await tester.runAsync(() async {
        Widget widget = ProviderInitializer(
          getMaterialWrapper(
            const OtaFavouritesListingScreen(),
          ),
        );
        await tester.pumpWidget(widget);
        await tester.pump();
        await tester.pump();
        await tester.tap(find.byType(FavouritesOptions));
        await tester.pump();
        await tester.tap(find.byKey(const Key("hotel_key")));
        await tester.pump();
      });
    });
    testWidgets('Favourites Hotel List Widget With Success',
        (WidgetTester tester) async {
      FavouritesRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(FavouritesMockDataSourceImpl.getTourMockData()),
      ));
      await tester.runAsync(() async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await tester.pump();
        await tester.tap(find.byType(FavouritesOptions));
        await tester.pump();
        await tester.tap(find.byKey(const Key("hotel_key")));
        await tester.pump();
        await tester.tap(find.byKey(const Key(_kHeartIconButtonKey)).first);
        await tester.pump();
        await tester.tap(find.byKey(const Key(_kFavouriteHotelTileKey)).first);
      });
    });
  });

  group("All Favourites List", () {
    SharedPreferences.setMockInitialValues({"": ""});
    SharedPreferences.setMockInitialValues({"": ""});
    FavouritesRepositoryImpl.setMockInternet(InternetConnectionInfoMocked());
    FavouritesAllRepositoryImpl.setMockInternet(InternetConnectionInfoMocked());
    FavouritesCarRentalRepositoryImpl.setMockInternet(
        InternetConnectionInfoMocked());
    testWidgets('All Favourites List Widget With Empty data',
        (WidgetTester tester) async {
      FavouritesAllRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result:
            jsonDecode(FavouritesAllMockDataSourceImpl.getAllMockEmptyData()),
      ));
      await tester.runAsync(() async {
        Widget widget = ProviderInitializer(
          getMaterialWrapper(
            const OtaFavouritesListingScreen(),
          ),
        );
        await tester.pumpWidget(widget);
        await tester.pump();
        await tester.tap(find.byType(FavouritesOptions));
        await tester.pump();
        await tester.tap(find.byKey(const Key("all_key")));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 1));
        await tester.pump();
      });
    });

    testWidgets('All Favourites List Widget With failure',
        (WidgetTester tester) async {
      FavouritesAllRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(exception: OperationException()));
      await tester.runAsync(() async {
        Widget widget = ProviderInitializer(
          getMaterialWrapper(
            const OtaFavouritesListingScreen(),
          ),
        );
        await tester.pumpWidget(widget);
        await tester.pump();
        await tester.pump();
        await tester.tap(find.byType(FavouritesOptions));
        await tester.pump();
        await tester.tap(find.byKey(const Key("all_key")));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 1));
        await tester.pump();
      });
    });
    testWidgets('All Favourites List Widget With Success car detail navigation',
        (WidgetTester tester) async {
      FavouritesAllRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(
            FavouritesAllMockDataSourceImpl.getAllMockDataForCarrental()),
      ));
      await tester.runAsync(() async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await tester.pump();
        await tester.tap(find.byType(FavouritesOptions));
        await tester.pump();
        await tester.tap(find.byKey(const Key("all_key")));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 1));
        await tester.pump();

        await tester.tap(find.byKey(const Key(_kFavouriteAllTileKey)).first);
        await tester.pump();
      });
    });

    testWidgets(
        'All Favourites List Widget With Success with hotel detail navigation',
        (WidgetTester tester) async {
      FavouritesAllRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(
            FavouritesAllMockDataSourceImpl.getAllMockDataForHotel()),
      ));
      await tester.runAsync(() async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await tester.pump();
        await tester.tap(find.byType(FavouritesOptions));
        await tester.pump();
        await tester.tap(find.byKey(const Key("all_key")));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 1));
        await tester.pump();

        await tester.tap(find.byKey(const Key(_kFavouriteAllTileKey)).first);
        await tester.pump();
      });
    });
    testWidgets(
        'All Favourites List Widget With Success with tour detail navigation',
        (WidgetTester tester) async {
      FavouritesAllRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result:
            jsonDecode(FavouritesAllMockDataSourceImpl.getAllMockDataForTour()),
      ));
      await tester.runAsync(() async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await tester.pump();
        await tester.tap(find.byType(FavouritesOptions));
        await tester.pump();
        await tester.tap(find.byKey(const Key("all_key")));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 1));
        await tester.pump();

        await tester.tap(find.byKey(const Key(_kFavouriteAllTileKey)).first);
        await tester.pump();
      });
    });
    testWidgets(
        'All Favourites List Widget With Success with ticket detail navigation',
        (WidgetTester tester) async {
      FavouritesAllRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(
            FavouritesAllMockDataSourceImpl.getAllMockDataForTicket()),
      ));
      await tester.runAsync(() async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await tester.pump();
        await tester.tap(find.byType(FavouritesOptions));
        await tester.pump();
        await tester.tap(find.byKey(const Key("all_key")));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 1));
        await tester.pump();

        await tester.tap(find.byKey(const Key(_kFavouriteAllTileKey)).first);
        await tester.pump();
      });
    });

    testWidgets('All Favourites List Widget With remove ticket',
        (WidgetTester tester) async {
      FavouritesAllRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(
            FavouritesAllMockDataSourceImpl.getAllMockDataForTicket()),
      ));
      FavouritesServiceRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(
            FavouritesServiceMockDataSourceImpl.removeTourMockSuccess()),
      ));
      await tester.runAsync(() async {
        Widget widget = ProviderInitializer(
          getMaterialWrapper(
            const OtaFavouritesListingScreen(),
          ),
        );
        await tester.pumpWidget(widget);
        await tester.pump();
        await tester.tap(find.byType(FavouritesOptions));
        await tester.pump();
        await tester.tap(find.byKey(const Key("all_key")));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 1));
        await tester.pump();

        await tester.tap(find.byKey(const Key(_kHeartIconButtonKey)).first);
        await tester.pump();
      });
    });
    testWidgets('All Favourites List Widget With remove car',
        (WidgetTester tester) async {
      FavouritesAllRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(
            FavouritesAllMockDataSourceImpl.getAllMockDataForCarrental()),
      ));

      FavouritesServiceRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(exception: OperationException()));
      await tester.runAsync(() async {
        Widget widget = ProviderInitializer(
          getMaterialWrapper(
            const OtaFavouritesListingScreen(),
          ),
        );
        await tester.pumpWidget(widget);
        await tester.pump();
        await tester.tap(find.byType(FavouritesOptions));
        await tester.pump();
        await tester.tap(find.byKey(const Key("all_key")));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 1));
        await tester.pump();

        await tester.tap(find.byKey(const Key(_kHeartIconButtonKey)).first);
        await tester.pump();
      });
    });
    testWidgets('All Favourites List Widget With remove Hotel',
        (WidgetTester tester) async {
      FavouritesAllRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(
            FavouritesAllMockDataSourceImpl.getAllMockDataForHotel()),
      ));

      FavouritesServiceRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(
            FavouritesServiceMockDataSourceImpl.removeFavoriteMockFailure()),
      ));
      await tester.runAsync(() async {
        Widget widget = ProviderInitializer(
          getMaterialWrapper(
            const OtaFavouritesListingScreen(),
          ),
        );
        await tester.pumpWidget(widget);
        await tester.pump();
        await tester.tap(find.byType(FavouritesOptions));
        await tester.pump();
        await tester.tap(find.byKey(const Key("all_key")));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 1));
        await tester.pump();

        await tester.tap(find.byKey(const Key(_kHeartIconButtonKey)).first);
        await tester.pump();
      });
    });
  });

  group("Car Favourites List", () {
    SharedPreferences.setMockInitialValues({"": ""});
    FavouritesRepositoryImpl.setMockInternet(InternetConnectionInfoMocked());
    FavouritesAllRepositoryImpl.setMockInternet(InternetConnectionInfoMocked());
    FavouritesCarRentalRepositoryImpl.setMockInternet(
        InternetConnectionInfoMocked());

    testWidgets('Favourites Car List Widget With Empty data',
        (WidgetTester tester) async {
      FavouritesCarRentalRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(
            FavouritesCarRentalMockDataSourceImpl.getEmptyMockData()),
      ));
      await tester.runAsync(() async {
        Widget widget = ProviderInitializer(
          getMaterialWrapper(
            const OtaFavouritesListingScreen(),
          ),
        );
        await tester.pumpWidget(widget);
        await tester.pump();
        await tester.pump();
        await tester.tap(find.byType(FavouritesOptions));
        await tester.pump();
        await tester.tap(find.byKey(const Key("car_key")));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 1));
        await tester.pump();
      });
    });

    testWidgets('Favourites Car List Widget With failure',
        (WidgetTester tester) async {
      FavouritesCarRentalRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(exception: OperationException()));
      await tester.runAsync(() async {
        Widget widget = ProviderInitializer(
          getMaterialWrapper(
            const OtaFavouritesListingScreen(),
          ),
        );
        await tester.pumpWidget(widget);
        await tester.pump();
        await tester.pump();
        await tester.tap(find.byType(FavouritesOptions));
        await tester.pump();
        await tester.tap(find.byKey(const Key("car_key")));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 1));
        await tester.pump();
      });
    });
    testWidgets('Favourites Car List Widget With Success',
        (WidgetTester tester) async {
      FavouritesCarRentalRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(FavouritesCarRentalMockDataSourceImpl.getMockData()),
      ));
      await tester.runAsync(() async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await tester.pump();
        await tester.tap(find.byType(FavouritesOptions));
        await tester.pump();
        await tester.tap(find.byKey(const Key("car_key")));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 1));
        await tester.pump();
        await tester.tap(find.byKey(const Key(_kFavouriteCarTileKey)).first);
      });
    });

    testWidgets('Favourites Car List Widget With remove car success',
        (WidgetTester tester) async {
      FavouritesCarRentalRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(FavouritesCarRentalMockDataSourceImpl.getMockData()),
      ));
      FavouritesServiceRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(
            FavouritesServiceMockDataSourceImpl.removeHotelCarMockSuccess()),
      ));
      await tester.runAsync(() async {
        Widget widget = ProviderInitializer(
          getMaterialWrapper(
            const OtaFavouritesListingScreen(),
          ),
        );
        await tester.pumpWidget(widget);
        await tester.pump();
        await tester.tap(find.byType(FavouritesOptions));
        await tester.pump();
        await tester.tap(find.byKey(const Key("car_key")));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 1));
        await tester.pump();

        await tester.tap(find.byKey(const Key(_kHeartIconButtonKey)).first);
        await tester.pump();
      });
    });
    testWidgets('Favourites Car List Widget With remove car failure',
        (WidgetTester tester) async {
      FavouritesCarRentalRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(FavouritesCarRentalMockDataSourceImpl.getMockData()),
      ));
      FavouritesServiceRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(exception: OperationException()));

      await tester.runAsync(() async {
        Widget widget = ProviderInitializer(
          getMaterialWrapper(
            const OtaFavouritesListingScreen(),
          ),
        );
        await tester.pumpWidget(widget);
        await tester.pump();
        await tester.tap(find.byType(FavouritesOptions));
        await tester.pump();
        await tester.tap(find.byKey(const Key("car_key")));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 1));
        await tester.pump();

        await tester.tap(find.byKey(const Key(_kHeartIconButtonKey)).first);
        await tester.pump();
      });
    });
  });

  group("Tour & Ticket Favourites List", () {
    SharedPreferences.setMockInitialValues({"": ""});
    FavouritesRepositoryImpl.setMockInternet(InternetConnectionInfoMocked());
    FavouritesAllRepositoryImpl.setMockInternet(InternetConnectionInfoMocked());
    FavouritesCarRentalRepositoryImpl.setMockInternet(
        InternetConnectionInfoMocked());
    testWidgets('Favourites Tour & Ticket List Widget With Empty data',
        (WidgetTester tester) async {
      FavouritesRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(
          FavouritesMockDataSourceImpl.getTourMockEmptyData(),
        ),
      ));
      await tester.runAsync(() async {
        Widget widget = ProviderInitializer(
          getMaterialWrapper(
            const OtaFavouritesListingScreen(),
          ),
        );
        await tester.pumpWidget(widget);
        await tester.pump();
        await tester.pump();
        await tester.tap(find.byType(FavouritesOptions));
        await tester.pump();
        await tester.tap(find.byKey(const Key("tour_key")));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 1));
        await tester.pump();
      });
    });

    testWidgets('Favourites Tour & Ticket List Widget With failure',
        (WidgetTester tester) async {
      FavouritesRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(exception: OperationException()));
      await tester.runAsync(() async {
        Widget widget = ProviderInitializer(
          getMaterialWrapper(
            const OtaFavouritesListingScreen(),
          ),
        );
        await tester.pumpWidget(widget);
        await tester.pump();
        await tester.pump();
        await tester.tap(find.byType(FavouritesOptions));
        await tester.pump();
        await tester.tap(find.byKey(const Key("tour_key")));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 1));
        await tester.pump();
      });
    });
    testWidgets('Favourites Tour & Ticket List Widget With Success',
        (WidgetTester tester) async {
      FavouritesRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(FavouritesMockDataSourceImpl.getTourMockData()),
      ));
      await tester.runAsync(() async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await tester.pump();
        await tester.tap(find.byType(FavouritesOptions));
        await tester.pump();
        await tester.tap(find.byKey(const Key("tour_key")));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 1));
        await tester.pump();
        await tester.tap(find.byKey(const Key(_kFavouriteTourTileKey)).first);
      });
    });
    testWidgets('Favourites Tour & Ticket List Widget With remove tour Success',
        (WidgetTester tester) async {
      FavouritesRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(FavouritesMockDataSourceImpl.getTourMockData()),
      ));
      FavouritesServiceRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(
            FavouritesServiceMockDataSourceImpl.removeTourMockSuccess()),
      ));
      await tester.runAsync(() async {
        Widget widget = ProviderInitializer(
          getMaterialWrapper(
            const OtaFavouritesListingScreen(),
          ),
        );
        await tester.pumpWidget(widget);
        await tester.pump();
        await tester.tap(find.byType(FavouritesOptions));
        await tester.pump();
        await tester.tap(find.byKey(const Key("tour_key")));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 1));
        await tester.pump();

        await tester.tap(find.byKey(const Key(_kHeartIconButtonKey)).first);
        await tester.pump();
      });
    });
    testWidgets('Favourites Tour & Ticket List Widget With remove tour failure',
        (WidgetTester tester) async {
      FavouritesRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(FavouritesMockDataSourceImpl.getTourMockData()),
      ));
      FavouritesServiceRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(exception: OperationException()));
      await tester.runAsync(() async {
        Widget widget = ProviderInitializer(
          getMaterialWrapper(
            const OtaFavouritesListingScreen(),
          ),
        );
        await tester.pumpWidget(widget);
        await tester.pump();
        await tester.tap(find.byType(FavouritesOptions));
        await tester.pump();
        await tester.tap(find.byKey(const Key("tour_key")));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 1));
        await tester.pump();

        await tester.tap(find.byKey(const Key(_kHeartIconButtonKey)).first);
        await tester.pump();
      });
    });
  });

  group("Favourites List With No Internet", () {
    testWidgets('Favourites Page internet failure',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({"": ""});
      FavouritesRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(exception: OperationException()));
      FavouritesCarRentalRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(exception: OperationException()));
      FavouritesAllRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(exception: OperationException()));

      FavouritesRepositoryImpl.setMockInternet(
          InternetConnectionInfoMockedFalse());
      FavouritesCarRentalRepositoryImpl.setMockInternet(
          InternetConnectionInfoMockedFalse());
      FavouritesAllRepositoryImpl.setMockInternet(
          InternetConnectionInfoMockedFalse());

      await tester.runAsync(() async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await Future.delayed(const Duration(milliseconds: 10));
        await tester.pumpAndSettle();
      });
    });
  });
}
