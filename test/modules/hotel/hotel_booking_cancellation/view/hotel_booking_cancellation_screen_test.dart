import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_model.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/hotel/hotel_booking_cancellation/data_source/hotel_booking_cancellation_mock.dart';
import 'package:ota/domain/hotel/hotel_booking_cancellation/data_source/hotel_booking_cancellation_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_booking_cancellation/repositories/hotel_booking_cancellation_repository_impl.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/hotel_booking_cancellation_argument_view_model.dart';

class InternetConnectionInfoMocked extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(true);
}

class InternetConnectionInfoMockedFalse extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(false);
}

void main() {
  testWidgets('Hotel Booking Cancellation widget test ...', (tester) async {
    HotelBookingCancellationRepositoryImpl.setMockInternet(
        InternetConnectionInfoMocked());

    Map<String, dynamic> map =
        jsonDecode(HotelBookingCancellationMockDataSourceImpl.getMockData());

    Map<String, dynamic> result = {"rejectBooking": map};

    HotelBookingCancellationRemoteDataSourceImpl.setMock(GraphQlResponseMock(
      result: result,
    ));
    await tester.pumpWidget(MaterialApp(
      routes: AppRoutes.getRoutes(),
      supportedLocales: [
        Locale(LanguageCodes.english.code, LanguageCodes.english.countryCode),
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
                context, AppRoutes.hotelBookingCancellationScreen,
                arguments: _getArgument()),
          );
        }),
      ),
    ));

    await tester.pumpAndSettle();
    await tester.tap(find.text("press"));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key("CancelReservationButton")).first);
    await tester.pumpAndSettle();
  });
}

HotelBookingCancellationArgumentViewModel _getArgument() {
  return HotelBookingCancellationArgumentViewModel(cancellationPolicyList: [
    OtaCancellationPolicyListModel(
        cancellationPolicyState: "",
        cancellationDaysDescription: "",
        cancellationChargeDescription: "")
  ], bookingUrn: ' ', bookingStatus: ' ', confirmNo: ' ');
}
