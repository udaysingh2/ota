import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_next_button.dart';
import 'package:ota/modules/tours/landing/view/widgets/tour_ticket_playlist_widget.dart';
import 'package:ota/modules/tours/landing/view_model/tour_ticket_row_playlist_view_model.dart';
import 'package:ota/modules/tours/playlist/view_model/playlist_type.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Tour Ticket Playlist Widget", () {
    testWidgets('Tour Playlist', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            routes: AppRoutes.getRoutes(),
            home: Scaffold(
              body: SingleChildScrollView(
                child: TourTicketPlaylistWidget(
                  cardList: [
                    TourTicketRowPlaylistModel(
                      cityId: "12345",
                      countryId: "12345",
                      imageUrl: "",
                      promotionTextLine1: "10",
                    ),
                  ],
                  title: 'Test',
                  playlistType: PlaylistType.tour,
                ),
              ),
            ),
          ),
        );
        await tester.pump();
        await tester.tap(find.byType(OtaNextButton));
        await tester.pump();
      });
    });
  });
}
