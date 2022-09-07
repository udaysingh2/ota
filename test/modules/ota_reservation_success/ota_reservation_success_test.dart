import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ota/common/utils/navigation_helper.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/core_pack/persistence/hive/boxes.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/car_rental/car_landing/db_models/car_recent_search_model.dart';
import 'package:ota/modules/landing/view_model/landing_page_view_model.dart';
import 'package:ota/modules/ota_reservation_success/bloc/ota_reservation_success_bloc.dart';
import 'package:ota/modules/ota_reservation_success/view_model/ota_reservation_success_argument_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../../mocks/hotel/hotel_success_payment/hotel_success_payment_mock.dart';

const String _kNavigateToLandingPageKey = 'navigateToLandingPageKey';
const String _kNavigateToActivityPageKey = 'navigateToActivityPageKey';
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    HttpOverrides.global = null;
    const MethodChannel channel =
        MethodChannel('plugins.flutter.io/path_provider_macos');
    channel.setMockMethodCallHandler((call) async {
      return ".";
    });
    await Hive.initFlutter();
    await Hive.openBox<CarRecentSearchData>(BoxKeys.kRecentSearchBox);
  });
  testWidgets('OTA reservation success for tour', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        ProviderInitializer(
          MaterialApp(
            navigatorKey: GlobalKeys.navigatorKey,
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
            localeResolutionCallback: (locale, supportedLocales) {
              return supportedLocales.elementAt(0);
            },
            home: Scaffold(
              body: Builder(builder: (context) {
                Provider.of<OtaReservationSuccessArgumentModel>(context,
                        listen: false)
                    .getFromProvider(
                  _getReservationSuccessArgumentModelForTour(),
                );
                Provider.of<LandingPageViewModel>(context).serviceList =
                    getLandingPageServiceCards();
                return TextButton(
                  child: const Text("press"),
                  onPressed: () => Navigator.pushNamed(
                      context, AppRoutes.otaReservationSuccessScreen,
                      arguments: true),
                );
              }),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key(_kNavigateToLandingPageKey)));
      await tester.pumpAndSettle();
    });
  });
  testWidgets('OTA reservation suuccess for ticket',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        ProviderInitializer(
          MaterialApp(
            navigatorKey: GlobalKeys.navigatorKey,
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
            localeResolutionCallback: (locale, supportedLocales) {
              return supportedLocales.elementAt(0);
            },
            home: Scaffold(
              body: Builder(builder: (context) {
                Provider.of<OtaReservationSuccessArgumentModel>(context,
                        listen: false)
                    .getFromProvider(
                  _getReservationSuccessArgumentModelForTicket(),
                );
                return TextButton(
                  child: const Text("press"),
                  onPressed: () => Navigator.pushNamed(
                      context, AppRoutes.otaReservationSuccessScreen,
                      arguments: true),
                );
              }),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key(_kNavigateToActivityPageKey)));
    });
  });
}

OtaReservationSuccessArgumentModel
    _getReservationSuccessArgumentModelForTour() {
  OtaReservationSuccessArgumentModel reservationArgumentModel =
      OtaReservationSuccessArgumentModel(
    id: 'Tour Id',
    serviceCardType: ServiceCardType.tour,
    bookingForTicket: false,
    providerName: 'Provider Name',
    packageName: 'Package Name',
    imageUrl: '',
    highlights: [
      Highlights(
        key: 'isNonRefund',
        value: '',
      )
    ],
    tourOrTicketsType: [
      TourOrTicketsType(
        name: 'Adult',
        price: 1500,
        count: 3,
      ),
      TourOrTicketsType(
        name: 'Child',
        price: 700,
        count: 1,
        maxAge: 8,
        minAge: 3,
      ),
    ],
    adultCount: 3,
    childCount: 1,
    bookingDate: DateTime.now().add(const Duration(days: 4)),
    noOfDays: 1,
    activityDuration: '1 hour',
  );
  return reservationArgumentModel;
}

OtaReservationSuccessArgumentModel
    _getReservationSuccessArgumentModelForTicket() {
  OtaReservationSuccessArgumentModel reservationArgumentModel =
      OtaReservationSuccessArgumentModel(
    id: 'Ticket Id',
    serviceCardType: ServiceCardType.tour,
    bookingForTicket: true,
    providerName: 'Provider Name',
    packageName: 'Package Name',
    imageUrl: 'Image Url',
    highlights: [
      Highlights(
        key: 'ticketTime',
        value: '1 hour',
      ),
      Highlights(
        key: 'isNonRefund',
        value: 'Refundable',
      ),
    ],
    tourOrTicketsType: [
      TourOrTicketsType(
        name: 'Safari world',
        price: 1500,
        count: 3,
      ),
    ],
    bookingDate: DateTime.now().add(const Duration(days: 4)),
    noOfDays: 1,
    activityDuration: '1 hour',
  );
  return reservationArgumentModel;
}
