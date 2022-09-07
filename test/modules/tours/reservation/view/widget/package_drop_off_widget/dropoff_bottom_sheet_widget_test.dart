import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_drop_off_widget.dart/dropoff_bottom_sheet_widget.dart';
import 'package:ota/modules/tours/reservation/view_model/pickup_point_view_model.dart';

import '../../../../../../helper.dart';

void main() {
  testWidgets('Drop Off bottom sheet widget  ', (tester) async {
    await tester.pumpWidget(getMaterialWrapper(DropOffBottomSheetWidget(
      title: "Pickup Point",
      labelList: [PickupPointData(id: 'id1', name: "pick up point1")],
      selectedIndex: 1,
      onPressed: (int int) {},
    )));
    await tester.pumpAndSettle();
    expect(find.byType(Column), findsWidgets);
  });
}
