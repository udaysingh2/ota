import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_chip_button/ota_chip_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/car_rental/car_reservation/data_source/car_reservation_data_source_mock.dart';
import 'package:ota/domain/car_rental/car_reservation/data_source/car_reservation_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_reservation/repositories/car_reservation_repository_impl.dart';
import 'package:ota/domain/get_customer_details/data_sources/customer_remote_data_source.dart';
import 'package:ota/domain/get_customer_details/data_sources/customer_remote_mock.dart';
import 'package:ota/domain/get_customer_details/repositories/customer_repository_impl.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_argument_view_model.dart';

import '../../../hotel/repositories/internet_success_mock.dart';

const _kReserveForOther = "reserve_for_someoneElse";

class InternetConnectionInfoMocked extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(true);
}

class InternetConnectionInfoMockedFalse extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(false);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);

  group("car Reservation Screen", () {
    CarReservationRepositoryImpl.setMockInternet(InternetSuccessMock());
    CustomerRepositoryImpl.setMockInternet(InternetSuccessMock());
  testWidgets('car reservation Screen with Success data',
      (WidgetTester tester) async {
    CarReservationRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(CarReservationMockDataSourceImpl.getMockData2())));
    CustomerRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(CustomerMockDataSourceImpl.getMockData2())));
   // mockDynamicPlaylistPageData(internetInfo: InternetSuccessMock(), remoteDataSource: CarReservationMockDataSourceImpl());
    await tester.runAsync(() async {
      await tester.pumpWidget(
        ProviderInitializer(
          MaterialApp(
            routes: AppRoutes.getRoutes(),
            supportedLocales: [
              Locale(LanguageCodes.english.code,
                  LanguageCodes.english.countryCode),
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
                      context, AppRoutes.carReservationScreen,
                      arguments: CarReservationViewArgumentModel(
                        carId: "2",
                        pickupLocationId: "MA05110001",
                        returnLocationId: "MA05110001",
                        pickupDate: Helpers().parseDateTime("2021-12-12"),
                        returnDate: Helpers().parseDateTime("2021-11-11"),
                        supplierId: "MA2111000062",
                        includeDriver: "false",
                        currency: "THB",
                        rentalType: "",
                        pickupCounter: "",
                        returnCounter: "",
                        age: 25,
                        rateKey:
                            "eNqLVjI0U9KJNjaN1THUMTLQMTPQMdAxNokFAEBXBRw=",
                        refCode: "CL213",
                        lastPrice: 1000,
                        driverAge: 30,
                        driverFirstName: 'First',
                        driverLastName: 'Last',
                        residenceCountry: 'India',
                      )),
                );
              }),
            ),
          ),
        ),
      );
      await Future.delayed(const Duration(seconds: 1));
      try{
        await tester.pumpAndSettle();
      }catch(e){
        debugPrint(e.toString());
      }
      await tester.tap(find.text("press"));
      await Future.delayed(const Duration(seconds: 1));
     // await tester.pump();
      try{
        await tester.pumpAndSettle();
      }catch(e){
        debugPrint(e.toString());
      }
      await tester.tap(find.byType(OtaChipButton));
      try{
        await tester.pumpAndSettle();
      }catch(e){
        debugPrint(e.toString());
      }
      await tester.tap(find.byKey(const Key("gesture_key")));
      try{
        await tester.pumpAndSettle();
      }catch(e){
        debugPrint(e.toString());
      }
      await tester.tap(find.byKey(const Key("pick_off_button")));
      try{
        await tester.pumpAndSettle();
      }catch(e){
        debugPrint(e.toString());
      }
      await tester.tap(find.byIcon(Icons.arrow_back_ios));
      try{
        await tester.pumpAndSettle();
      }catch(e){
        debugPrint(e.toString());
      }
      await tester.dragUntilVisible(
        find.byKey(const Key("cancel_policy")),
        find.byKey(const Key("listview_key")),
        const Offset(0, -100),
      );
      await tester.ensureVisible(find.byKey(const Key("cancel_policy")));
      try{
        await tester.pumpAndSettle();
      }catch(e){
        debugPrint(e.toString());
      }
      await tester.tap(find.byKey(const Key("cancel_policy")));
      try{
        await tester.pumpAndSettle();
      }catch(e){
        debugPrint(e.toString());
      }
      await tester.dragUntilVisible(
        find.byKey(const Key(_kReserveForOther)),
        find.byKey(const Key("listview_key")),
        const Offset(0, -100),
      );
      await tester.ensureVisible(find.byKey(const Key(_kReserveForOther)));
      try{
      await tester.pumpAndSettle();
      }catch(e){
      debugPrint(e.toString());
      }
      await tester.tap(find.byKey(const Key(_kReserveForOther)));
      try{
        await tester.pumpAndSettle();
      }catch(e){
        debugPrint(e.toString());
      }
      // await tester.dragUntilVisible(
      //   find.byKey(const Key("car_reservation_bottom_widget")),
      //   find.byKey(const Key("listview_key")),
      //   const Offset(0, -100),
      // );
      await tester.ensureVisible(find.byKey(const Key("car_reservation_bottom_widget")));
      // try{
      //   await tester.pumpAndSettle();
      // }catch(e){
      //   debugPrint(e.toString());
      // }
      await tester.tap(find.byKey(const Key("car_reservation_bottom_widget")));
      try{
        await tester.pumpAndSettle();
      }catch(e){
        debugPrint(e.toString());
      }
      // await tester.tap(find.byKey(const Key("addOn_tile")));
      // try{
      //   await tester.pumpAndSettle();
      // }catch(e){
      //   debugPrint(e.toString());
      // }
      // await tester.tap(find.byIcon(Icons.add_circle_outline_sharp));
      // await tester.pumpAndSettle();
      // await tester.tap(find.byIcon(Icons.add_circle_outline_sharp));
      // await tester.pumpAndSettle();
      // await tester.tap(find.byIcon(Icons.remove_circle_outline_sharp));
      // await tester.pumpAndSettle();
      await tester.tap(find.byType(OtaTextButton));
      try{
        await tester.pumpAndSettle();
      }catch(e){
        debugPrint(e.toString());
      }
      await tester.tap(find.byIcon(Icons.arrow_back_ios));
      await tester.pumpAndSettle();
    });
  });
  testWidgets('car reservation Screen with mocked Driver data',
      (WidgetTester tester) async {
    CarReservationRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(CarReservationMockDataSourceImpl.getMockData())));
    CustomerRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(CustomerMockDataSourceImpl.getMockData2())));
    await tester.runAsync(() async {
      await tester.pumpWidget(
        ProviderInitializer(
           MaterialApp(
            routes: AppRoutes.getRoutes(),
            supportedLocales: [
              Locale(LanguageCodes.english.code,
                  LanguageCodes.english.countryCode),
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
                      context, AppRoutes.carReservationScreen,
                      arguments: CarReservationViewArgumentModel(
                        carId: "2",
                        pickupLocationId: "MA05110001",
                        returnLocationId: "MA05110001",
                        pickupDate: Helpers().parseDateTime("2021-12-12"),
                        returnDate: Helpers().parseDateTime("2021-11-11"),
                        supplierId: "MA2111000062",
                        includeDriver: "false",
                        currency: "THB",
                        rentalType: "",
                        pickupCounter: "",
                        returnCounter: "",
                        age: 25,
                        rateKey:
                            "eNqLVjI0U9KJNjaN1THUMTLQMTPQMdAxNokFAEBXBRw=",
                        refCode: "CL213",
                        lastPrice: 1000,
                      )),
                );
              }),
            ),
          ),
        ),
      );
      await Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await Future.delayed(const Duration(seconds: 1));
      //await tester.pump();
      await tester.pumpAndSettle();
      await tester.tap(find.byType(OtaChipButton));
      await tester.pumpAndSettle();
      await tester.dragUntilVisible(
        find.byKey(const Key("cancel_policy")),
        find.byKey(const Key("listview_key")),
        const Offset(0, -100),
      );
      await tester.tap(find.byKey(const Key("cancel_policy")));
      await tester.pumpAndSettle();
      await tester.dragUntilVisible(
        find.byKey(const Key('car_guest_info')),
        find.byKey(const Key("listview_key")),
        const Offset(0, -100),
      );
      // await tester.ensureVisible(find.byKey(const Key('car_guest_info')));
      // try{
      //   await tester.pumpAndSettle();
      // }catch(e){
      //   debugPrint(e.toString());
      // }
      await tester.tap(find.byKey(const Key('car_guest_info')));
      try{
        await tester.pumpAndSettle();
      }catch(e){
        debugPrint(e.toString());
      }

    });
  });
  testWidgets('car reservation Screen with 1899 data',
      (WidgetTester tester) async {
    CarReservationRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result:
            jsonDecode(CarReservationMockDataSourceImpl.get1899MockData())));
    await tester.runAsync(() async {
      await tester.pumpWidget(
        ProviderInitializer(
           MaterialApp(
            routes: AppRoutes.getRoutes(),
            supportedLocales: [
              Locale(LanguageCodes.english.code,
                  LanguageCodes.english.countryCode),
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
                      context, AppRoutes.carReservationScreen,
                      arguments: CarReservationViewArgumentModel(
                        carId: "2",
                        pickupLocationId: "MA05110001",
                        returnLocationId: "MA05110001",
                        pickupDate: Helpers().parseDateTime("2021-12-12"),
                        returnDate: Helpers().parseDateTime("2021-11-11"),
                        supplierId: "MA2111000062",
                        includeDriver: "false",
                        currency: "THB",
                        rentalType: "",
                        pickupCounter: "",
                        returnCounter: "",
                        age: 25,
                        rateKey:
                            "eNqLVjI0U9KJNjaN1THUMTLQMTPQMdAxNokFAEBXBRw=",
                        refCode: "CL213",
                        lastPrice: 1000,
                      )),
                );
              }),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pump();
      await tester.pumpAndSettle();
    });
  });
  testWidgets('car reservation Screen with Exception data',
      (WidgetTester tester) async {
    CarReservationRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(exception: OperationException()));
    await tester.runAsync(() async {
      await tester.pumpWidget(
        ProviderInitializer(
           MaterialApp(
            routes: AppRoutes.getRoutes(),
            supportedLocales: [
              Locale(LanguageCodes.english.code,
                  LanguageCodes.english.countryCode),
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
                      context, AppRoutes.carReservationScreen,
                      arguments: CarReservationViewArgumentModel(
                        carId: "2",
                        pickupLocationId: "MA05110001",
                        returnLocationId: "MA05110001",
                        pickupDate: Helpers().parseDateTime("2021-12-12"),
                        returnDate: Helpers().parseDateTime("2021-11-11"),
                        supplierId: "MA2111000062",
                        includeDriver: "false",
                        currency: "THB",
                        rentalType: "",
                        pickupCounter: "",
                        returnCounter: "",
                        age: 25,
                        rateKey:
                            "eNqLVjI0U9KJNjaN1THUMTLQMTPQMdAxNokFAEBXBRw=",
                        refCode: "CL213",
                        lastPrice: 1000,
                      )),
                );
              }),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pump();
      await tester.pumpAndSettle();
    });
  });

  testWidgets("No Internet case", (WidgetTester tester) async {
    CarReservationRepositoryImpl.setMockInternet(
        InternetConnectionInfoMockedFalse());
    CarReservationRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(CarReservationMockDataSourceImpl.getMockData())));
    await tester.runAsync(() async {
      await tester.pumpWidget(
        ProviderInitializer(
           MaterialApp(
            routes: AppRoutes.getRoutes(),
            supportedLocales: [
              Locale(LanguageCodes.english.code,
                  LanguageCodes.english.countryCode),
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
                      context, AppRoutes.carReservationScreen,
                      arguments: CarReservationViewArgumentModel(
                        carId: "2",
                        pickupLocationId: "MA05110001",
                        returnLocationId: "MA05110001",
                        pickupDate: Helpers().parseDateTime("2021-12-12"),
                        returnDate: Helpers().parseDateTime("2021-11-11"),
                        supplierId: "MA2111000062",
                        includeDriver: "false",
                        currency: "THB",
                        rentalType: "",
                        pickupCounter: "",
                        returnCounter: "",
                        age: 25,
                        rateKey:
                            "eNqLVjI0U9KJNjaN1THUMTLQMTPQMdAxNokFAEBXBRw=",
                        refCode: "CL213",
                        lastPrice: 1000,
                        driverAge: 30,
                        driverFirstName: 'First',
                        driverLastName: 'Last',
                        residenceCountry: 'India',
                      )),
                );
              }),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pump();
      await tester.pumpAndSettle();
      await tester.tap(find.byType(OtaChipButton).first);
      await tester.pumpAndSettle();
    });
  });
  });
}
