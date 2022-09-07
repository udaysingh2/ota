class HotelBookingDetailsRoomDetails {
  String? category;
  String? roomType;
  int numberOfRooms;
  int? adultCount;
  int? childrenCount;
  String? roomCode;
  String? roomCatName;

  HotelBookingDetailsRoomDetails({
    this.category,
    this.roomType,
    required this.numberOfRooms,
    this.adultCount,
    this.childrenCount,
    this.roomCode,
    this.roomCatName,
  });
}

class HotelBookingDetailsFacilityList {
  String? key;
  String? value;
  HotelBookingDetailsFacilityList({this.key, this.value});
}
