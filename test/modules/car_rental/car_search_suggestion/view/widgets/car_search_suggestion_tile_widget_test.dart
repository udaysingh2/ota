import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view/widget/car_search_suggestion_tile_widget.dart';

void main() {
  group("Car Search Input Suggestion Tile  Widget", () {
    testWidgets('Car Search Input Suggestion Tile Widget Test',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
            body: CarSearchSuggestionTileWidget(
          title: '',
          serviceType: null,
        )),
      ));
      await tester.pumpAndSettle();
    });
  });
}
