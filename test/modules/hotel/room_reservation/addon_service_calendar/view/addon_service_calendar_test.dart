import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service_calendar/view/addon_service_calendar.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service_calendar/view_model/addon_service_argument_model.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  AddonServiceCalendarArgument addonServiceCalendarArgument =
      AddonServiceCalendarArgument(
    title: 'Title',
    description: 'Description',
    isFlight: true,
    price: 0.0,
    checkInDate: DateTime.now().add(const Duration(days: 1)).toString(),
    checkOutDate: DateTime.now().add(const Duration(days: 2)).toString(),
    noOfAdults: 1,
    currency: 'THB',
    uniqueId: 'UniqueId',
    imageUrl: 'ImageUrl',
  );
  testWidgets('Add on service calender for add service test',
      (WidgetTester tester) async {
    Widget widget = getMaterialWrapperWithArguments(
      AddonServiceCalendar(),
      AppRoutes.addonServiceCalendarScreen,
      addonServiceCalendarArgument,
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });

  testWidgets('Add on service calender for Edit/Delete service test',
      (WidgetTester tester) async {
    addonServiceCalendarArgument.serviceSelectedDate =
        DateTime.now().add(const Duration(days: 1)).toString();
    addonServiceCalendarArgument.quantity = 0;
    Widget widget = getMaterialWrapperWithArguments(
      AddonServiceCalendar(),
      AppRoutes.addonServiceCalendarScreen,
      addonServiceCalendarArgument,
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
