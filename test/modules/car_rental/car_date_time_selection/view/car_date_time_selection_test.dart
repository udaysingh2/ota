import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/car_rental/car_date_time_selection/model/car_date_time_selection_argument_model.dart';
import 'package:ota/modules/car_rental/car_date_time_selection/view/car_date_time_selection.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  testWidgets('car Date Range Picker widget', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(MaterialApp(
        routes: {
          "carDateRangePicker": (context) => const CarDateTimeSelectionScreen(),
        },
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
              onPressed: () =>
                  Navigator.pushNamed(context, "carDateRangePicker",
                      arguments: CarDateTimePickerArgumentModel(
                        dropOffDate: DateTime.now(),
                        pickUpDate: DateTime.now(),
                      )),
            );
          }),
        ),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pumpAndSettle();
    });
  });

  test('Car Date Time Selection Argument Model test', () {
    DateTime dateTime1 = DateTime.now();
    DateTime dateTime2 = DateTime.now().add(const Duration(days: 5));
    CarDateTimePickerArgumentModel(
        dropOffDate: dateTime1, pickUpDate: dateTime2);
    CarDateTimePickerArgumentModel.from(dateTime1, dateTime2);
    CarDateTimePickerArgumentModel.from(null, null);
  });
}
