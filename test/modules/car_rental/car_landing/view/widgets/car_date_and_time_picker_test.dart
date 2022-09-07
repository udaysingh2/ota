import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_landing/view/widgets/car_date_and_time_picker.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view_model/car_dates_location_update_view_model.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Car Date Time Picker Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final today = DateTime.now();
    final checkinDate = DateTime(today.year, today.month + 1, 1);
    final checkoutDate = DateTime(today.year, today.month + 10, 1);
    CarDatesLocationUpdateViewModel carDatesLocationUpdateViewModel =
        CarDatesLocationUpdateViewModel();

    Widget widget = getMaterialWrapper(CarDateTimePicker(
      isLanding: false,
      value: carDatesLocationUpdateViewModel,
    ));
    carDatesLocationUpdateViewModel.updateCarDate(checkinDate, checkoutDate);
    carDatesLocationUpdateViewModel.updateIsRecentSearch(true);
    carDatesLocationUpdateViewModel.updateCarDateRecentSearch(
        checkinDate, checkoutDate);
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
