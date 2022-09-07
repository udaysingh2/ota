import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_chip_button/ota_chip_button.dart';
import 'package:ota/modules/car_rental/car_landing/bloc/car_landing_bloc.dart';
import 'package:ota/modules/car_rental/car_landing/view/widgets/car_landing_chips.dart';
import 'package:ota/modules/car_rental/car_landing/view_model/car_landing_view_model.dart';

import '../../../../../helper.dart';

void main() {
  final CarLandingBloc carLandingBloc = CarLandingBloc();
  testWidgets('Car Landing Chips Widget Test', (WidgetTester tester) async {
    carLandingBloc.updateCarRentalType(CarRentalType.carRent);
    await tester.pumpWidget(
        getMaterialWrapper(CarLandingChips(carLandingBloc: carLandingBloc)));

    await tester.pumpAndSettle();

    await tester.tap(find.byType(OtaChipButton).first);
  });
  testWidgets('Car Landing Chips Widget Test with Driver',
      (WidgetTester tester) async {
    carLandingBloc.updateCarRentalType(CarRentalType.carRentWithDriver);
    await tester.pumpWidget(
        getMaterialWrapper(CarLandingChips(carLandingBloc: carLandingBloc)));

    await tester.pumpAndSettle();
    await tester.tap(find.byType(OtaChipButton).last);
  });
}
