import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service/view_model/hotel_service_view_argument.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/adons_view_model.dart';

void main() {
  test("Hotel service view argument test", () {
    AddonServiceModel addonServiceModel = AddonServiceModel(
      selectedDate: DateTime.now().add(const Duration(days: 1)),
      serviceId: 'ServiceId',
    );

    HotelServiceViewArgument hotelServiceViewArgument =
        HotelServiceViewArgument(
      hotelId: 'HotelId',
      checkInDate: DateTime.now().add(const Duration(days: 1)).toString(),
      checkOutDate: DateTime.now().add(const Duration(days: 2)).toString(),
      currency: 'TBH',
      selectedAddons: [addonServiceModel],
      noOfAdults: 1,
    );
    expect(hotelServiceViewArgument.hotelId, 'HotelId');
    expect(HotelServiceViewArgument.getDummy().hotelId, 'MA0711050518');
  });

  test("Hotel service view argument test", () {
    AddonsModel addonsModel = AddonsModel(
      uniqueId: 'UniqueId1',
      isFlight: true,
      selectedDate: DateTime.now().add(const Duration(days: 1)),
    );
    HotelServiceViewArgument hotelServiceViewArgument =
        HotelServiceViewArgument.from(
      'HotelId',
      DateTime.now().add(const Duration(days: 1)),
      DateTime.now().add(const Duration(days: 2)),
      'TBH',
      1,
      [addonsModel],
      (addonServiceModel) => printDebug(addonServiceModel),
    );
    expect(hotelServiceViewArgument.hotelId, 'HotelId');
  });
}
