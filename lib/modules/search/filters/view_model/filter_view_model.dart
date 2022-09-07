import 'package:ota/common/utils/helper.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/modules/search/filters/helpers/filter_helper.dart';
import 'package:ota/modules/search/filters/view_model/filter_argument.dart';

class FilterViewModel {
  DateTime? checkInDate;
  DateTime? checkOutDate;
  final List<RoomViewModel> roomList;

  FilterViewModel({
    required this.checkInDate,
    required this.checkOutDate,
    required this.roomList,
  });

  factory FilterViewModel.mapFilterArgument(FilterArgument? argument) {
    return FilterViewModel(
      checkInDate: argument?.checkInDate != null
          ? Helpers().parseDateTime(argument?.checkInDate ?? '')
          : DateTime.now(),
      checkOutDate: argument?.checkOutDate != null
          ? Helpers().parseDateTime(argument?.checkOutDate ?? '')
          : DateTime.now(),
      roomList: FilterHelper.getRoomViewModelList(argument?.roomList) ?? [],
    );
  }
}

class RoomViewModel {
  int adults;
  final List<int> childAgeList;
  String? bedTypeKey;

  RoomViewModel({
    required this.adults,
    required this.childAgeList,
    this.bedTypeKey,
  });

  factory RoomViewModel.fromRoomArgument(RoomArgument? argument) {
    return RoomViewModel(
      adults: argument?.adults ?? 0,
      childAgeList: argument?.childAgeList ?? [],
      bedTypeKey: argument?.bedTypeKey,
    );
  }

  factory RoomViewModel.newRoom() {
    return RoomViewModel(
      adults: AppConfig().configModel.defaultAdultCount,
      childAgeList: [],
      bedTypeKey: AppConfig().configModel.defaultAdultCount ==
              AppConfig().configModel.bedTypeMaxAdults
          ? AppConfig().configModel.defaultBedType
          : null,
    );
  }
}
