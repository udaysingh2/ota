import 'package:ota/domain/hotel/room_detail/models/argument_data_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';

class RoomDetailArgument {
  String hotelId;
  String cityId;
  String checkInDate;
  String checkOutDate;
  List<Room> rooms;
  String currency;
  String countryId;
  String roomCode;
  int roomCategory;
  double price;
  bool freefoodDelivery;
  String rating;
  String address;
  String supplierId;
  String supplierName;
  String? mealCode;
  RoomDetailArgument({
    required this.hotelId,
    required this.cityId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.rooms,
    required this.currency,
    required this.countryId,
    required this.roomCode,
    required this.roomCategory,
    required this.price,
    required this.freefoodDelivery,
    required this.rating,
    required this.address,
    required this.supplierId,
    required this.supplierName,
    required this.mealCode,
  });

  RoomDetailDataArgument toRoomDataArgument() {
    return RoomDetailDataArgument(
      hotelId: hotelId,
      cityId: cityId,
      checkInDate: checkInDate,
      checkOutDate: checkOutDate,
      room: getRoomDataList(rooms),
      currency: currency,
      countryId: countryId,
      roomCode: roomCode,
      roomCategory: roomCategory,
      price: price,
      supplierId: supplierId,
      supplierName: supplierName,
      mealCode: mealCode ?? '',
    );
  }

  List<RoomCapacity> getRoomDataList(List<Room>? rooms) {
    List<RoomCapacity> roomDataList;
    if (rooms == null || rooms.isEmpty) return [];
    roomDataList = List<RoomCapacity>.generate(
      rooms.length,
      (index) => RoomCapacity(
          adult: rooms[index].adults,
          children: rooms[index].children,
          childAge1: rooms[index].childAge1,
          childAge2: rooms[index].childAge2),
    );
    return roomDataList;
  }
}
