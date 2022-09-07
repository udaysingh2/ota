import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/utils/navigation_helper.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/car_rental/car_payment/view/widgets/car_payment_additional_services.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_view_model.dart';

List<ExtraChargeData> listOfExtras = [
  ExtraChargeData(
      id: 1,
      carRateId: 2,
      fromDate: DateTime.now(),
      toDate: DateTime.now(),
      price: 10,
      isCompulsory: false,
      chargeType: 0,
      addonPriceToDisplay: 20,
      description: 'description',
      extraChargeGroup: ExtraChargeGroupData(
          id: 1, name: 'name', description: 'description')),
];

void main() {
  group("Car payment header Card Widget", () {
    testWidgets('CarPaymentAdditional Widget Test isCompulsory false',
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
            return CarPaymentAdditionalServices(
              extraCharge: listOfExtras,
              additionalText1: "",
              additionalText2: "",
              numberOfServices1: 2,
              showDivider: true,
              totalAdditionalServicePrice1: 20,
              numberOfDays: 2,
            );
          })),
        ),
      ));
      await tester.pump();
      await tester.pump();
      await tester.pump();
    });
    testWidgets('Car payment header Card Widget Test isCompulsory true',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: CarPaymentAdditionalServices(
        extraCharge: [
          ExtraChargeData(
              id: 1,
              carRateId: 2,
              fromDate: DateTime.now(),
              toDate: DateTime.now(),
              price: 10,
              isCompulsory: true,
              chargeType: 1,
              addonPriceToDisplay: 20,
              description: 'description',
              extraChargeGroup: ExtraChargeGroupData(
                  id: 1, name: 'name', description: 'description'))
        ],
        additionalText1: "",
        additionalText2: "",
        numberOfServices1: 2,
        showDivider: false,
        totalAdditionalServicePrice1: 20,
        numberOfDays: 2,
      ))));
      await tester.pumpAndSettle();
    });
  });
}
