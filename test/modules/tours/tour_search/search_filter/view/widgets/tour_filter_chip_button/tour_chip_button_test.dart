import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view/widget/tour_filter_chip_button/tour_chip_button.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_view_model.dart';

import '../../../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Tour chip Button Widget', (tester) async {
    Widget widget = getMaterialWrapper(TourChipButton(
      filterStyle: TourStyleViewModel(styleName: "styleName", isSelected: true),
      onPressed: () {},
      onSelected: (bool bool) {},
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(InkWell).first);
    await tester.pump();
    await tester.pumpAndSettle();
  });
}
