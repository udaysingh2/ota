import 'package:ota/domain/search/models/ota_search_argument.dart';

class HotelDetailDataArgument {
  String currency;
  String hotelId;
  String checkInDate;
  String checkOutDate;
  String cityId;
  String countryId;
  List<RoomData> rooms;
  HotelDetailDataArgument({
    required this.currency,
    required this.checkOutDate,
    required this.checkInDate,
    required this.cityId,
    required this.countryId,
    required this.hotelId,
    required this.rooms,
  });
}

class RoomData {
  int adults;
  int children;
  int? childAge1;
  int? childAge2;
  String? roomType;

  RoomData({
    required this.adults,
    required this.children,
    this.childAge1,
    this.childAge2,
    this.roomType,
  });

  Map<String, dynamic> toMap() => {
        "adults": adults,
        "children": children,
        if (childAge1 != null) "childAge1": childAge1,
        if (childAge2 != null) "childAge2": childAge2,
        if (roomType != null) "roomType": roomType!.addQuote()
      };
}
