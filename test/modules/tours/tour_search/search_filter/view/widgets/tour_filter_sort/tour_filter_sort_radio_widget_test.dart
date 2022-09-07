import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view/widget/tour_filter_sort/tour_filter_sort_radio_widget.dart';
import '../../../../../../../helper/material_wrapper.dart';

void main(){
  testWidgets('Tour Filter Radio Widget', (tester) async {
    Widget widget = getMaterialWrapper(TourFilterSortRadioWidget(
      label: "Ticket Style",
      onClicked: (){},
      isSelected: true,
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(TourFilterSortRadioWidget));
    await tester.pump();
    await tester.pumpAndSettle();
  });
}