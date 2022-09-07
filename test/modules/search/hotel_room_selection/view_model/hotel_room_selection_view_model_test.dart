import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/search/hotel_room_selection/view_model/hotel_room_selection_argument_model.dart';
import 'package:ota/modules/search/hotel_room_selection/view_model/hotel_room_selection_view_model.dart';

void main() {
  testWidgets('Hotel Room Selection view model ...', (tester) async {
    HotelRoomSelectionArgumentModel filterArgument =
        HotelRoomSelectionArgumentModel.getFromConfig();
    HotelRoomSelectionViewModel filterViewModel =
        HotelRoomSelectionViewModel.mapHotelRoomSelectionArgument(
            filterArgument);
    expect(filterViewModel.roomList.length, 1);

    expect(HotelRoomViewModel.newRoom().adults, 2);
    expect(HotelRoomViewModel.newRoom().childAgeList, []);

    HotelRoomSelectionArgumentModel filterArgument1 =
        HotelRoomSelectionArgumentModel.getFromConfig();
    filterArgument1.roomList = null;
    HotelRoomSelectionViewModel filterViewModel1 =
        HotelRoomSelectionViewModel.mapHotelRoomSelectionArgument(
            filterArgument1);
    expect(filterViewModel1.roomList.length, 0);
  });
}
