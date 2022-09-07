import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view/widgets/reservation_room_info/reservation_room_info_model.dart';

class ReservationRoomInfoController extends Bloc<ReservationRoomInfoModel> {
  @override
  ReservationRoomInfoModel initDefaultValue() {
    return ReservationRoomInfoModel();
  }

  void toggle() {
    if (state.state == ReservationRoomInfoModelState.expanded) {
      emit(ReservationRoomInfoModel(
          state: ReservationRoomInfoModelState.collapsed));
    } else {
      emit(
          ReservationRoomInfoModel(state: ReservationRoomInfoModelState.expanded));
    }
  }
}
