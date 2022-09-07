import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/search/hotel_room_selection/bloc/hotel_room_selection_bloc.dart';
import 'package:ota/modules/search/hotel_room_selection/view_model/hotel_room_selection_argument_model.dart';
import 'package:ota/modules/search/hotel_room_selection/view_model/hotel_room_selection_view_model.dart';

void main() {
  HotelRoomSelectionBloc bloc = HotelRoomSelectionBloc();
  HotelRoomSelectionArgumentModel filterArgument =
      HotelRoomSelectionArgumentModel(roomList: [
    HotelRoomArgument(
      adults: 3,
      childAgeList: [1, 2, 3],
    )
  ]);
  HotelRoomSelectionViewModel model =
      HotelRoomSelectionViewModel.mapHotelRoomSelectionArgument(filterArgument);
  test('hotel room selection bloc ...', () async {
    bloc.setHotelRoomSelectionViewModelData(filterArgument);
    expect(bloc.state.roomList.length, model.roomList.length);

    bloc.addNewRoom();
    expect(bloc.state.roomList.length, 2);

    bloc.addAdult(0, 2);
    expect(bloc.state.roomList[0].adults, 2);

    bloc.addChild(1, 12);
    expect(bloc.state.roomList[0].childAgeList[1], 2);

    bloc.updateChild(0, 0, 14);
    expect(bloc.state.roomList[0].childAgeList[0], 14);

    bloc.removeChild(0);
    expect(bloc.state.roomList[0].childAgeList.length, 2);

    bloc.removeAdult(0, 1);
    expect(bloc.state.roomList[0].adults, 1);

    expect(bloc.getAdultsCount(), 3);
    expect(bloc.getChildrenCount(), 3);

    bloc.removeRoom();
    expect(bloc.state.roomList.length, 1);

    bloc.getRoomChildrenCount(0);
    expect(bloc.state.roomList[0].childAgeList.length, 2);
  });
}
