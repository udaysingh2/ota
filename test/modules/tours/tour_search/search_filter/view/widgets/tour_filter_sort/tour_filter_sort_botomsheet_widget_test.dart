import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view/widget/tour_filter_sort/tour_filter_sort_botomsheet_widget.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view/widget/tour_filter_sort/tour_filter_sort_radio_widget.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_view_model.dart';

import '../../../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Tour Filter BottomSheet Widget', (tester) async {
    Widget widget = getMaterialWrapper(TourFilterSortBottomSheetWidget(
      title: "title",
      labelList: [
        TourFilterCategoryViewModel(
            displayTitle: "Price", sortSeq: 1, categoryKey: "criteria_price")
      ],
      selectedIndex: 1,
      onPressed: (int int) {},
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(TourFilterSortRadioWidget));
    await tester.pump();
    await tester.pumpAndSettle();
  });
}
