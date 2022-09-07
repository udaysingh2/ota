import 'package:ota/core_components/bloc/bloc.dart';
import 'hotel_details_room_info_model.dart';

class HotelDetailsRoomInfoController extends Bloc<HotelDetailsRoomInfoModel> {
  @override
  HotelDetailsRoomInfoModel initDefaultValue() {
    return HotelDetailsRoomInfoModel();
  }

  void toggle() {
    if (state.state == HotelDetailsRoomInfoModelState.expanded) {
      emit(HotelDetailsRoomInfoModel(
          state: HotelDetailsRoomInfoModelState.collapsed));
    } else {
      emit(HotelDetailsRoomInfoModel(
          state: HotelDetailsRoomInfoModelState.expanded));
    }
  }
}
