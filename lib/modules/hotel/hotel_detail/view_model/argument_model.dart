import 'package:ota/common/utils/helper.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/domain/hotel/hotel_detail/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/models/hotel_detail_interest_data_argument.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/suggetion_view_model.dart';
import 'package:ota/modules/search/filters/helpers/filter_helper.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_view_argument.dart';

const int _kMaxHotelInHotelDetailSuggetion = 8;

class HotelDetailArgument {
  HotelDetailUserType userType;
  String currencyCode;
  String hotelId;
  String checkInDate;
  String checkOutDate;
  String cityId;
  List<Room> rooms;
  String countryCode;
  bool shouldPopSystem;

  HotelDetailArgument({
    required this.userType,
    required this.currencyCode,
    required this.checkOutDate,
    required this.checkInDate,
    required this.rooms,
    required this.cityId,
    required this.countryCode,
    required this.hotelId,
    this.shouldPopSystem = false,
  });

  HotelDetailDataArgument toHotelDataArgument() {
    return HotelDetailDataArgument(
      currency: currencyCode,
      checkOutDate: checkOutDate,
      checkInDate: checkInDate,
      rooms: getRoomDataList(rooms),
      cityId: cityId,
      countryId: countryCode,
      hotelId: hotelId,
    );
  }

  factory HotelDetailArgument.fromHotelDetailArgumentAndSuggetions(
      {required HotelDetailArgument hotelDetailDataArgument,
      required SuggetionViewModel suggetionViewModel}) {
    return HotelDetailArgument(
      rooms: hotelDetailDataArgument.rooms,
      countryCode: suggetionViewModel.countryCode ?? "",
      cityId: suggetionViewModel.cityId ?? "",
      hotelId: suggetionViewModel.hotelId ?? "",
      checkOutDate: hotelDetailDataArgument.checkOutDate,
      checkInDate: hotelDetailDataArgument.checkInDate,
      userType: hotelDetailDataArgument.userType,
      currencyCode: hotelDetailDataArgument.currencyCode,
      shouldPopSystem: hotelDetailDataArgument.shouldPopSystem,
    );
  }

  HotelDetailInterestDataArgument toHotelDetailInterestDataArgument() {
    return HotelDetailInterestDataArgument(
      hotelId: hotelId,
      checkInDate: checkInDate,
      checkOutDate: checkOutDate,
      maxHotel: _kMaxHotelInHotelDetailSuggetion,
      roomCapacity: getRoomDataRoomCapacityList(rooms),
      lat: 0,
      long: 0,
      epoch: Helpers.getEpochTime().toString(),
    );
  }

  List<RoomCapacity> getRoomDataRoomCapacityList(List<Room>? rooms) {
    List<RoomCapacity> roomDataList;
    if (rooms == null || rooms.isEmpty) return [];
    roomDataList = List<RoomCapacity>.generate(
      rooms.length,
      (index) => RoomCapacity(
        children: rooms[index].children,
        childAge1: rooms[index].childAge1,
        childAge2: rooms[index].childAge2,
        adult: rooms[index].adults,
      ),
    );
    return roomDataList;
  }

  factory HotelDetailArgument.getDefaulArgument(
      String? hotelId, String? cityId, String? countryId) {
    return HotelDetailArgument(
      currencyCode: AppConfig().currency,
      userType: HotelDetailUserType.loggedInUser,
      checkOutDate: Helpers.getYYYYmmddFromDateTime(DateTime.now()
          .add(Duration(days: AppConfig().configModel.checkOutDeltaHotel))),
      checkInDate: Helpers.getYYYYmmddFromDateTime(DateTime.now()
          .add(Duration(days: AppConfig().configModel.checkInDeltaHotel))),
      rooms: [
        Room(
          adults: AppConfig().configModel.defaultAdultCount,
          children: AppConfig().configModel.defaultChildCount,
          bedTypeKey: AppConfig().configModel.defaultAdultCount ==
                  AppConfig().configModel.bedTypeMaxAdults
              ? AppConfig().configModel.defaultBedType
              : null,
        )
      ],
      cityId: cityId ?? '',
      countryCode: countryId ?? '',
      hotelId: hotelId ?? '',
    );
  }

