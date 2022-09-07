import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/search/filters/view_model/filter_argument.dart';
import 'package:ota/modules/search/filters/view_model/filter_view_model.dart';

class FilterHelper {
  static List<RoomViewModel>? getRoomViewModelList(
      List<RoomArgument>? roomList) {
    List<RoomViewModel>? roomViewModelList;
    if (roomList == null || roomList.isEmpty) return roomViewModelList;

    roomViewModelList = List<RoomViewModel>.generate(
      roomList.length,
      (index) => RoomViewModel.fromRoomArgument(roomList[index]),
    );
    return roomViewModelList;
  }

  static List<RoomArgument>? getRoomArgumentListFromModel(
      List<RoomViewModel>? roomModelList) {
    List<RoomArgument>? rooms;
    if (roomModelList == null || roomModelList.isEmpty) return rooms;
    rooms = List<RoomArgument>.generate(
      roomModelList.length,
      (index) => RoomArgument(
        adults: roomModelList[index].adults,
        childAgeList: roomModelList[index].childAgeList,
        bedTypeKey: roomModelList[index].bedTypeKey,
      ),
    );
    return rooms;
  }

  static List<RoomArgument>? getRoomArgumentList(List<Room>? roomList) {
    List<RoomArgument>? rooms;
    if (roomList == null || roomList.isEmpty) return rooms;
    rooms = List<RoomArgument>.generate(
      roomList.length,
      (index) => RoomArgument(
        adults: roomList[index].adults,
        childAgeList: _getChildAgeList(
          roomList[index].childAge1,
          roomList[index].childAge2,
        ),
        bedTypeKey: roomList[index].bedTypeKey,
      ),
    );
    return rooms;
  }

  static List<Room> getHotelArgumentRoomList(List<RoomArgument>? roomList) {
    List<Room>? rooms;
    if (roomList == null || roomList.isEmpty) return [];
    rooms = List<Room>.generate(
        roomList.length, (index) => getRoom(roomList[index]));
    return rooms;
  }

  static List<int> _getChildAgeList(int? childAge1, int? childAge2) {
    List<int> childAgeList = [];
    if (childAge1 != null) childAgeList.add(childAge1);
    if (childAge2 != null) childAgeList.add(childAge2);
    return childAgeList;
  }

  static Room getRoom(RoomArgument roomArgument) {
    if (roomArgument.childAgeList != null &&
        roomArgument.childAgeList!.isNotEmpty) {
      if (roomArgument.childAgeList!.length == 2) {
        return Room(
          adults: roomArgument.adults!,
          children: roomArgument.childAgeList!.length,
          childAge1: roomArgument.childAgeList![0],
          childAge2: roomArgument.childAgeList![1],
          bedTypeKey: roomArgument.bedTypeKey,
        );
      } else {
        return Room(
          adults: roomArgument.adults!,
          children: roomArgument.childAgeList!.length,
          childAge1: roomArgument.childAgeList![0],
          bedTypeKey: roomArgument.bedTypeKey,
        );
      }
    } else {
      return Room(
        adults: roomArgument.adults!,
        children: roomArgument.childAgeList!.length,
        bedTypeKey: roomArgument.bedTypeKey,
      );
    }
  }

  static String? getRoomType(String? bedTypeKey) {
    Map<String, dynamic> bedTypes = {
      'single_bed_type': 'Twin',
      "double_bed_type": 'Double',
    };
    return bedTypes[bedTypeKey];
  }
}
