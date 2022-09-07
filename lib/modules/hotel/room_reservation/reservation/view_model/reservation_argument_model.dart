import 'package:ota/common/utils/helper.dart';
import 'package:ota/domain/hotel/booking_initiate/models/argument_data_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart'
    as room;
import 'package:ota/modules/hotel/room_detail/view_model/room_argument_model.dart';

class ReservationArgumentModel {
  DateTime fromDate;
  DateTime toDate;
  String firstName;
  String secondName;
  String mobileNumber;
  String email;
  String currency;
  String countryId;
  String roomCode;
  String hotelId;
  String cityId;
  List<Room> rooms;
  int roomCategory;
  double price;
  bool freefoodDelivery;
  String address;
  String rating;
  String supplierId;
  String supplierName;
  String? mealCode;

  factory ReservationArgumentModel.mapFromRoomDetailArgument({
    required RoomDetailArgument roomDetailArgument,
    secondName = "",
    required String firstName,
    String email = "",
    String mobileNumber = "",
  }) {
    return ReservationArgumentModel(
      secondName: secondName,
      firstName: firstName,
      email: email,
      fromDate: Helpers().parseDateTime(roomDetailArgument.checkInDate),
      mobileNumber: mobileNumber,
      toDate: Helpers().parseDateTime(roomDetailArgument.checkOutDate),
      hotelId: roomDetailArgument.hotelId,
      currency: roomDetailArgument.currency,
      cityId: roomDetailArgument.cityId,
      rooms: _getRooms(roomDetailArgument.rooms),
      countryId: roomDetailArgument.countryId,
      roomCode: roomDetailArgument.roomCode,
      price: roomDetailArgument.price,
      roomCategory: roomDetailArgument.roomCategory,
      freefoodDelivery: roomDetailArgument.freefoodDelivery,
      rating: roomDetailArgument.rating,
      address: roomDetailArgument.address,
      supplierId: roomDetailArgument.supplierId,
      supplierName: roomDetailArgument.supplierName,
      mealCode: roomDetailArgument.mealCode,
    );
  }
  static List<Room> _getRooms(List<room.Room> rooms) {
    List<Room> myRooms = [];
    for (room.Room hRoom in rooms) {
      myRooms.add(Room(
        adults: hRoom.adults,
        children: hRoom.children,
        childAge1: hRoom.childAge1,
        childAge2: hRoom.childAge2,
      ));
    }
    return myRooms;
  }

  ReservationArgumentModel({
    required this.secondName,
    required this.firstName,
    required this.email,
    required this.fromDate,
    required this.mobileNumber,
    required this.toDate,
    required this.hotelId,
    required this.currency,
    required this.cityId,
    required this.rooms,
    required this.countryId,
    required this.roomCode,
    required this.price,
    required this.roomCategory,
    required this.freefoodDelivery,
    required this.rating,
    required this.address,
    required this.supplierId,
    required this.supplierName,
    required this.mealCode,
  });

  int getChildCount() {
    int count = 0;
    for (Room room in rooms) {
      count += room.children;
    }
    return count;
  }

  int getAdultCount() {
    int count = 0;
    for (Room room in rooms) {
      count += room.adults;
    }
    return count;
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

class Room {
  int adults;
  int children;
  int? childAge1;
  int? childAge2;
  Room({
    required this.adults,
    required this.children,
    this.childAge1,
    this.childAge2,
  });
}
