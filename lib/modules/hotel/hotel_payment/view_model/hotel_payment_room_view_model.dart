class HotelPaymentRoomDetails {
  String noOfRoomsAndName;
  String category;
  String roomType;
  int? numberOfRooms;
  HotelPaymentRoomDetails(
      {this.category = "",
      this.roomType = "",
      this.numberOfRooms,
      this.noOfRoomsAndName = ""});
}

class HotelPaymentFacilityList {
  String? key;
  String? value;
  HotelPaymentFacilityList({this.key, this.value});
}
