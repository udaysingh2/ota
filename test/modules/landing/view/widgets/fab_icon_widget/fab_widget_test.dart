import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/landing/view/widgets/fab_icon_widget/fab_widget.dart';
import 'package:ota/modules/landing/view/widgets/fab_icon_widget/fab_widget_controller.dart';

void main() {
  testWidgets(
    'FAB icon Collapsed Widget',
    (WidgetTester tester) async {
      FabWidgetController fabWidgetController = FabWidgetController();
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: OTAFabWidget(
            fabWidgetController: fabWidgetController,
          ),
        ),
      ));
      await tester.pump();
      expect(find.byType(OTAFabWidget), findsOneWidget);
    },
  );

  testWidgets(
    'FAB icon Expanded Widget',
    (WidgetTester tester) async {
      FabWidgetController fabWidgetController = FabWidgetController();
      fabWidgetController.setExpanded();
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
        home: Scaffold(
          body: OTAFabWidget(
            fabWidgetController: fabWidgetController,
          ),
        ),
      ));
      await tester.pump();
      await tester.tap(find.byType(OTAFabWidget));
      await tester.tap(find.text("Favourites"));
      await tester.pump();
      // await tester.tap(find.text("Payment"));
      // await tester.pump();
      await tester.tap(find.text("Activities"));
      await tester.pump();
      await tester.tap(find.text("Messages"));
      await tester.pump();
      expect(find.byType(OTAFabWidget), findsOneWidget);
    },
  );
}
