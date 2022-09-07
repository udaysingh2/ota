import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/search/hotel_room_selection/view_model/hotel_room_selection_argument_model.dart';
import 'package:ota/modules/search/hotel_room_selection/view_model/hotel_room_selection_view_model.dart';

void main() {
  testWidgets('Hotel Room Selection argument ...', (tester) async {
    HotelRoomSelectionArgumentModel filterArgument =
        HotelRoomSelectionArgumentModel.getFromConfig();

    expect(filterArgument.roomList?.length, 1);

    HotelRoomSelectionViewModel filterViewModel =
        HotelRoomSelectionViewModel.mapHotelRoomSelectionArgument(
            filterArgument);
    HotelRoomSelectionArgumentModel filterArgument1 =
        HotelRoomSelectionArgumentModel.fromViewModel(filterViewModel);
    expect(filterArgument1.roomList?.length, 1);
  });
}
