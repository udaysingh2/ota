import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_config.dart';

class HotelDetailInterestDataArgument {
  String hotelId;
  double lat;
  double long;
  String epoch;
  int? maxHotel;
  String checkInDate;
  String checkOutDate;
  List<RoomCapacity> roomCapacity;

  Map<String, dynamic> toGraphqlString() {
    List<dynamic> data = List<dynamic>.from(roomCapacity.map((x) => x.toMap()));
    return {
      "hotelId": hotelId.surroundWithDoubleQuote(),
      "lat": lat,
      "long": long,
      "epoch": epoch,
      "maxHotel": maxHotel,
      "checkinDate": checkInDate.surroundWithDoubleQuote(),
      "checkoutDate": checkOutDate.surroundWithDoubleQuote(),
      "room": data,
      "numRoom": data.length,
    };
  }

  HotelDetailInterestDataArgument({
    required this.hotelId,
    required this.lat,
    required this.long,
    required this.epoch,
    required this.checkInDate,
    required this.checkOutDate,
    required this.maxHotel,
    required this.roomCapacity,
  });
}

class RoomCapacity {
  int adult;
  int? children;
  int? childAge1;
  int? childAge2;
  RoomCapacity(
      {required this.adult, this.children, this.childAge1, this.childAge2});
  Map<String, dynamic> toMap() => {
        "numAdult": adult,
        "numChild": children ?? "${AppConfig().configModel.defaultChildCount}",
        if (childAge1 != null) "childAge1": childAge1,
        if (childAge2 != null) "childAge2": childAge2,
      };
}
