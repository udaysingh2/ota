import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_playlist_amenities/ota_suggestion_card_with_amentities.dart';
import 'package:ota/core_pack/custom_widgets/ota_next_button.dart';
import 'package:ota/modules/landing/view/widgets/landing_playlist_widget.dart';
import 'package:ota/modules/landing/view_model/playlist_card_view_model.dart';
import 'package:ota/modules/landing/view_model/playlist_data_view_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Landing Playlist Widget", () {
    testWidgets('Landing Playlist', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            routes: AppRoutes.getRoutes(),
            home: Scaffold(
              body: SingleChildScrollView(
                child: LandingPlayListWidget(
                  playList: [
                    OtaLandingPlayListModel(
                      cardList: [
                        PlaylistCardViewModel(
                          addressText: "test",
                          cityId: "12345",
                          countryId: "12345",
                          discount: "",
                          headerText: "test",
                          hotelId: "12345",
                          imageUrl: "",
                          offerPercent: "10",
                          ratingText: "4",
                          ratingTitle: "test",
                          reviewText: "test",
                          score: "10.3",
                        )
                      ],
                    )
                  ],
                  isStatic: true,
                  onTitleArrowClick: (abc, playlistName) {},
                ),
              ),
            ),
          ),
        );
        await tester.pump();
        await tester.tap(find.byType(OtaNextButton));
        await tester.tap(find.byType(OtaSuggestionCardHorizontalAmenities));
      });
    });

    testWidgets('Landing dynamic Playlist', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            routes: AppRoutes.getRoutes(),
            home: Scaffold(
              body: SingleChildScrollView(
                child: LandingPlayListWidget(
                  playList: [
                    OtaLandingPlayListModel(
                      cardList: [
                        PlaylistCardViewModel(
                          addressText: "test",
                          cityId: "12345",
                          countryId: "12345",
                          discount: "",
                          headerText: "test",
                          hotelId: "12345",
                          imageUrl: "",
                          offerPercent: "10",
                          ratingText: "4",
                          ratingTitle: "test",
                          reviewText: "test",
                          score: "10.3",
                        )
                      ],
                    )
                  ],
                  isStatic: false,
                ),
              ),
            ),
          ),
        );
        await tester.pump();
        await tester.tap(find.byType(OtaNextButton));
        await tester.tap(find.byType(OtaSuggestionCardHorizontalAmenities));
      });
    });
  });
}