  factory HotelDetailArgument.getDefaultArgumentForChannel(String? hotelId,
      String? cityId, String? countryId, HotelDetailUserType userType) {
    return HotelDetailArgument(
      currencyCode: AppConfig().currency,
      userType: userType,
      checkOutDate: Helpers.getYYYYmmddFromDateTime(DateTime.now()
          .add(Duration(days: AppConfig().configModel.checkOutDeltaHotel))),
      checkInDate: Helpers.getYYYYmmddFromDateTime(DateTime.now()
          .add(Duration(days: AppConfig().configModel.checkInDeltaHotel))),
      rooms: [
        Room(
          adults: AppConfig().configModel.defaultAdultCount,
          children: AppConfig().configModel.defaultChildCount,
          bedTypeKey: AppConfig().configModel.defaultAdultCount ==
                  AppConfig().configModel.bedTypeMaxAdults
              ? AppConfig().configModel.defaultBedType
              : null,
        )
      ],
      cityId: cityId ?? '',
      countryCode: countryId ?? '',
      hotelId: hotelId ?? '',
    );
  }

  factory HotelDetailArgument.getHotelDetailArgument(
      String? hotelId,
      String? cityId,
      String? countryId,
      String? checkInDate,
      String? checkOutDate,
      List<Room>? roomlist,
      HotelDetailUserType userType) {
    return HotelDetailArgument(
      currencyCode: AppConfig().currency,
      userType: userType,
      checkOutDate: checkOutDate ??
          Helpers.getYYYYmmddFromDateTime(DateTime.now()
              .add(Duration(days: AppConfig().configModel.checkOutDeltaHotel))),
      checkInDate: checkInDate ??
          Helpers.getYYYYmmddFromDateTime(DateTime.now()
              .add(Duration(days: AppConfig().configModel.checkInDeltaHotel))),
      rooms: roomlist == null || roomlist.isEmpty
          ? [
              Room(
                adults: AppConfig().configModel.defaultAdultCount,
                children: AppConfig().configModel.defaultChildCount,
                bedTypeKey: AppConfig().configModel.defaultAdultCount ==
                        AppConfig().configModel.bedTypeMaxAdults
                    ? AppConfig().configModel.defaultBedType
                    : null,
              )
            ]
          : roomlist,
      cityId: cityId ?? '',
      countryCode: countryId ?? '',
      hotelId: hotelId ?? '',
    );
  }

  /// Guest is only all room adults + children count
  int get guestCount {
    int adults = 0;
    for (var element in rooms) {
      adults += element.adults;
      adults += element.children;
    }
    return adults;
  }

  int get childrenCount {
    int children = 0;
    for (var element in rooms) {
      children += element.children;
    }
    return children;
  }

  factory HotelDetailArgument.getBookingArgument(
      {required String hotelId,
      required String cityId,
      required String countryId,
      required BookingViewData bookingViewData,
      required HotelDetailUserType userType}) {
    List<Room> rooms = List.generate(bookingViewData.roomData.length, (index) {
      RoomViewData roomData = bookingViewData.roomData.elementAt(index);
      return Room(
        adults: roomData.numAdult,
        children: roomData.numChild,
        childAge1: roomData.childAge1,
        childAge2: roomData.childAge2,
        bedTypeKey: roomData.roomType,
      );
    });
    return HotelDetailArgument(
      currencyCode: AppConfig().currency,
      userType: userType,
      checkOutDate: bookingViewData.checkoutDate,
      checkInDate: bookingViewData.checkinDate,
      rooms: rooms,
      cityId: cityId,
      countryCode: countryId,
      hotelId: hotelId,
    );
  }

  List<RoomData> getRoomDataList(List<Room>? rooms) {
    List<RoomData> roomDataList;
    if (rooms == null || rooms.isEmpty) return [];
    roomDataList = List<RoomData>.generate(
      rooms.length,
      (index) => RoomData(
        adults: rooms[index].adults,
        children: rooms[index].children,
        childAge1: rooms[index].childAge1,
        childAge2: rooms[index].childAge2,
        roomType: FilterHelper.getRoomType(rooms[index].bedTypeKey),
      ),
    );
    return roomDataList;
  }
}

class Room {
  int adults;
  int children;
  int? childAge1;
  int? childAge2;
  String? bedTypeKey;

  Room({
    required this.adults,
    required this.children,
    this.childAge1,
    this.childAge2,
    this.bedTypeKey,
  });
}

enum HotelDetailUserType {
  guestUser,
  loggedInUser,
}
