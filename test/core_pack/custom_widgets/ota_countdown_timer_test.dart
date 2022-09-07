import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_timer.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';

void main() {
  OtaCountDownController? otaCountDownController;
  group("Ota count down timer Widget", () {
    setUp(() async {
      otaCountDownController = OtaCountDownController(
          durationInSecond: 2,
          onComplete: () {
            printDebug("OtaCountDownController commplete");
          });
    });

    tearDown(() {
      otaCountDownController?.dispose();
    });

    testWidgets('Ota count down timer Widget', (WidgetTester tester) async {
      await tester.runAsync(() async {
        otaCountDownController?.startTimer();
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
              return OtaCountDownTimer(
                controller: otaCountDownController!,
              );
            }),
          ),
        ));
        await tester.pumpAndSettle();
        expect(otaCountDownController?.isTimerActive, true);
        otaCountDownController?.resetTimer();
        otaCountDownController?.reStartTimer();
        await Future.delayed(const Duration(seconds: 3));
        expect(otaCountDownController?.isTimerActive, false);
        await tester.pumpAndSettle();
      });
    });
  });
}
