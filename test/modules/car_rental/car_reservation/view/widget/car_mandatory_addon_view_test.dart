import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/utils/navigation_helper.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/car_rental/car_reservation/bloc/car_reservation_bloc.dart';
import 'package:ota/modules/car_rental/car_reservation/view/widgets/car_mandatory_addon_view.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_view_model.dart';

const kMinusIcon = "assets/images/icons/minus_icon.svg";

final CarReservationBloc _carReservationBloc = CarReservationBloc();
final List<ExtraChargeData> listOfExtraCharge = [
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
      extraChargeGroup:
          ExtraChargeGroupData(id: 1, name: 'name', description: 'description'))
];

void main() {
  group("CarMandatoryAddonView Widget", () {
    testWidgets('CarMandatoryAddonView Widget Test True',
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
            return CarMandatoryAddonView(
                listOfExtraCharge, _carReservationBloc);
          })),
        ),
      ));
      await tester.pump();
      await tester.pump();
      await tester.pump();
    });
  });
}
