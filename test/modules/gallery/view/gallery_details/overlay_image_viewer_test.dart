import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/gallery/view/gallery_details/overlay_image_viewer.dart';
import 'package:ota/modules/gallery/view_model/gallery_view_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Hotel Widget", () {
    testWidgets('Hotel detail widget', (WidgetTester tester) async {
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
                  onPressed: () => Navigator.push(
                        context,
                        OverlayImageViewer(
                          imageList: [GalleryViewModel(imageUrl: 'url')],
                          initialPage: 0,
                        ),
                      ));
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
      });
    });
  });
}
