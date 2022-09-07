import 'package:ota/domain/search/models/ota_search_argument.dart';
import 'package:ota/modules/search/filters/helpers/filter_helper.dart';

class OtaSearchViewArgument {
  String userId;
  String searchKey;
  double latitude;
  double longitude;
  int pageNumber;
  String pageSize;
  bool searchAvailableApi;
  HotelViewData? hotelData;
  FlightViewData? flightData;
  CarViewData? carData;
  TourAndTicketViewData? tourAndTicketViewData;

  OtaSearchViewArgument({
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
    this.tourAndTicketViewData,
  });

  OtaSearchDataArgument toOtaSearchArgument() {
    return OtaSearchDataArgument(
        userId: userId,
        searchKey: searchKey,
        latitude: latitude,
        longitude: longitude,
        pageNumber: pageNumber,
        pageSize: pageSize,
        hotelData: _getHotelData(hotelData),
        flightData: _getFlightData(flightData),
        carData: _getCarDataList(carData),
        searchAvailableApi: searchAvailableApi,
        tourAndTicketData: _getTourAndTicketData(tourAndTicketViewData));
  }

  HotelData? _getHotelData(HotelViewData? hotelData) {
    if (hotelData == null) return null;
    return HotelData(
      hotelId: hotelData.hotelId,
      cityId: hotelData.cityId,
      locationId: hotelData.locationId,
      bookingData: _getBookingData(hotelData.bookingData),
      filterData: _getFilterData(hotelData.filterData),
    );
  }

  BookingData _getBookingData(BookingViewData bookingData) {
    return BookingData(
      checkInDate: bookingData.checkinDate,
      checkOutDate: bookingData.checkoutDate,
      roomData: getRoomDataList(bookingData.roomData),
      numRoom: bookingData.numRoom,
    );
  }

  FilterData? _getFilterData(FilterData? filterData) {
    if (filterData == null) return null;
    return FilterData(
      maxPrice: filterData.maxPrice,
      minPrice: filterData.minPrice,
      promotion: filterData.promotion,
      rating: filterData.rating,
      sortingMode: filterData.sortingMode,
      reviewScore: filterData.reviewScore,
      availableHotel: filterData.availableHotel,
      capsulePromotion: filterData.capsulePromotion,
      sha: filterData.sha,
    );
  }

  List<RoomData> getRoomDataList(List<RoomViewData> rooms) {
    return List<RoomData>.generate(
        rooms.length,
        (index) => RoomData(
              roomType: FilterHelper.getRoomType(rooms[index].roomType),
              numAdult: rooms[index].numAdult,
              numChild: rooms[index].numChild,
              childAge1: rooms[index].childAge1,
              childAge2: rooms[index].childAge2,
            ));
  }

  FlightData? _getFlightData(FlightViewData? flightData) {
    return flightData != null ? FlightData() : null;
  }

  CarData? _getCarDataList(CarViewData? carData) {
    return carData != null
        ? CarData(
            returnDate: carData.returnDate,
            returnLocationId: carData.returnLocationId,
            pickupLocationId: carData.pickupLocationId,
            cityId: carData.cityId,
            returnTime: carData.returnTime,
            pickupTime: carData.pickupTime,
            pickupDate: carData.pickupDate,
            includeDriver: carData.includeDriver,
            age: carData.age)
        : null;
  }

  TourAndTicketData? _getTourAndTicketData(TourAndTicketViewData? data) {
    if (data == null) return null;
    return TourAndTicketData(
      countryId: data.countryId,
      cityId: data.cityId,
      locationId: data.locationId,
      placeId: data.placeId,
      filter: _getTourAndTicketFilter(data.filter),
    );
  }

  ToursAndTicketFilter? _getTourAndTicketFilter(
      TourAndTicketViewFilter? filter) {
    if (filter == null) return null;
    return ToursAndTicketFilter(
        maxPrice: filter.maxPrice?.round(), minPrice: filter.minPrice?.round());
  }
}

class FlightViewData {}

class CarViewData {
  CarViewData({
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

  factory CarViewData.fromMap(Map<String, dynamic> json) => CarViewData(
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
        "pickupLocationId": pickupLocationId,
        "returnLocationId": returnLocationId,
        "cityId": cityId,
        "pickupDate": pickupDate,
        "returnDate": returnDate,
        "pickupTime": pickupTime,
        "returnTime": returnTime,
        "age": age,
        "includeDriver": includeDriver,
      };
}

class FilterViewData {}

class BookingViewData {
  String checkinDate;
  String checkoutDate;
  List<RoomViewData> roomData;
  int numRoom;

  BookingViewData({
    required this.checkinDate,
    required this.checkoutDate,
    required this.roomData,
    required this.numRoom,
  });
}

class RoomViewData {
  String? roomType;
  int numAdult;
  int numChild;
  int? childAge1;
  int? childAge2;

  RoomViewData({
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
        if (childAge2 != null) "childAge2": childAge2,
      };
}

class HotelViewData {
  String hotelId;
  String cityId;
  String locationId;
  BookingViewData bookingData;
  FilterData? filterData;

  HotelViewData({
    required this.hotelId,
    required this.cityId,
    required this.locationId,
    required this.bookingData,
    this.filterData,
  });
}

class TourAndTicketViewData {
  String countryId;
  String cityId;
  String? locationId;
  String? placeId;
  TourAndTicketViewFilter? filter;
  TourAndTicketViewData({
    required this.countryId,
    required this.cityId,
    this.locationId,
    this.placeId,
    this.filter,
  });
}

class TourAndTicketViewFilter {
  double? minPrice;
  double? maxPrice;
  TourAndTicketViewFilter({
    this.minPrice,
    this.maxPrice,
  });
}
