import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_drop_off_widget.dart/drop_off_option_controller.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_drop_off_widget.dart/package_drop_off_location_widget.dart';
import 'package:ota/modules/tours/reservation/view_model/pickup_point_view_model.dart';

import '../../../../../../helper.dart';

void main() {
  DropOffController controller = DropOffController();
  testWidgets('Package Drop Off location widget  ', (tester) async {
    await tester.pumpWidget(getMaterialWrapper(PackageDropOffLocationWidget(
      labelList: [PickupPointData(id: 'id1', name: "pick up point1")],
      dropOffController: controller,
    )));
    await tester.pumpAndSettle();
    expect(find.byType(Column), findsWidgets);
  });
}
