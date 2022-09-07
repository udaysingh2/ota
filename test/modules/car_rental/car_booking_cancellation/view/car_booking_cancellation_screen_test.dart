import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/car_rental/car_booking_cancellation/data_source/car_booking_cancellation_mock.dart';
import 'package:ota/domain/car_rental/car_booking_cancellation/data_source/car_booking_cancellation_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_booking_cancellation/repositories/car_booking_cancellation_repository_impl.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/bloc/car_booking_cancellation_bloc.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/view/widgets/cancellation_policy_widget.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/view_model/car_booking_cancellation_argument.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/view_model/car_booking_cancellation_argument_view_model.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/view_model/car_booking_detail_view_model.dart';

const _cancellationButton = 'CancellationButton';
const String _kOtaCancelTextWidgetKey = "otaTextWidgetKey";
const _okOtaTextButtonWidget = 'OkCancellationOrder';
const _ksec = 1;

class InternetConnectionInfoMocked extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(true);
}

class InternetConnectionInfoMockedFalse extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(false);
}

void main() {
  testWidgets('car booking cancellation screen ...', (tester) async {
    CarBookingCancellationRepositoryImpl.setMockInternet(
        InternetConnectionInfoMocked());
    Map<String, dynamic> map =
        jsonDecode(CarBookingCancellationMockDataSourceImpl.getMockData());
    Map<String, dynamic> result = {"getCarRejectBookingResponse": map};
    CarBookingCancellationBloc carBookingCancellationBloc =
        CarBookingCancellationBloc();
    CarBookingCancellationRemoteDataSourceImpl.setMock(GraphQlResponseMock(
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
              onPressed: () => Navigator.pushNamed(
                  context, AppRoutes.carBookingCancellation,
                  arguments: _getArgument()),
              child: const Text('press'));
        }),
      ),
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.text("press"));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key(_kOtaCancelTextWidgetKey)).first);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key(_cancellationButton)).first);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key(_okOtaTextButtonWidget)).first);
    await tester.pumpAndSettle(const Duration(seconds: _ksec));

    carBookingCancellationBloc.getCarBookingCancellationData(
      CarBookingCancellationArgument(
        confirmNo: 'Confirm',
        reason: 'reason',
      ),
    );
  });
  testWidgets('car booking cancellation screen ...', (tester) async {
    CarBookingCancellationRepositoryImpl.setMockInternet(
        InternetConnectionInfoMocked());
    Map<String, dynamic> map =
        jsonDecode(CarBookingCancellationMockDataSourceImpl.getMockData());
    Map<String, dynamic> result = {"getCarRejectBookingResponse": map};
    CarBookingCancellationBloc carBookingCancellationBloc =
        CarBookingCancellationBloc();
    CarBookingCancellationRemoteDataSourceImpl.setMock(GraphQlResponseMock(
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
              onPressed: () => Navigator.pushNamed(
                  context, AppRoutes.carBookingCancellation,
                  arguments: _getArgument()),
              child: const Text('press'));
        }),
      ),
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.text("press"));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key(_kOtaCancelTextWidgetKey)).first);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key(_cancellationButton)).first);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key(_okOtaTextButtonWidget)).first);
    await tester.pumpAndSettle(const Duration(seconds: _ksec));

    carBookingCancellationBloc.getCarBookingCancellationData(
      CarBookingCancellationArgument(
        confirmNo: '',
        reason: '',
      ),
    );
  });
  testWidgets("Cancellation Policy Widget", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CancellationPolicyWidget(
          cancellationPolicyDescription: 'Policy Description',
          cancellationPolicy: [
            CancellationPolicyModel(cancelDays: 5, message: "test")
          ],
        ),
      ),
    ));
    await tester.pumpAndSettle();
  });
}

CarBookingCancellationArgumentViewModel _getArgument() {
  return CarBookingCancellationArgumentViewModel(
      bookingUrn: '',
      cancellationPolicyDescription: '',
      confirmNo: '',
      pickUpDate: DateTime.now(),
      cancellationPolicyList: []);
}
