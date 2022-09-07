import 'package:ota/modules/search/filters/view_model/filter_argument.dart';
import 'package:ota/modules/search/hotel_room_selection/view_model/hotel_room_selection_argument_model.dart';
import 'package:ota/modules/search/hotel_room_selection/view_model/hotel_room_selection_view_model.dart';

class HotelRoomSelectionHelper {
  static List<HotelRoomViewModel>? getRoomViewModelList(
      List<HotelRoomArgument>? roomList) {
    List<HotelRoomViewModel>? roomViewModelList;
    if (roomList == null || roomList.isEmpty) return roomViewModelList;

    roomViewModelList = List<HotelRoomViewModel>.generate(
      roomList.length,
      (index) => HotelRoomViewModel.fromRoomArgument(roomList[index]),
    );
    return roomViewModelList;
  }

  static List<HotelRoomArgument>? getHotelRoomArgumentList(
      List<HotelRoomViewModel>? roomViewModelList) {
    List<HotelRoomArgument>? roomList;
    if (roomViewModelList == null || roomViewModelList.isEmpty) return roomList;

    roomList = List<HotelRoomArgument>.generate(
      roomViewModelList.length,
      (index) => HotelRoomArgument.fromViewModel(roomViewModelList[index]),
    );
    return roomList;
  }

  static List<RoomArgument>? getRoomArgumentList(
      List<HotelRoomArgument>? hotelRoomList) {
    List<RoomArgument>? roomList;
    if (hotelRoomList == null || hotelRoomList.isEmpty) return roomList;

    roomList = List<RoomArgument>.generate(
      hotelRoomList.length,
      (index) => RoomArgument(
        adults: hotelRoomList[index].adults,
        childAgeList: hotelRoomList[index].childAgeList,
        bedTypeKey: hotelRoomList[index].bedTypeKey,
      ),
    );
    return roomList;
  }

  static List<HotelRoomArgument>? getHotelRoomArguments(
      List<RoomArgument>? roomArguemntList) {
    List<HotelRoomArgument>? hotelRoomList;
    if (roomArguemntList == null || roomArguemntList.isEmpty) {
      return hotelRoomList;
    }
    hotelRoomList = List<HotelRoomArgument>.generate(
      roomArguemntList.length,
      (index) => HotelRoomArgument(
        adults: roomArguemntList[index].adults,
        childAgeList: roomArguemntList[index].childAgeList,
        bedTypeKey: roomArguemntList[index].bedTypeKey,
      ),
    );
    return hotelRoomList;
  }
}
