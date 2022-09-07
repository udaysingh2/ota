import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view/widget/car_live_list_view_widget.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view/widget/car_search_suggestion_tile_widget.dart';

void main() {
  testWidgets('Car Live List View Widget Test for city...', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CarLiveListViewWidget(
          getTileWidget: (int index) {},
          suggestionList: const [],
          type: ServiceType.city,
        ),
      ),
    ));
  });

  testWidgets('Car Live List View Widget Test for location...', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CarLiveListViewWidget(
          getTileWidget: (int index) {},
          suggestionList: const [],
          type: ServiceType.location,
        ),
      ),
    ));
  });
}
