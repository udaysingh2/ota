import 'dart:convert';

class OtaSearchDataArgument {
  String userId;
  String searchKey;
  double latitude;
  double longitude;
  int pageNumber;
  String pageSize;
  bool searchAvailableApi;
  HotelData? hotelData;
  FlightData? flightData;
  CarData? carData;
  TourAndTicketData? tourAndTicketData;
  OtaSearchDataArgument({
    required this.userId,
    required this.searchKey,
    required this.latitude,
    required this.longitude,
    required this.pageNumber,
    required this.pageSize,
    required this.searchAvailableApi,
    this.hotelData,
    this.flightData,
    this.carData,
    this.tourAndTicketData,
  });

  Map<String, dynamic> toMap() => {
        "searchKey": searchKey.addQuote(),
        "latitude": latitude,
        "longitude": longitude,
        "pageNumber": pageNumber,
        "pageSize": pageSize.addQuote(),
        "searchAvailableApi": searchAvailableApi,
        if (hotelData != null) "hotel": hotelData!.toMap(),
        if (flightData != null) "flight": flightData!.toMap(),
        if (carData != null) "car": carData!.toMap(),
        if (tourAndTicketData != null)
          "tourAndTicketActivity": tourAndTicketData!.toMap(),
      };
}

class FlightData {
  Map<String, dynamic> toMap() => {};
}

CarData carDataFromMap(String str) => CarData.fromMap(json.decode(str));

String carDataToMap(CarData data) => json.encode(data.toMap());

class CarData {
  CarData({
    this.pickupLocationId,
    this.returnLocationId,
    this.cityId,
    required this.pickupDate,
    required this.returnDate,
    required this.pickupTime,
    required this.returnTime,
    required this.age,
    required this.includeDriver,
  });

  String? pickupLocationId;
  String? returnLocationId;
  String? cityId;
  String pickupDate;
  String returnDate;
  String pickupTime;
  String returnTime;
  int age;
  bool includeDriver;

  factory CarData.fromMap(Map<String, dynamic> json) => CarData(
        pickupLocationId: json["pickupLocationId"],
        returnLocationId: json["returnLocationId"],
        cityId: json["cityId"],
        pickupDate: json["pickupDate"],
        returnDate: json["returnDate"],
        pickupTime: json["pickupTime"],
        returnTime: json["returnTime"],
        age: json["age"],
        includeDriver: json["includeDriver"],
      );

  Map<String, dynamic> toMap() => {
        "pickupLocationId":
            (pickupLocationId != null && pickupLocationId!.isNotEmpty)
                ? pickupLocationId!.addQuote()
                : null,
        "returnLocationId":
            (returnLocationId != null && returnLocationId!.isNotEmpty)
                ? returnLocationId!.addQuote()
                : null,
        "cityId": cityId != null ? cityId!.addQuote() : null,
        "pickupDate": pickupDate.addQuote(),
        "returnDate": returnDate.addQuote(),
        "pickupTime": pickupTime.addQuote(),
        "returnTime": returnTime.addQuote(),
        "age": age,
        "includeDriver": includeDriver,
      };
}

class FilterData {
  int? minPrice;
  int? maxPrice;
  String? sortingMode;
  List<int>? rating;
  List<String>? promotion;
  List<int>? reviewScore;
  List<PromotionCapsule>? capsulePromotion;
  bool? availableHotel;
  List<String>? sha;

  FilterData({
    this.minPrice,
    this.maxPrice,
    this.sortingMode,
    this.rating,
    this.promotion,
    this.reviewScore,
    this.availableHotel,
    this.capsulePromotion,
    this.sha,
  });

