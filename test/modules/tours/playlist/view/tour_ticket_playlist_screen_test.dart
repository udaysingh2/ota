import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/tours/landing/view/widgets/tour_ticket_playlist_card.dart';
import 'package:ota/modules/tours/playlist/view_model/tour_ticket_playlist_argument.dart';

import '../../../../mocks/tour/playlist/tour_and_ticket_mock.dart';

void main() {
  TourTicketPlaylistArgument playlistViewArgument =
      getTourTicketPlaylistArgumentMock();

  testWidgets('tour Ticket Playlist Screen', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(MaterialApp(
        routes: AppRoutes.getRoutes(),
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
              onPressed: () => Navigator.pushNamed(
                  context, AppRoutes.tourTicketPlaylistScreen,
                  arguments: playlistViewArgument),
            );
          }),
        ),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pump();

      await tester.pumpAndSettle();
      await tester.tap(find.byType(TourTicketPlaylistCard));
    });
  });
}