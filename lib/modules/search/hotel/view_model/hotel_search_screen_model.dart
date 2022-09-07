class HotelSearchScreenModel {
  HotelSearchScreenState hotelSearchScreenState;
  HotelSearchScreenModel(
      {this.hotelSearchScreenState = HotelSearchScreenState.none});
}

enum HotelSearchScreenState { none, recommendations, suggestions }
