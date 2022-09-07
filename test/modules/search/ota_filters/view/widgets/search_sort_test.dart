import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/search/ota_filters/view/widgets/search_sort.dart';
import 'package:ota/modules/search/ota_filters/view_model/filter_ota_view_model.dart';

void main() {
  testWidgets(
    'Search sort screen test',
    (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SearchSort(
            labelList: [
              FilterOtaViewModel(listOfSortString: [
                FilterOtaSortingData(
                    stringValue: "abc", id: 'sd', isSelected: true),
                FilterOtaSortingData(
                    stringValue: "def", id: 'td', isSelected: false)
              ]).toString()
            ],
            title: 'Sort',
            selectedIndex: 0,
          ),
        ),
      ));
      await tester.pump();
      await tester.pumpAndSettle();
    },
  );
}
