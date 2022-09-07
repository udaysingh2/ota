import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_widget.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/data_sources/car_booking_mailer_mock_data.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/data_sources/car_booking_mailer_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/repositories/car_booking_mailer_repository_impl.dart';
import 'package:ota/modules/car_rental/car_booking_mailer/view/car_booking_mailer_argument_model.dart';

import '../../../hotel/repositories/internet_success_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Car booking mailer screen", () {
    CarBookingMailerRepositoryImpl.setMockInternet(InternetSuccessMock());
    testWidgets('Car booking mailer widget', (WidgetTester tester) async {
      CarBookingMailerRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(CarBookingMailerMockDataSourceImpl.getMockData()),
      ));
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(
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
                    context, AppRoutes.carBookingMailerScreen,
                    arguments: CarBookingMailerArgumentModel(
                        bookingUrn: "B2CMMA211186303",
                        bookingConfirmNo: "B2CMMA211186303")),
              );
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(OtaTextInputWidget), 'test');
        await tester.pump(const Duration(milliseconds: 100));
        await tester.enterText(
            find.byType(OtaTextInputWidget), 'test@test.com');
        await tester.pump(const Duration(milliseconds: 100));
        await tester.tap(find.byKey(const Key('keyOk')));
        await tester.pump(const Duration(milliseconds: 100));
      });
    });

    testWidgets('Car booking mailer widget negative',
        (WidgetTester tester) async {
      CarBookingMailerRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(exception: OperationException()));
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(
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
                    context, AppRoutes.carBookingMailerScreen,
                    arguments: CarBookingMailerArgumentModel(
                        bookingUrn: "B2CMMA211186303",
                        bookingConfirmNo: "B2CMMA211186303")),
              );
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(OtaTextInputWidget), 'test');
        await tester.pump(const Duration(milliseconds: 100));
        await tester.enterText(find.byType(OtaTextInputWidget), '');
        await tester.pump(const Duration(milliseconds: 100));
        await tester.tap(find.byKey(const Key('keyOk')));
        await tester.pump(const Duration(milliseconds: 100));
      });
    });
  });
}