  Map<String, dynamic> toMap() => {
        if (addMinPrice(minPrice, maxPrice)) "minPrice": minPrice,
        if (addMaxPrice(minPrice, maxPrice)) "maxPrice": maxPrice,
        if (sortingMode != null) "sortingMode": sortingMode!.addQuote(),
        if (rating != null && (rating!.isNotEmpty)) "rating": rating,
        if (promotion != null)
          "adminPromotion": promotion!.map((x) => x.addQuote()).toList(),
        if (reviewScore != null) "reviewScore": reviewScore,
        if (availableHotel != null) "availableHotel": availableHotel,
        if (capsulePromotion != null)
          "capsulePromotion":
              capsulePromotion!.map((result) => result.toMap()).toList(),
        if (sha != null && sha!.isNotEmpty)
          "sha": sha!.map((x) => x.addQuote()).toList()
      };

  bool addMinPrice(int? minPrice, int? maxPrice) {
    if (minPrice == null) return false;
    if (maxPrice == null) return true;
    if (minPrice == maxPrice) return false;
    return true;
  }

  bool addMaxPrice(int? minPrice, int? maxPrice) {
    if (maxPrice == null) return false;
    if (minPrice == null) return true;
    if (minPrice == maxPrice) return false;
    return true;
  }
}

class PromotionCapsule {
  String? name;
  String? code;

  PromotionCapsule({
    this.code,
    this.name,
  });

  Map<String, dynamic> toMap() => {
        if (name != null) "nameEn": name!.addQuote(),
        if (name != null) "nameTh": name!.addQuote(),
        if (code != null) "code": code!.addQuote(),
      };
}

class BookingData {
  String checkInDate;
  String checkOutDate;
  List<RoomData> roomData;
  int numRoom;

  BookingData({
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

class RoomData {
  String? roomType;
  int numAdult;
  int numChild;
  int? childAge1;
  int? childAge2;

  RoomData({
    required this.roomType,
    required this.numAdult,
    required this.numChild,
    this.childAge1,
    this.childAge2,
  });

  Map<String, dynamic> toMap() => {
        if (roomType != null) "roomType": roomType!.addQuote(),
        "numAdult": numAdult,
        "numChild": numChild,
        if (childAge1 != null) "childAge1": childAge1,
        if (childAge2 != null) "childAge2": childAge2
      };
}

class HotelData {
  String hotelId;
  String cityId;
  String locationId;
  BookingData bookingData;
  FilterData? filterData;

  HotelData({
    required this.hotelId,
    required this.cityId,
    required this.locationId,
    required this.bookingData,
    required this.filterData,
  });

  Map<String, dynamic> toMap() => {
        "hotelId": hotelId.addQuote(),
        "cityId": cityId.addQuote(),
        "locationId": locationId.addQuote(),
        "booking": bookingData.toMap(),
        if (filterData != null) "filter": filterData!.toMap()
      };
}

class TourAndTicketData {
  String countryId;
  String cityId;
  ToursAndTicketFilter? filter;
  String? locationId;
  String? placeId;

  TourAndTicketData({
    required this.countryId,
    required this.cityId,
    this.filter,
    this.locationId,
    this.placeId,
  });

  Map<String, dynamic> toMap() => {
        "countryId": countryId.addQuote(),
        "cityId": cityId.addQuote(),
        if (locationId != null) "locationId": locationId!.addQuote(),
        if (placeId != null) "placeId": placeId!.addQuote(),
        "filter": filter?.toMap() ?? ToursAndTicketFilter.toDefault().toMap(),
      };
}

class ToursAndTicketFilter {
  int? minPrice;
  int? maxPrice;
  ToursAndTicketFilter({
    this.minPrice,
    this.maxPrice,
  });

  factory ToursAndTicketFilter.toDefault() =>
      ToursAndTicketFilter(minPrice: 0, maxPrice: 1000000);

  Map<String, dynamic> toMap() => {
        if (minPrice != null) "minPrice": minPrice,
        if (maxPrice != null) "maxPrice": maxPrice,
      };
}

extension StringQuote on String {
  String addQuote() {
    return '"${this}"';
  }
}
