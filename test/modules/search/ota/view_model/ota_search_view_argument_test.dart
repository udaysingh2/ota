import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/search/models/ota_search_argument.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_view_argument.dart';

void main() {
  test(
    'OTA search view argument tests',
    () async {
      RoomViewData roomViewData = RoomViewData(
        roomType: 'RoomType1',
        numAdult: 0,
        numChild: 0,
        childAge1: 0,
        childAge2: 0,
      );
      HotelViewData hotelData = HotelViewData(
        hotelId: '',
        cityId: '',
        locationId: '',
        bookingData: BookingViewData(
          checkinDate: '',
          checkoutDate: '',
          roomData: [roomViewData],
          numRoom: 0,
        ),
        filterData: FilterData(
          minPrice: 0,
          maxPrice: 100,
        ),
      );
      FlightViewData flightData = FlightViewData();

      OtaSearchViewArgument otaSearchViewArgument = OtaSearchViewArgument(
        userId: 'UserId',
        searchKey: 'SearchKey',
        latitude: 0.0,
        longitude: 0.0,
        pageNumber: 0,
        pageSize: 'PageSize',
        hotelData: hotelData,
        flightData: flightData,
        searchAvailableApi: true,
      );

      otaSearchViewArgument.toOtaSearchArgument();
      roomViewData.toMap();
      expect(otaSearchViewArgument.userId, 'UserId');
    },
  );
}
