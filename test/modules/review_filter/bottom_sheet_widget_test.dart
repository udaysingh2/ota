import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/review_filter/view/widget/bottom_sheet_widget.dart';
import 'package:ota/modules/review_filter/view_model/review_filter_view_model.dart';

void main() {
  testWidgets(
    'Bottom sheet widget test',
    (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: BottomSheetWidget(
            filterModel: [
              FilterModel(isSelected: true, name: 'Hotel'),
              FilterModel(isSelected: false, name: 'Playlist'),
              FilterModel(isSelected: false, name: 'Reviews'),
            ],
            title: 'Filter',
          ),
        ),
      ));
      await tester.pump();
      await tester.pumpAndSettle();
    },
  );
}
