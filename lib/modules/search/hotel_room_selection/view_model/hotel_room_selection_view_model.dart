import 'package:ota/core/app_config.dart';
import 'package:ota/modules/search/hotel_room_selection/helpers/hotel_room_selection_helper.dart';
import 'package:ota/modules/search/hotel_room_selection/view_model/hotel_room_selection_argument_model.dart';

class HotelRoomSelectionViewModel {
  final List<HotelRoomViewModel> roomList;

  HotelRoomSelectionViewModel({
    required this.roomList,
  });

  factory HotelRoomSelectionViewModel.mapHotelRoomSelectionArgument(
      HotelRoomSelectionArgumentModel? argument) {
    return HotelRoomSelectionViewModel(
      roomList: HotelRoomSelectionHelper.getRoomViewModelList(
              argument?.roomList?.toList()) ??
          [],
    );
  }
}

class HotelRoomViewModel {
  int adults;
  String? bedTypeKey;
  final List<int> childAgeList;

  HotelRoomViewModel({
    required this.adults,
    required this.childAgeList,
    this.bedTypeKey,
  });

  factory HotelRoomViewModel.fromRoomArgument(HotelRoomArgument? argument) {
    return HotelRoomViewModel(
      adults: argument?.adults ?? 0,
      childAgeList: argument?.childAgeList?.toList() ?? [],
      bedTypeKey: argument?.bedTypeKey,
    );
  }

  factory HotelRoomViewModel.newRoom() {
    return HotelRoomViewModel(
      adults: AppConfig().configModel.defaultAdultCount,
      childAgeList: [],
      bedTypeKey: AppConfig().configModel.defaultAdultCount ==
              AppConfig().configModel.bedTypeMaxAdults
          ? AppConfig().configModel.defaultBedType
          : null,
    );
  }
}
