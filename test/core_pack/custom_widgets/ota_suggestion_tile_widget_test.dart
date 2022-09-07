import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_suggestion_tile_widget.dart';

void main() {
  testWidgets('OTA Suggestion Tile Widget with hotelSuggestion Test...',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OtaSuggestionTileWidget(
            title: 'test hotel suggestion',
            searchTileType: SuggestionTileType.hotelSuggestion,
            onSearchSuggestionTap: () {},
          ),
        ),
      ),
    );
  });
  testWidgets(
      'OTA Suggestion Tile Widget with hotelCityRecommendation and Image Test...',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OtaSuggestionTileWidget(
            title: 'test hotel recommendation',
            searchTileType: SuggestionTileType.hotelCityRecommendation,
            onSearchSuggestionTap: () {},
            imageUrl: 'imageUrl',
          ),
        ),
      ),
    );
  });
  testWidgets('OTA Suggestion Tile Widget with hotelCityRecommendation Test...',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OtaSuggestionTileWidget(
            title: 'test hotel recommendation',
            searchTileType: SuggestionTileType.hotelCityRecommendation,
            onSearchSuggestionTap: () {},
          ),
        ),
      ),
    );
  });
}
