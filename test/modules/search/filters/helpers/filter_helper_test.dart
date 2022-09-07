import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/search/filters/helpers/filter_helper.dart';
import 'package:ota/modules/search/filters/view_model/filter_argument.dart';
import 'package:ota/modules/search/filters/view_model/filter_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  List<RoomViewModel> roomViewModelList = [
    RoomViewModel(adults: 2, childAgeList: [2, 3])
  ];
  List<RoomArgument> roomArgumentList = [
    RoomArgument(adults: 1, childAgeList: [1, 2]),
    RoomArgument(adults: 1, childAgeList: [1, 2, 3, 4]),
    RoomArgument(adults: 1, childAgeList: [])
  ];
  List<Room>? roomsList = [
    Room(adults: 2, children: 2, childAge1: 3, childAge2: 4),
    Room(adults: 1, children: 2, childAge1: 2, childAge2: 2)
  ];

  test("Filter helper test", () async {
    SharedPreferences.setMockInitialValues({});
    expect(FilterHelper.getRoomViewModelList(roomArgumentList) != null, true);
    expect(FilterHelper.getRoomArgumentListFromModel(roomViewModelList) != null,
        true);
    expect(FilterHelper.getRoomArgumentList(roomsList) != null, true);
    expect(
        // ignore: unnecessary_null_comparison
        FilterHelper.getHotelArgumentRoomList(roomArgumentList) != null,
        true);
  });
}
