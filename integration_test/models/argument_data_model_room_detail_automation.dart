class RoomDetailDataArgumentAutomation {
  RoomDetailDataArgumentAutomation({
    required this.hotelId,
    required this.cityId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.room,
    required this.currency,
    required this.countryId,
    required this.roomCode,
    required this.roomCategory,
    required this.price,
  });

  String hotelId;
  String cityId;
  String checkInDate;
  String checkOutDate;
  List<RoomCapacityAutomation> room;
  String currency;
  String countryId;
  String roomCode;
  int roomCategory;
  double price;
}

class RoomCapacityAutomation {
  int adult;
  int? children;
  int? childAge1;
  int? childAge2;
  RoomCapacityAutomation(
      {required this.adult, this.children, this.childAge1, this.childAge2});
  Map<String, dynamic> toMap() => {
        "adults": adult,
        "children": children,
        if (childAge1 != null) "childAge1": childAge1,
        if (childAge2 != null) "childAge2": childAge2,
      };
}
