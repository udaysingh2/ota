import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_reservation_info.dart';

import '../../../../../helper.dart';

void main() {
  testWidgets('Package Reservation Info Widget Test',
      (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(const PackageReservationInfo(
      adultPricePerNight: 400,
      childCount: 3,
      imageUrl: "imageUrl",
      packageName: "Package Name",
      tourName: "Tour Name",
      childrenPricePerNight: 200,
      facilityMap: [],
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Column), findsWidgets);
  });
}
