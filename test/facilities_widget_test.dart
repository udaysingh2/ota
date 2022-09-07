import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_next_button.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/facilities_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';

void main() {
  testWidgets('Facilities Widget test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
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
      home: const Scaffold(
        body: FacilityView(
          facilityList: {
            "AIR_COND": "Air-condition",
            "ROOM_SRV": "24 Hrs. Room Service",
            "TOILETERIES": "Toiletries",
            "CD_PLAYER": "CD Player",
            "W_INTERNET": "Wired Internet",
            "DESK": "Workdesk",
            "ALARM": "Alarm Clock",
            "SLIPPERS": "Slippers",
            "FRIDGE": "Fridge",
            "KETTLE": "Electric Kettle",
            "WIFI": "Wifi",
            "PHONE": "Telephone",
            "TUB": "Bathtub",
            "BABY_COT": "Babycot",
            "H_DRYER": "Hairdryer",
            "DEPOSIT_BOX": "Safe Deposit Box",
            "SWIMMING": null,
            "FITNESS": null,
            "PARKING": null,
            "SPA": null
          },
          facilityMain: {
            "WIFI": 1,
            "SWIM": 0,
            "FITNESS": 0,
            "RESTAURANTS": 0,
            "PARKING": 0,
            "LAUNDRY": 0,
            "ROM_SRV": 1,
            "SPA": 0
          },
        ),
      ),
      routes: AppRoutes.getRoutes(),
    ));
    await tester.pump();
    await tester.tap(find.byType(OtaNextButton));
    await tester.pumpAndSettle();
  });
}
