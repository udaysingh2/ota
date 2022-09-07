class ReservationDataArgument {
  ReservationDataArgument({
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
    required this.supplierId,
    required this.supplierName,
    required this.mealCode,
  });

  String hotelId;
  String cityId;
  String checkInDate;
  String checkOutDate;
  List<RoomCapacity> room;
  String currency;
  String countryId;
  String roomCode;
  int roomCategory;
  double price;
  String supplierId;
  String supplierName;
  String mealCode;
  int checkPrice = 1; // For initiate booking checkPrice will be always 1
}

class RoomCapacity {
  int adult;
  int? children;
  int? childAge1;
  int? childAge2;
  RoomCapacity(
      {required this.adult, this.children, this.childAge1, this.childAge2});
  Map<String, dynamic> toMap() => {
        "adults": adult,
        "children": children,
        if (childAge1 != null) "childAge1": childAge1,
        if (childAge2 != null) "childAge2": childAge2,
      };
}
