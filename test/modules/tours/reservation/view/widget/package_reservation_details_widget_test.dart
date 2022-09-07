import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_reservation_details_widget.dart';
import '../../../../../helper.dart';

void main() {
  testWidgets('Package Reservation Details Widget Test', (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(PackageReservationDetailWidget(
      packageDate: DateTime.now(),
      activityDuration: "Duration",
      numberOfAdults: 5,
      numberOfChildren: 2,
      numberOfDays: "7",
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Column), findsWidgets);
  });
}