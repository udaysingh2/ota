import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view/widget/tour_filter_sort/tour_filter_sort_controller.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view/widget/tour_filter_sort/tour_filter_sort_package_drop_off_location_widget.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_view_model.dart';

import '../../../../../../../helper/material_wrapper.dart';

void main() {
  final TourFilterSortController tourFilterSortController =
      TourFilterSortController();
  testWidgets('Tour Filter Sort Widget', (tester) async {
    Widget widget = getMaterialWrapper(TourFilterSortWidget(
      tourFilterSortController: tourFilterSortController,
      labelList: [
        TourFilterCategoryViewModel(
            displayTitle: "Ticket Style",
            sortSeq: 2,
            categoryKey: "criteria_style")
      ],
      onPressed: (int int) {},
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(InkWell).first);
    await tester.pump();
    await tester.pumpAndSettle();
  });
}
