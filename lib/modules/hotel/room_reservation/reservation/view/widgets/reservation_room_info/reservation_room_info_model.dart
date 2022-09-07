class ReservationRoomInfoModel {
  final ReservationRoomInfoModelState state;

  ReservationRoomInfoModel(
      {this.state = ReservationRoomInfoModelState.collapsed});
}

enum ReservationRoomInfoModelState { expanded, collapsed }
