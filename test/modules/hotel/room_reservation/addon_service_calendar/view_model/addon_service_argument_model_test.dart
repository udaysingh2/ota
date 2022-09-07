import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service_calendar/view_model/addon_service_argument_model.dart';

void main() {
  test("Add on service argument model test", () {
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
    );

    expect(addonServiceCalendarArgument.title, 'Title');
    expect(addonServiceCalendarArgument.description, 'Description');
  });
}
