import 'package:ota/domain/hotel/room_detail/models/room_detail_model.dart';

class RoomCategoryViewModel {
  final String noOfRoomsAndName;
  final String roomName;
  final String roomType;
  final int roomCount;

  RoomCategoryViewModel({
    required this.noOfRoomsAndName,
    required this.roomCount,
    required this.roomName,
    required this.roomType,
  });

  factory RoomCategoryViewModel.fromRoomCategory(RoomCategory? roomCategory) {
    return RoomCategoryViewModel(
      noOfRoomsAndName: roomCategory?.noOfRoomsAndName ?? '',
      roomName: roomCategory?.roomName ?? '',
      roomType: roomCategory?.roomType ?? '',
      roomCount: roomCategory?.noOfRooms ?? 0,
    );
  }
}
