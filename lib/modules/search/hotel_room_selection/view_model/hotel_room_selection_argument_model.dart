import 'package:ota/core/app_config.dart';
import 'package:ota/modules/search/hotel_room_selection/helpers/hotel_room_selection_helper.dart';
import 'package:ota/modules/search/hotel_room_selection/view_model/hotel_room_selection_view_model.dart';

class HotelRoomSelectionArgumentModel {
  List<HotelRoomArgument>? roomList;

  HotelRoomSelectionArgumentModel({this.roomList});

  factory HotelRoomSelectionArgumentModel.getFromConfig() {
    return HotelRoomSelectionArgumentModel(
      roomList: [
        HotelRoomArgument(
          adults: AppConfig().configModel.defaultAdultCount,
          childAgeList: [],
          bedTypeKey: AppConfig().configModel.defaultAdultCount ==
                  AppConfig().configModel.bedTypeMaxAdults
              ? AppConfig().configModel.defaultBedType
              : null,
        )
      ],
    );
  }

  factory HotelRoomSelectionArgumentModel.fromViewModel(
      HotelRoomSelectionViewModel viewModel) {
    return HotelRoomSelectionArgumentModel(
      roomList:
          HotelRoomSelectionHelper.getHotelRoomArgumentList(viewModel.roomList),
    );
  }

  int getTotalAdults() {
    int adultsCount = 0;
    if (roomList != null && roomList!.isNotEmpty) {
      for (HotelRoomArgument room in roomList!) {
        adultsCount += room.adults ?? 0;
      }
    }
    return adultsCount;
  }

  int getTotalChildren() {
    int childrenCount = 0;
    if (roomList != null && roomList!.isNotEmpty) {
      for (HotelRoomArgument room in roomList!) {
        childrenCount += room.childAgeList?.length ?? 0;
      }
    }
    return childrenCount;
  }
}

class HotelRoomArgument {
  int? adults;
  String? bedTypeKey;
  List<int>? childAgeList;
  HotelRoomArgument({
    required this.adults,
    required this.childAgeList,
    this.bedTypeKey,
  });

  factory HotelRoomArgument.fromViewModel(HotelRoomViewModel viewModel) {
    return HotelRoomArgument(
      adults: viewModel.adults,
      childAgeList: viewModel.childAgeList,
      bedTypeKey: viewModel.bedTypeKey,
    );
  }
}
