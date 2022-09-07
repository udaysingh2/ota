import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/car_rental/car_rental_booking_detail/data_sources/car_booking_detail_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_rental_booking_detail/repositories/car_booking_detail_repository_impl.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/view/widget/bottom_function.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/view_model/car_booking_detail_argument_model.dart';
import '../../../../mocks/fixture_reader.dart';
import '../../../hotel/repositories/internet_success_mock.dart';

const String _kBackIconKey = "back_icon_key";
const String _kBookingDetailListKey = "booking_detail_list_key";
const String _kCancelButtonKey = 'cancel_button_key';
const String _kMessageButtonKey = 'message_button_key';
const String _kCallButtonKey = 'call_button_key';
const String _kReserveAgainKey = "reserve_again_key";
const String _kCarRentalDetailKey = "car_rental_detail_key";
const String _kCarDetailViewlKey = "car_detail_view_key";
const String _kCarDetailCancellationPolicyViewlKey =
    "car_detail_cancellation_policy_view_key";
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);

  group("Car Ongoing Booking Detail Screen", () {
    Map<String, dynamic> ongoingBookingData =
        json.decode(fixture("carRental/car_ongoing_booking_detail_mock.json"));
    CarBookingDetailRepositoryImpl.setMockInternet(InternetSuccessMock());
    testWidgets('Car Booking Detail Screen with No data',
        (WidgetTester tester) async {
      CarBookingDetailRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(result: {"otaBookingDetailsV2": null}));

      await tester.runAsync(() async {
        await tester.pumpWidget(
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
              body: Builder(
                builder: (context) {
                  return TextButton(
                    child: const Text("press"),
                    onPressed: () => Navigator.pushNamed(
                      context,
                      AppRoutes.carBookingDetail,
                      arguments: CarBookingDetailArgumentModel(
                        bookingId: "B2CMMA220210007",
                        bookingUrn: "TR220302-AA-0005",
                        bookingType: "CARRENTAL",
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_kBackIconKey)));
        await tester.pumpAndSettle();
      });
    });
    testWidgets('Car Ongoing Booking Detail Screen with Success data',
        (WidgetTester tester) async {
      CarBookingDetailRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(result: ongoingBookingData));

      await tester.runAsync(() async {
        await tester.pumpWidget(
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
              body: Builder(
                builder: (context) {
                  return TextButton(
                    child: const Text("press"),
                    onPressed: () => Navigator.pushNamed(
                      context,
                      AppRoutes.carBookingDetail,
                      arguments: CarBookingDetailArgumentModel(
                        bookingId: "B2CMMA220210007",
                        bookingUrn: "TR220302-AA-0005",
                        bookingType: "CARRENTAL",
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await tester.pumpAndSettle();

        await tester.dragUntilVisible(
          find.byKey(const Key(_kCarRentalDetailKey)),
          find.byKey(const Key(_kBookingDetailListKey)),
          const Offset(0, -100),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_kCarRentalDetailKey)));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_kBackIconKey)));
        await tester.pumpAndSettle();

        await tester.dragUntilVisible(
          find.byKey(const Key(AppLocalizationsStrings.includeLabel)),
          find.byKey(const Key(_kBookingDetailListKey)),
          const Offset(0, -100),
        );
        await tester.pumpAndSettle();

        await tester
            .tap(find.byKey(const Key(AppLocalizationsStrings.includeLabel)));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_kBackIconKey)));
        await tester.pumpAndSettle();

        await tester.dragUntilVisible(
          find.byKey(const Key(_kCancelButtonKey)),
          find.byKey(const Key(_kBookingDetailListKey)),
          const Offset(0, -100),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_kCallButtonKey)));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_kMessageButtonKey)));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_kBackIconKey)));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_kCancelButtonKey)));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_kBackIconKey)));
        await tester.pumpAndSettle();
      });
    });

    testWidgets('Car Booking Detail Screen with failure data',
        (WidgetTester tester) async {
      CarBookingDetailRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(exception: OperationException()));
      await tester.runAsync(() async {
        await tester.pumpWidget(
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
              body: Builder(
                builder: (context) {
                  return TextButton(
                    child: const Text("press"),
                    onPressed: () => Navigator.pushNamed(
                      context,
                      AppRoutes.carBookingDetail,
                      arguments: CarBookingDetailArgumentModel(
                        bookingId: "B2CMMA220210007",
                        bookingUrn: "TR220302-AA-0005",
                        bookingType: "CARRENTAL",
                      ),
                    ),
                  );
                },
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
  });

  group("Car Cancelled Booking Detail Screen", () {
    Map<String, dynamic> cancelledBookingData = json
        .decode(fixture("carRental/car_cancelled_booking_detail_mock.json"));
    CarBookingDetailRepositoryImpl.setMockInternet(InternetSuccessMock());

    testWidgets('Car Cancelled Booking Detail Screen with Success data',
        (WidgetTester tester) async {
      CarBookingDetailRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(result: cancelledBookingData));

      await tester.runAsync(() async {
        await tester.pumpWidget(
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
              body: Builder(
                builder: (context) {
                  return TextButton(
                    child: const Text("press"),
                    onPressed: () => Navigator.pushNamed(
                      context,
                      AppRoutes.carBookingDetail,
                      arguments: CarBookingDetailArgumentModel(
                        bookingId: "B2CMMA220210007",
                        bookingUrn: "TR220302-AA-0005",
                        bookingType: "CARRENTAL",
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await tester.pumpAndSettle();

        await tester.dragUntilVisible(
          find.byKey(const Key(_kCarDetailViewlKey)),
          find.byKey(const Key(_kBookingDetailListKey)),
          const Offset(0, -100),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_kCarDetailViewlKey)));
        await tester.pumpAndSettle();

        await tester.dragUntilVisible(
          find.byKey(const Key(_kCarDetailCancellationPolicyViewlKey)),
          find.byKey(const Key(_kBookingDetailListKey)),
          const Offset(0, -100),
        );
        await tester.pumpAndSettle();

        await tester
            .tap(find.byKey(const Key(_kCarDetailCancellationPolicyViewlKey)));
        await tester.pumpAndSettle();

        await tester.dragUntilVisible(
          find.byType(BottomFunction),
          find.byKey(const Key(_kBookingDetailListKey)),
          const Offset(0, -100),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_kReserveAgainKey)));
      });
    });
  });
}
