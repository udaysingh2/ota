import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/modules/car_rental/car_gallery/view/gallery_details/car_overlay_image_viewer.dart';
import 'package:ota/modules/car_rental/car_gallery/view_model/car_gallery_view_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group('Car Gallery Image Overlay Widget', () {
    testWidgets('car overlay image viewer ...', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(
          routes: AppRoutes.getRoutes(),
          supportedLocales: [
            Locale(
                LanguageCodes.english.code, LanguageCodes.english.countryCode),
            Locale(LanguageCodes.thai.code, LanguageCodes.thai.countryCode)
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          localeListResolutionCallback: (locales, supportedLocales) {
            return supportedLocales.elementAt(0);
          },
          home: Scaffold(
            body: Builder(builder: (context) {
              return TextButton(
                child: const Text("press"),
                onPressed: () => Navigator.push(
                    context,
                    CarOverlayImageViewer(
                      imageList: [
                        CarGalleryModel(
                            thumb:
                                'https://manage.robinhood.in.th/ImageData/Hotel/amora_neoluxe_bangkok-room2.jpg',
                            full:
                                'https://manage.robinhood.in.th/ImageData/Hotel/amora_neoluxe_bangkok-room2.jpg'),
                      ],
                      initialPage: 0,
                    )),
              );
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        expect(find.byType(Image), findsOneWidget);
      });
    });
  });
}
