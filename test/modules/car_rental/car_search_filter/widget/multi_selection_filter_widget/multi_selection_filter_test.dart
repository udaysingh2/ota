import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view_model/car_search_result_view_model.dart';
import 'package:ota/modules/car_rental/car_search_filter/view/widget/multi_selection_filter_widget/multi_selection_filter.dart';
import 'package:ota/modules/car_rental/car_search_filter/view/widget/multi_selection_filter_widget/multi_selection_filter_controller.dart';
import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Multi Selection Filter Test', (WidgetTester tester) async {
    final MultiSelectionFilterController multiSelectionFilterController =
        MultiSelectionFilterController();
    Widget widget = getMaterialWrapper(
      MultiSelectionFilter(
        title: "title",
        filterModel: [
          FilterViewModel(id: '1', name: "CarBrandName1"),
          FilterViewModel(id: '2', name: "CarBrandName2")
        ],
        description: "Description",
        multiSelectionFilterController: multiSelectionFilterController,
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    multiSelectionFilterController.updateViewState();
    await tester.pumpAndSettle();
    multiSelectionFilterController.updateIdsState("1");
    await tester.pumpAndSettle();
    multiSelectionFilterController.updateIdsState("1");
    await tester.pumpAndSettle();
    await tester.tap(find.byType(TextButton));
    multiSelectionFilterController.resetState();
  });
}
