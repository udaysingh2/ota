import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/hotel/hotel_booking/data_sources/hotel_booking_list_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_booking/data_sources/hotel_booking_list_remote_mock.dart';
import 'package:ota/domain/hotel/hotel_booking/repositories/hotel_booking_list_repository_impl.dart';
import 'package:ota/modules/hotel/hotel_bookings/bloc/hotel_bookings_bloc.dart';
import 'package:ota/modules/hotel/hotel_bookings/view/hotel_bookings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../domain/ota_search_sort/repositories/ota_filter_sort_repo_test.dart';
import '../../../../helper/material_wrapper.dart';

HotelBookingsBloc bloc = HotelBookingsBloc();
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);

  group("Hotel Bookings List", () {
    SharedPreferences.setMockInitialValues({"": ""});
    HotelBookingListRepositoryImpl.setMockInternet(
        InternetConnectionInfoMocked());

    testWidgets('Hotel Booking List Widget With Data',
        (WidgetTester tester) async {
      HotelBookingListRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(
          result: jsonDecode(
            HotelBookingListMockDataSourceImpl.getMockData(),
          ),
        ),
      );

      await tester.runAsync(() async {
        Widget widget = MaterialApp(
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
          theme: ThemeData(
            primarySwatch: Colors.purple,
            fontFamily: 'Kanit',
          ),
          localeResolutionCallback: (locale, supportedLocales) {
            return supportedLocales.elementAt(1);
          },
          home: Material(
            child: HotelBookingsScreen(hotelBloc: bloc),
          ),
        );
        await tester.pumpWidget(widget);
        await tester.pump();
        await Future.delayed(const Duration(seconds: 2));
        await tester.pumpAndSettle();
      });
    });

    testWidgets('Hotel Booking List Widget With Error',
        (WidgetTester tester) async {
      HotelBookingListRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(
          result: null,
          exception: OperationException(),
        ),
      );
      await tester.runAsync(() async {
        Widget widget = getMaterialWrapper(
          HotelBookingsScreen(hotelBloc: bloc),
        );
        await tester.pumpWidget(widget);
        await tester.pump();
        await Future.delayed(const Duration(seconds: 2));
        await tester.pumpAndSettle();
      });
    });
  });
}
