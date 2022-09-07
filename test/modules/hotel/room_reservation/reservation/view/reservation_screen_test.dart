import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/get_customer_details/data_sources/customer_remote_data_source.dart';
import 'package:ota/domain/get_customer_details/data_sources/customer_remote_mock.dart';
import 'package:ota/domain/hotel/booking_initiate/data_sources/reservation_remote_data_source.dart';
import 'package:ota/domain/hotel/booking_initiate/data_sources/reservation_remote_data_source_mock.dart';
import 'package:ota/domain/hotel/booking_initiate/repositories/reservation_repository_impl.dart';
import 'package:ota/domain/hotel/hotel_addon_service/data_sources/hotel_service_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_addon_service/data_sources/hotel_service_remote_mock.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/reservation_argument_model.dart';

import '../../../repositories/internet_success_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Hotel Widget", () {
    ReservationRepositoryImpl.setMockInternet(InternetSuccessMock());
    testWidgets('Hotel detail widget', (WidgetTester tester) async {
      ReservationDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(ReservationMockDataSourceImpl.getMockData())));
      CustomerRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(CustomerMockDataSourceImpl.getMockData())));
      HotelServiceRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(HotelServicelMockDataSourceImpl.getMockData())));
      await tester.runAsync(() async {
        await tester.pumpWidget(ProviderInitializer(
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
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.reservationScreen,
                          arguments: ReservationArgumentModel(
                            address: "address",
                            rating: "rating",
                            roomCode: 'somecode',
                            email: "email@gmail.com",
                            cityId: "MA05110041",
                            countryId: "MA05110001",
                            currency: "THB",
                            firstName: "dodo",
                            secondName: "",
                            toDate: Helpers().parseDateTime("2021-12-12"),
                            fromDate: Helpers().parseDateTime("2021-11-11"),
                            hotelId: "MA0511000344",
                            mobileNumber: "9496699214",
                            freefoodDelivery: false,
                            price: 100,
                            rooms: [
                              Room(
                                adults: 2,
                                children: 2,
                                childAge1: 12,
                                childAge2: 9,
                              )
                            ],
                            roomCategory: 0,
                            supplierId: 'CL213',
                            supplierName: 'Mark All Services Co., Ltd',
                            mealCode: 'BB',
                          )),
                );
              }),
            ),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await Future.delayed(const Duration(milliseconds: 10));
        await tester.pumpAndSettle();
      });
    });

    testWidgets('Hotel detail widget', (WidgetTester tester) async {
      ReservationDataSourceImpl.setMock(
          GraphQlResponseMock(exception: OperationException()));
      await tester.runAsync(() async {
        await tester.pumpWidget(ProviderInitializer(
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
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.reservationScreen,
                          arguments: ReservationArgumentModel(
                            address: "",
                            rating: "",
                            freefoodDelivery: false,
                            roomCode: 'somecode',
                            email: "email@gmail.com",
                            cityId: "MA05110041",
                            countryId: "MA05110001",
                            currency: "THB",
                            firstName: "dodo",
                            secondName: "",
                            toDate: Helpers().parseDateTime("2021-12-12"),
                            fromDate: Helpers().parseDateTime("2021-11-11"),
                            hotelId: "MA0511000344",
                            mobileNumber: "9496699214",
                            price: 100,
                            rooms: [
                              Room(
                                adults: 2,
                                children: 2,
                                childAge1: 12,
                                childAge2: 9,
                              )
                            ],
                            roomCategory: 0,
                            supplierId: 'CL213',
                            supplierName: 'Mark All Services Co., Ltd',
                            mealCode: 'BB',
                          )),
                );
              }),
            ),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
      });
    });
  });
}
