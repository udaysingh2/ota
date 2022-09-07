import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:ota/modules/hotel/hotel_success_payment/view_model/hotel_success_payment_argument_model.dart';
import 'package:ota/modules/landing/view_model/landing_page_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../mocks/hotel/hotel_success_payment/hotel_success_payment_mock.dart';

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
  testWidgets('Hotel Succes Payment Screen ', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(ProviderInitializer(
        MaterialApp(
          navigatorKey: GlobalKeys.navigatorKey,
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
              Provider.of<HotelSuccessPaymentArgumentModel>(context,
                      listen: false)
                  .getFromProvider(getHotelSuccessPaymentArgumentModel());
              Provider.of<LandingPageViewModel>(context).serviceList =
                  getLandingPageServiceCards();
              return TextButton(
                child: const Text("press"),
                onPressed: () => Navigator.pushNamed(
                  context,
                  AppRoutes.hotelSuccessPaymentScreen,
                ),
              );
            }),
          ),
        ),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("NavigateToLandingPage")));
      await tester.pumpAndSettle();
    });
  });
}
