class HotelDetailsRoomInfoModel {
  final HotelDetailsRoomInfoModelState state;

  HotelDetailsRoomInfoModel(
      {this.state = HotelDetailsRoomInfoModelState.collapsed});
}

enum HotelDetailsRoomInfoModelState { expanded, collapsed }
