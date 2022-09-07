import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/domain/hotel/booking_initiate/models/argument_data_model.dart';

void main() {
  test("Add on service argument model test", () {
    RoomCapacity roomCapacity = RoomCapacity(
      adult: 1,
    );
    ReservationDataArgument reservationDataArgument = ReservationDataArgument(
      hotelId: 'HotelId',
      cityId: 'CityId',
      checkInDate: 'CheckInDate',
      checkOutDate: 'CheckOutDate',
      room: [roomCapacity],
      currency: 'TBH',
      countryId: 'CountryId',
      roomCode: 'RoomCode',
      roomCategory: 1,
      price: 0.0,
      supplierId: 'CL213',
      supplierName: 'Mark All Services Co., Ltd',
      mealCode: 'BB',
    );

    expect(reservationDataArgument.hotelId, 'HotelId');
    printDebug(roomCapacity.toMap());
  });
}
