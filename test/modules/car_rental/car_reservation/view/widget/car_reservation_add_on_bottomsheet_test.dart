import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/utils/navigation_helper.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/car_rental/car_reservation/view/widgets/car_reservation_add_on_bottomsheet.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_view_model.dart';

const kMinusIcon = "assets/images/icons/minus_icon.svg";
ExtraChargeData? extraCharge0 = ExtraChargeData(
    id: 1,
    carRateId: 2,
    fromDate: DateTime.now(),
    toDate: DateTime.now(),
    price: 10,
    isCompulsory: false,
    chargeType: 0,
    addonPriceToDisplay: 20,
    description: 'description',
    extraChargeGroup:
        ExtraChargeGroupData(id: 1, name: 'name', description: 'description'));

ExtraChargeData? extraCharge1 = ExtraChargeData(
    id: 1,
    carRateId: 2,
    fromDate: DateTime.now(),
    toDate: DateTime.now(),
    price: 10,
    isCompulsory: true,
    chargeType: 1,
    addonPriceToDisplay: 20,
    description: 'description',
    extraChargeGroup:
        ExtraChargeGroupData(id: 1, name: 'name', description: 'description'));

void main() {
  group("Car Reservation Card Widget", () {
    testWidgets('Car Reservation Card Widget Test True',
        (WidgetTester tester) async {
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
          home: Scaffold(body: Builder(builder: (context) {
            return CarReservationAddOnBottomSheet(
              extraCharge: extraCharge0,
              isEdit: false,
            );
          })),
        ),
      ));
      await tester.pumpAndSettle();
    });
    testWidgets('Car Reservation Card Widget Test True',
        (WidgetTester tester) async {
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
          home: Scaffold(body: Builder(builder: (context) {
            return CarReservationAddOnBottomSheet(
              extraCharge: extraCharge1,
              isEdit: true,
            );
          })),
        ),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('CarOtaReservationButton')));
      await tester.pumpAndSettle();
    });
  });
}
