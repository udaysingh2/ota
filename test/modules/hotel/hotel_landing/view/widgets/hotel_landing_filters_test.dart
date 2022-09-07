import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_landing/bloc/hotel_landing_filters_controller.dart';
import 'package:ota/modules/hotel/hotel_landing/view/widgets/hotel_landing_filters.dart';

import '../../../../../helper/material_wrapper.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('hotel landing filters with Search icon...', (tester) async {
    Widget widget = getMaterialWrapper(HotelLandingFilters(
      leadingText: 'leading',
      hotelLandingFiltersController: HotelLandingFiltersController(),
      hotelLandingFiltersTrailingWidget:
          HotelLandingFiltersTrailingWidget.searchIcon,
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });

  testWidgets('hotel landing filters none...', (tester) async {
    Widget widget = getMaterialWrapper(HotelLandingFilters(
      leadingText: 'leading',
      hotelLandingFiltersController: HotelLandingFiltersController(),
      hotelLandingFiltersTrailingWidget: HotelLandingFiltersTrailingWidget.none,
    ));
    await tester.pumpWidget(widget);
    // await tester.tap(find.byKey(const Key("showCalender")));
    // await tester.tap(find.byKey(const Key("dateRange")));
    await tester.pumpAndSettle();
  });
}
