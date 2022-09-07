import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ota/common/utils/navigation_helper.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/promo_widget/view_model/promo_widget_view_model.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view_model/car_dates_location_update_view_model.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_add_on_view_model.dart';
import 'package:ota/modules/favourites/bloc/favourite_update.dart';
import 'package:ota/modules/hotel/hotel_detail/model/hotel_update.dart';
import 'package:ota/modules/hotel/hotel_success_payment/view_model/hotel_success_payment_argument_model.dart';
import 'package:ota/modules/landing/view_model/landing_page_view_model.dart';
import 'package:ota/modules/ota_reservation_success/view_model/ota_reservation_success_argument_model.dart';
import 'package:provider/provider.dart';

import 'mocks/fixture_reader.dart';

Widget getMaterialWrapper(Widget child) {
  return MediaQuery(
    data: const MediaQueryData(),
    child: MaterialApp(
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
        theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Kanit',
        ),
        localeResolutionCallback: (locale, supportedLocales) {
          return supportedLocales.elementAt(1);
        },
        home: Material(child: child)),
  );
}

Widget getMaterialWrapperWithPressButton(String routeName, dynamic argument) {
  return MediaQuery(
    data: const MediaQueryData(),
    child: MaterialApp(
        routes: AppRoutes.getRoutes(),
        navigatorKey: GlobalKeys.navigatorKey,
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
        theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Kanit',
        ),
        localeResolutionCallback: (locale, supportedLocales) {
          return supportedLocales.elementAt(0);
        },
        home: Scaffold(
          body: Builder(builder: (context) {
            return TextButton(
              child: const Text("press"),
              onPressed: () =>
                  Navigator.pushNamed(context, routeName, arguments: argument),
            );
          }),
        )),
  );
}

Widget getWidgetPressButtonWithProvider(String routeName, dynamic argument) {
  return MediaQuery(
    data: const MediaQueryData(),
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider<CarDatesLocationUpdateViewModel>(
            create: (context) => CarDatesLocationUpdateViewModel()),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return CarDatesLocationUpdateViewModel();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return LoginModel();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return HotelDetailStatus();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return FavouriteUpdate();
          },
        ),
        Provider(
          create: (BuildContext context) {
            return LandingPageViewModel();
          },
        ),
        Provider(
          create: (BuildContext context) {
            return HotelSuccessPaymentArgumentModel();
          },
        ),
        Provider(
          create: (BuildContext context) {
            return OtaReservationSuccessArgumentModel();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return PromoWidgetViewModel();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return CarReservationAddOnViewModel();
          },
        ),
      ],
      child: MaterialApp(
          routes: AppRoutes.getRoutes(),
          navigatorKey: GlobalKeys.navigatorKey,
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
          theme: ThemeData(
            primarySwatch: Colors.purple,
            fontFamily: 'Kanit',
          ),
          localeResolutionCallback: (locale, supportedLocales) {
            return supportedLocales.elementAt(0);
          },
          home: Scaffold(
            body: Builder(builder: (context) {
              return TextButton(
                child: const Text("press"),
                onPressed: () => Navigator.pushNamed(context, routeName,
                    arguments: argument),
              );
            }),
          )),
    ),
  );
}

Map<String, dynamic> getMockDataWithPath(String path) {
  return json.decode(fixture(path));
}

Map<String, dynamic> getMockDataWithString(String result) {
  return json.decode(result);
}
