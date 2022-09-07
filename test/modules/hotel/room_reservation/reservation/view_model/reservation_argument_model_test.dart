import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/modules/hotel/room_detail/view_model/room_argument_model.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/reservation_argument_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart'
    as room;
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/reservation_argument_model.dart'
    as room2;

void main() {
  ReservationArgumentModel model = getReservation();
  test('For ReservationArgumentModel class Test', () {
    final actual = ReservationArgumentModel.mapFromRoomDetailArgument(
      roomDetailArgument: getRoomDetail(),
      firstName: 'test',
    );

    expect(actual.cityId.isNotEmpty, true);
    expect(actual.price, 1000);

    ///TO check getChildCount
    final actual1 = model.getChildCount();
    expect(actual1, 2);

    ///TO check getAdultCount
    final actual2 = model.getAdultCount();
    expect(actual2, 1);

    ///TO check getAdultCount
    final actual3 = model.getRoomDataList([
      room2.Room(
        adults: 1,
        children: 2,
        childAge1: 10,
        childAge2: 12,
      ),
    ]);
    expect(actual3.length, 1);
  });
}

RoomDetailArgument getRoomDetail() => RoomDetailArgument(
      hotelId: 'hotelId',
      cityId: 'cityId',
      checkInDate: 'checkInDate',
      checkOutDate: 'checkOutDate',
      rooms: [
        room.Room(
          adults: 1,
          children: 2,
          childAge1: 10,
          childAge2: 12,
        ),
      ],
      currency: 'currency',
      countryId: 'countryId',
      roomCode: 'roomCode',
      roomCategory: 1,
      price: 1000,
      freefoodDelivery: true,
      rating: '1',
      address: 'address',
      supplierId: '123',
      supplierName: 'Mark All Services Co., Ltd',
      mealCode: 'BB',
    );

ReservationArgumentModel getReservation() => ReservationArgumentModel(
      hotelId: 'hotelId',
      cityId: 'cityId',
      rooms: [
        room2.Room(
          adults: 1,
          children: 2,
          childAge1: 10,
          childAge2: 12,
        ),
      ],
      currency: 'currency',
      countryId: 'countryId',
      roomCode: 'roomCode',
      roomCategory: 1,
      price: 1000,
      freefoodDelivery: true,
      rating: '1',
      address: 'address',
      firstName: '',
      email: '',
      mobileNumber: '',
      secondName: '',
      fromDate: Helpers().parseDateTime('2022-03-15'),
      toDate: Helpers().parseDateTime('2022-03-16'),
      supplierId: 'CL213',
      supplierName: 'Mark All Services Co., Ltd',
      mealCode: 'BB',
    );
