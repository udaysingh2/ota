import 'package:ota/core/app_config.dart';
import 'package:ota/domain/hotel/hotel_detail/models/argument_data_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';

HotelDetailDataArgument getHotelDetailDataArgumentMock() {
  return HotelDetailDataArgument(
      hotelId: "MA1111000019",
      cityId: "MA05110041",
      checkInDate: "2021-09-01",
      checkOutDate: "2021-09-02",
      rooms: [
        RoomData(
          adults: 2,
          children: 2,
          childAge1: 12,
          childAge2: 9,
        ),
        RoomData(
          adults: 3,
          children: 1,
          childAge1: 14,
        ),
      ],
      currency: AppConfig().currency,
      countryId: "MA05110001");
}

HotelDetailArgument getHotelDetailArgumentMock() {
  return HotelDetailArgument(
    checkInDate: "2021-08-12",
    checkOutDate: "2021-08-14",
    rooms: [
      Room(
        adults: 2,
        children: 2,
        childAge1: 12,
        childAge2: 9,
      ),
      Room(
        adults: 3,
        children: 1,
        childAge1: 14,
      ),
    ],
    cityId: "MA05110041",
    countryCode: "MA05110001",
    currencyCode: AppConfig().currency,
    hotelId: "MA0511000344",
    userType: HotelDetailUserType.guestUser,
  );
}
