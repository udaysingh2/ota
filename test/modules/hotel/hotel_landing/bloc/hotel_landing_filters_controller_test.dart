import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_landing/bloc/hotel_landing_filters_controller.dart';

void main() {
  HotelLandingFiltersController controller = HotelLandingFiltersController();

  test('For HotelLandingFiltersController ==> initDefaultValue()', () {
    ///default
    expect(controller.initDefaultValue(), "");
  });

  test('For HotelLandingFiltersController ==> setText()', () {

    ///controller setText()
    controller.setText('OTA');
    expect(controller.state.isNotEmpty, true);
    expect(controller.state, 'OTA');
  });

  test('For HotelLandingFiltersController ==> isEmpty()', () {

    ///controller isEmpty()
    controller.isEmpty();
    expect(controller.state.isNotEmpty, true);
  });
}
