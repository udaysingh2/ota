class OtaSearchDataArgumentAutomation {
  String userId;
  String searchKey;
  double latitude;
  double longitude;
  int pageNumber;
  String pageSize;
  HotelDataAutomation? hotelData;
  FlightData? flightData;
  CarData? carData;
  OtaSearchDataArgumentAutomation({
    required this.userId,
    required this.searchKey,
    required this.latitude,
    required this.longitude,
    required this.pageNumber,
    required this.pageSize,
    this.hotelData,
    this.flightData,
    this.carData,
  });
  Map<String, dynamic> toMap() => {
        "userId": userId.addQuote(),
        "searchKey": searchKey.addQuote(),
        "latitude": latitude,
        "longitude": longitude,
        "pageNumber": pageNumber,
        "pageSize": pageSize.addQuote(),
        if (hotelData != null) "hotel": hotelData!.toMap(),
        if (flightData != null) "flight": flightData!.toMap(),
        if (carData != null) "car": carData!.toMap(),
      };
}

class FlightData {
  Map<String, dynamic> toMap() => {};
}

class CarData {
  Map<String, dynamic> toMap() => {};
}

class FilterDataAutomation {
  int? minPrice;
  int? maxPrice;
  String? sortingMode;
  List<int>? rating;
  List<String>? promotion;
  List<int>? reviewScore;
  FilterDataAutomation({
    this.minPrice,
    this.maxPrice,
    this.sortingMode,
    this.rating,
    this.promotion,
    this.reviewScore,
  });
  Map<String, dynamic> toMap() => {
        if (minPrice != null) "minPrice": minPrice,
        if (maxPrice != null) "maxPrice": maxPrice,
        if (sortingMode != null) "sortingMode": sortingMode!.addQuote(),
        if (rating != null) "rating": rating,
        if (promotion != null)
          "promotion": promotion!.map((x) => x.addQuote()).toList(),
        if (reviewScore != null) "reviewScore": reviewScore
      };
}

class BookingDataAutomation {
  String checkInDate;
  String checkOutDate;
  List<RoomDataAutomation> roomData;
  int numRoom;
  BookingDataAutomation({
    required this.checkInDate,
    required this.checkOutDate,
    required this.roomData,
    required this.numRoom,
  });
  Map<String, dynamic> toMap() => {
        "checkInDate": checkInDate.addQuote(),
        "checkOutDate": checkOutDate.addQuote(),
        "numRoom": numRoom,
        "room": roomData.map((result) => result.toMap()).toList()
      };
}

class RoomDataAutomation {
  String roomType;
  int numAdult;
  int numChild;
  int? childAge1;
  int? childAge2;
  RoomDataAutomation({
    required this.roomType,
    required this.numAdult,
    required this.numChild,
    required this.childAge1,
    required this.childAge2,
  });

  Map<String, dynamic> toMap() => {
        "roomType": roomType.addQuote(),
        "numAdult": numAdult,
        "numChild": numChild,
        "childAge1": childAge1,
        "childAge2": childAge2
      };
}

class HotelDataAutomation {
  String cityId;
  String locationId;
  BookingDataAutomation bookingData;
  FilterDataAutomation? filterData;
  HotelDataAutomation({
    required this.cityId,
    required this.locationId,
    required this.bookingData,
    required this.filterData,
  });
  Map<String, dynamic> toMap() => {
        "cityId": cityId.addQuote(),
        "locationId": locationId.addQuote(),
        "booking": bookingData.toMap(),
        if (filterData != null) "filter": filterData!.toMap()
      };
}

extension StringQuote on String {
  String addQuote() {
    return '\"' + this + '\"';
  }
}
