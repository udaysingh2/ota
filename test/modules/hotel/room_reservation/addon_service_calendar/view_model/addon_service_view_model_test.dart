import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service_calendar/view_model/addon_service_argument_model.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service_calendar/view_model/addon_service_view_model.dart';

void main() {
  test("Add on service view model test with constructor test", () {
    AddonServiceViewModel addonServiceViewModel = AddonServiceViewModel(
      title: 'Title',
      description: 'Description',
      price: 0.0,
      checkInDate: DateTime.now().add(const Duration(days: 1)),
      checkOutDate: DateTime.now().add(const Duration(days: 2)),
      noOfAdults: 1,
      uniqueId: 'UniqueId',
      imageUrl: 'ImageUrl',
      isFlight: true,
      preselectedDates: [],
    );

    expect(addonServiceViewModel.title, 'Title');
    expect(addonServiceViewModel.description, 'Description');
  });
  test("Add on service view model test with mapping test", () {
    AddonServiceCalendarArgument addonServiceCalendarArgument =
        AddonServiceCalendarArgument(
      title: 'Title',
      description: 'Description',
      price: 0.0,
      checkInDate: DateTime.now().add(const Duration(days: 1)).toString(),
      checkOutDate: DateTime.now().add(const Duration(days: 2)).toString(),
      noOfAdults: 1,
      currency: 'THB',
      uniqueId: 'UniqueId',
      imageUrl: 'ImageUrl',
      isFlight: true,
      serviceSelectedDate:
          DateTime.now().add(const Duration(days: 2)).toString(),
    );
    AddonServiceViewModel addonServiceViewModel =
        AddonServiceViewModel.mapAddOnServiceArgument(
            addonServiceCalendarArgument);

    expect(addonServiceViewModel.title, 'Title');
    expect(addonServiceViewModel.description, 'Description');
  });
}
