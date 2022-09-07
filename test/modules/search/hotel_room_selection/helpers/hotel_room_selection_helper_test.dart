import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/search/hotel_room_selection/helpers/hotel_room_selection_helper.dart';
import 'package:ota/modules/search/hotel_room_selection/view_model/hotel_room_selection_argument_model.dart';
import 'package:ota/modules/search/hotel_room_selection/view_model/hotel_room_selection_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  List<HotelRoomViewModel> roomViewModelList = [
    HotelRoomViewModel(adults: 2, childAgeList: [2, 3])
  ];
  List<HotelRoomArgument> roomArgumentList = [
    HotelRoomArgument(adults: 1, childAgeList: [1, 2]),
    HotelRoomArgument(adults: 1, childAgeList: [1, 2, 3, 4]),
    HotelRoomArgument(adults: 1, childAgeList: [])
  ];

  test("Hotel Room Selection Filter helper test", () async {
    SharedPreferences.setMockInitialValues({});
    expect(
        HotelRoomSelectionHelper.getRoomViewModelList(roomArgumentList) != null,
        true);
    expect(
        HotelRoomSelectionHelper.getHotelRoomArgumentList(roomViewModelList) !=
            null,
        true);
    expect(
        HotelRoomSelectionHelper.getRoomArgumentList(roomArgumentList) != null,
        true);
    expect(HotelRoomSelectionHelper.getHotelRoomArguments(null) == null, true);
  });
}
