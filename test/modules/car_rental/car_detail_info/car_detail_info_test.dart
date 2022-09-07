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
import 'package:ota/domain/landing/data_sources/landing_page_remote_data_source.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/car_rental/car_detail_info/bloc/car_detail_info_bloc.dart';
import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_argument_model.dart';
import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_view_model.dart';
import 'package:ota/modules/car_rental/car_detail_more_info/bloc/car_detail_more_info_bloc.dart';
import 'package:ota/modules/car_rental/car_detail_more_info/view_model/car_detail_more_info_argument_model.dart';
import 'package:ota/modules/car_rental/car_detail_more_info/view_model/car_detail_more_info_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  testWidgets('Landing Page internet failure', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({"": ""});
    LandingPageRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(exception: OperationException()));
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
                  context,
                  AppRoutes.carDetailInfoScreen,
                  arguments: CarDetailInfoArgumentModel(
                      carDetailInfoPickup: CarDetailInfoPickup(
                          pricing: CarDetailInfoPricing(
                              totalCost: "123", costPerDay: "123"),
                          carDetails: [],
                          carInfo: CarDetailInfoCarMainData(
                              imagePath:
                                  "https://trbhmanage.travflex.com/ImageData/Hotel/recenta_style_phuket_town-general1.jpg",
                              title: "title")),
                      carDetailInfoDropOff: CarDetailInfoDropOff(
                          carDetails: [],
                          carInfo: CarDetailInfoCarMainData(
                              imagePath: "", title: "title"),
                          pricing: CarDetailInfoPricing(
                              totalCost: "123", costPerDay: "123")),
                      carDetailInfoCarInfo: CarDetailInfoCarInfo(
                        carDetails: [],
                        pricing: CarDetailInfoPricing(
                            totalCost: "123", costPerDay: "123"),
                        facilityList: [],
                      ),
                      isPriceWidgetVisible: true,
                      carDetailInfoPickType:
                          CarDetailInfoPickType.carDetailInfoPickup,
                      pickupLocation: LocationDataModel(
                          lattitude: "13.91370000", longitude: "100.59920000"),
                      dropOffLocation: LocationDataModel(
                          lattitude: "13.91370000", longitude: "100.59920000"),
                      showMap: true),
                ),
              );
            }),
          ),
        ),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pump();
      await Future.delayed(const Duration(milliseconds: 10));
      await tester.pumpAndSettle();
    });
  });

  testWidgets('Landing Page internet failure 1', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({"": ""});
    LandingPageRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(exception: OperationException()));
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
                  context,
                  AppRoutes.carDetailInfoScreen,
                  arguments: CarDetailInfoArgumentModel(
                      carDetailInfoPickup: CarDetailInfoPickup(
                          pricing: CarDetailInfoPricing(
                              totalCost: "123", costPerDay: "123"),
                          carDetails: [],
                          carInfo: CarDetailInfoCarMainData(
                              imagePath: "", title: "title")),
                      carDetailInfoDropOff: CarDetailInfoDropOff(
                          carDetails: [],
                          carInfo: CarDetailInfoCarMainData(
                              imagePath: "", title: "title"),
                          pricing: CarDetailInfoPricing(
                              totalCost: "123", costPerDay: "123")),
                      carDetailInfoCarInfo: CarDetailInfoCarInfo(
                        carDetails: [],
                        pricing: CarDetailInfoPricing(
                            totalCost: "123", costPerDay: "123"),
                        facilityList: [],
                      ),
                      isPriceWidgetVisible: true,
                      carDetailInfoPickType:
                          CarDetailInfoPickType.carDetailInfoCarInfo,
                      pickupLocation: LocationDataModel(
                          lattitude: "13.91370000", longitude: "100.59920000"),
                      dropOffLocation: LocationDataModel(
                          lattitude: "13.91370000", longitude: "100.59920000"),
                      showMap: true),
                ),
              );
            }),
          ),
        ),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pump();
      await Future.delayed(const Duration(milliseconds: 10));
      await tester.pumpAndSettle();
    });
  });

  testWidgets('Landing Page internet failure', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({"": ""});
    LandingPageRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(exception: OperationException()));

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
                  context,
                  AppRoutes.carDetailMoreInfoScreen,
                  arguments: CarDetailMoreInfoArgumentModel(
                      carRentalConditionHtmlText: "carRentalConditionHtmlText",
                      includedInRentalPriceHtmlText:
                          "includedInRentalPriceHtmlText",
                      pickUpHtmlText: "pickUpHtmlText",
                      carDetailMoreInfoPickType:
                          CarDetailMoreInfoPickType.pickUp),
                ),
              );
            }),
          ),
        ),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pump();
      await Future.delayed(const Duration(milliseconds: 10));
      await tester.pumpAndSettle();
    });
  });

  test("Car Detail info bloc", () {
    CarDetailInfoBloc carDetailInfoBloc = CarDetailInfoBloc();
    carDetailInfoBloc.onTappedByIndex(0);
    expect(carDetailInfoBloc.state.carDetailInfoPickType,
        CarDetailInfoPickType.carDetailInfoPickup);
    carDetailInfoBloc.onTappedByIndex(1);
    expect(carDetailInfoBloc.state.carDetailInfoPickType,
        CarDetailInfoPickType.carDetailInfoDropOff);
    carDetailInfoBloc.onTappedByIndex(2);
    expect(carDetailInfoBloc.state.carDetailInfoPickType,
        CarDetailInfoPickType.carDetailInfoCarInfo);
  });

  test("Car Detail More info bloc", () {
    CarDetailMoreInfoBloc carDetailMoreInfoBloc = CarDetailMoreInfoBloc();
    carDetailMoreInfoBloc.onTappedByIndex(0);
    expect(carDetailMoreInfoBloc.state.carDetailInfoPickType,
        CarDetailMoreInfoPickType.includedInRentalPrice);
    carDetailMoreInfoBloc.onTappedByIndex(1);
    expect(carDetailMoreInfoBloc.state.carDetailInfoPickType,
        CarDetailMoreInfoPickType.carRentalCondition);
    carDetailMoreInfoBloc.onTappedByIndex(2);
    expect(carDetailMoreInfoBloc.state.carDetailInfoPickType,
        CarDetailMoreInfoPickType.pickUp);
  });
}
