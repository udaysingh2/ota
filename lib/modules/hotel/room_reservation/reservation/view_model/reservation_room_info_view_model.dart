class RoomDetails {
  String noOfRoomsAndName;
  String category;
  String roomType;
  int? numberOfRooms;
  RoomDetails(
      {this.category = "",
      this.roomType = "",
      this.numberOfRooms,
      this.noOfRoomsAndName = ""});
}

class FacilityList {
  String? key;
  String? value;
  FacilityList({this.key, this.value});
}
