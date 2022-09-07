import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view_model/car_dates_location_update_view_model.dart';
import 'package:ota/modules/car_rental/car_landing/view_model/car_landing_view_model.dart';

void main() {
  CarDatesLocationUpdateViewModel bloc = CarDatesLocationUpdateViewModel();
  test("Car Dates Location Update View Model Test", () {
    bloc.updateCarDate(
        DateTime.now(), DateTime.now().add(const Duration(days: 1)));
    expect(bloc.pickupDate.day == DateTime.now().day, true);
    bloc.updateCarLocation(
      locationModelDropOff: LocationModel(
        locationId: 'locationIdDropOff',
        location: 'locationDropOff',
      ),
      locationModelPickup: LocationModel(
        locationId: 'locationIdPickup',
        location: 'locationPickup',
      ),
    );
    expect(bloc.pickupLocation?.locationId, 'locationIdPickup');
    expect(bloc.dropOffLocation?.locationId, 'locationIdDropOff');
    bloc.updateAge(30);
    expect(bloc.age, 30);
    bloc.updateIsDifferentDropOff(true);
    expect(bloc.isDifferentDropOff, true);
    bloc.resetValues();
    expect(bloc.isDifferentDropOff, false);
  });
}
