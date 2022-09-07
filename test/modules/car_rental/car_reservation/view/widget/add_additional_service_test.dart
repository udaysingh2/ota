import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/utils/navigation_helper.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_view_model.dart';

//TODO this will be done by saheb need to solve some issue in this
void main() {
  testWidgets('Addon Screen Test', (tester) async {
    List<ExtraChargeData>? extraChargesData = [];
    ExtraChargeGroupData extraChargeGroup =
    ExtraChargeGroupData(id: 1, name: "name", description: "description");
    ExtraChargeData extraCharge = ExtraChargeData(
        id: 13,
        fromDate: DateTime.now(),
        toDate: DateTime.now(),
        extraChargeGroup: extraChargeGroup,
        price: 1000,
        isCompulsory: true,
        chargeType: 1,
        description: "description");

    extraChargesData.add(extraCharge);

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
                return TextButton(
                  child: const Text("press"),
                  onPressed: () => Navigator.pushNamed(
                      context, AppRoutes.addAdditionalAddons,
                      arguments: [extraChargesData, null]),
                );
              }),
            ),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("addOn_tile")));
        await tester.pumpAndSettle();
      });

    // List<ExtraCharge>? extraChargesData = [];
    // ExtraChargeGroup extraChargeGroup =
    //     ExtraChargeGroup(id: 1, name: "name", description: "description");
    // ExtraCharge extraCharge = ExtraCharge(
    //     id: 13,
    //     fromDate: DateTime.now(),
    //     toDate: DateTime.now(),
    //     extraChargeGroup: extraChargeGroup,
    //     price: 1000,
    //     isCompulsory: true,
    //     chargeType: 1,
    //     description: "description");

    // extraChargesData.add(extraCharge);

    // Widget widget = getMaterialWrapperWithArguments(
    //     ChangeNotifierProvider(
    //       create: (context) {
    //         return CarReservationAddOnViewModel();
    //       },
    //       builder: (_, child) {
    //         return const AddAdditionalService();
    //       },
    //     ),
    //     AppRoutes.addAdditionalAddons,
    //     [extraChargesData, null]);

    // await tester.pumpWidget(widget);
    // await tester.pumpAndSettle();
  });
}
