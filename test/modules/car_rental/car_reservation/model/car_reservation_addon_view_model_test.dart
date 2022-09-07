import 'package:flutter/material.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_add_on_view_model.dart';
import 'package:test/test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final CarReservationAddOnViewModel carReservationAddOnViewModel =
      CarReservationAddOnViewModel();

  group("CarAddOnViewTest", () {
    test("Car Reservation Add On View Model Initial Values", () {
      expect(carReservationAddOnViewModel.addOnServiceMap, {});
    });

    test("Car Reservation Add On View Model Add One Service", () {
      carReservationAddOnViewModel.putAddOn(1, 2);
      expect(carReservationAddOnViewModel.getQuantityForAddOn(1), 2);
    });

    test("Car Reservation Add On View Model Update Quantity", () {
      carReservationAddOnViewModel.putAddOn(1, 3);
      expect(carReservationAddOnViewModel.getQuantityForAddOn(1), 3);
    });

    test("Car Reservation Add On View Model Add On Available", () {
      expect(carReservationAddOnViewModel.isAddOnAvailable(1), true);
    });

    test("Car Reservation Add On View Model Add On Not Available", () {
      expect(carReservationAddOnViewModel.isAddOnAvailable(2), false);
    });

    test("Car Reservation Add On View Model Should Delete Add On", () {
      expect(carReservationAddOnViewModel.shouldDeleteAddOn(1, 0), true);
    });

    test("Car Reservation Add On View Model Delete Add On", () {
      carReservationAddOnViewModel.deleteAddOn(1);
      expect(carReservationAddOnViewModel.isAddOnAvailable(1), false);
    });
  });
}
