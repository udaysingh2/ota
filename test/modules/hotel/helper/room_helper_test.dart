import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_detail_model.dart';
import 'package:ota/modules/hotel/hotel_detail/helpers/room_helper.dart';

void main() {
  List<Room> room = [
    Room(roomName: "name", details: [
      Detail(
        nightPrice: 290,
        totalPrice: 90.00,
        roomType: "type",
        roomCode: "asda",
        roomOfferName: "none",
        roomOffer: RoomOffer(
            cancellationPolicy: "cancellationPolicy",
            payNow: "pay now",
            breakfast: 1),
      )
    ], facility: [
      ListElement(key: "WIFI", value: "1")
    ]),
  ];
  test("Room Helper", () {
    expect(RoomHelper.generatePrimary(room) == null, false);
  });
}
