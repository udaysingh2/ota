import 'package:flutter_test/flutter_test.dart';

import 'package:ota/modules/car_rental/car_landing/view/widgets/car_landing_driver_age_widget.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view_model/car_dates_location_update_view_model.dart';

import '../../../../../helper.dart';

void main() {
  CarDatesLocationUpdateViewModel model = CarDatesLocationUpdateViewModel();
  testWidgets('Car Landing Driver Age Widget Test',
      (WidgetTester tester) async {
    await tester.pumpWidget(getMaterialWrapper(CarLandingDriverAge(
      value: model,
    )));

    await tester.pumpAndSettle();
  });
}
