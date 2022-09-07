import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/back_button.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/facilities_details_widget.dart';

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
        body: FacilityDetailsView(),
      ),
      routes: AppRoutes.getRoutes(),
    ));
    await tester.pump();
    await tester.tap(find.byType(BackNavigationButton));
    await tester.pumpAndSettle();
  });
}
