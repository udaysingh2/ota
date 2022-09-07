import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/back_button.dart';
import 'package:ota/modules/search/ota/view/widgets/ota_search_list_view_app_bar.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Ota Search List View App Bar Test', (tester) async {
    await tester.pumpWidget(getMaterialWrapper(HotelListViewAppBar(
      searchFilterText: "30 - 31 ม.ค. 2",
      totalNumOfPeople: "3",
      title: "Chaing mai",
      onTapFilter: () {},
      onTapSearch: () {},
    )));
    await tester.pumpAndSettle();
    expect(find.byType(Row), findsWidgets);
    await tester.tap(find.byType(BackNavigationButton));
  });
}
