import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_landing/bloc/car_landing_bloc.dart';
import 'package:ota/modules/car_rental/car_landing/view/widgets/car_landing_location_box.dart';
import 'package:ota/modules/car_rental/car_landing/view/widgets/car_landing_location_widget.dart';
import 'package:ota/modules/car_rental/car_landing/view_model/car_landing_view_model.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view_model/car_dates_location_update_view_model.dart';

import '../../../../../helper.dart';

void main() {
  final CarLandingBloc carLandingBloc = CarLandingBloc();
  CarDatesLocationUpdateViewModel model = CarDatesLocationUpdateViewModel();
  testWidgets('Car Landing Location Widget Test', (WidgetTester tester) async {
    carLandingBloc.updateCarRentalType(CarRentalType.carRent);
    await tester.pumpWidget(getMaterialWrapper(CarLandingLocationWidget(
      carDatesLocationUpdateViewModel: model,
      carLandingBloc: carLandingBloc,
      isLanding: true,
    )));

    await tester.pumpAndSettle();
    await tester.tap(find.byType(CarLandingLocationBox).first);
  });
  testWidgets('Car Landing Location Widget Test With Driver',
      (WidgetTester tester) async {
    carLandingBloc.updateCarRentalType(CarRentalType.carRentWithDriver);
    await tester.pumpWidget(getMaterialWrapper(CarLandingLocationWidget(
      carDatesLocationUpdateViewModel: model,
      carLandingBloc: carLandingBloc,
      isLanding: true,
    )));

    await tester.pumpAndSettle();
    await tester.tap(find.byType(CarLandingLocationBox).last);
  });
}
