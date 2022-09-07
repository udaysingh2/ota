import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/room_gallery/view/gallery_details/hotel_room_overlay_image_viewer.dart';

void main() {
  group('Hotel room overlay image viewer Widget Test', () {
    testWidgets('initial page 0', (tester) async {
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
              onPressed: () =>
                  Navigator.push(context,
            HotelRoomOverlayImageViewer(
            imageList: [],
            initialPage: 1,
            ),),
            );
          }),
        ),
      ));
      await tester.pumpAndSettle();
    });

  });
}
