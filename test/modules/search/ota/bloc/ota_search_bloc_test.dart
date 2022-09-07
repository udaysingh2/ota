import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/modules/search/ota/bloc/ota_search_bloc.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_view_argument.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_view_model.dart';

void main() {
  OtaSearchBloc bloc = OtaSearchBloc();
  OtaSearchViewArgument otaSearchViewArgument = OtaSearchViewArgument(
    userId: "1",
    longitude: 19.7618,
    latitude: 140.542560,
    pageNumber: 10,
    pageSize: "10",
    searchKey: "test",
    hotelData: HotelViewData(
      hotelId: "1234",
      cityId: "1234",
      locationId: "1234",
      bookingData: BookingViewData(
          checkinDate: Helpers.getYYYYmmddFromDateTime(
              DateTime.now().add(const Duration(days: 1))),
          checkoutDate: Helpers.getYYYYmmddFromDateTime(
              DateTime.now().add(const Duration(days: 2))),
          roomData: [
            RoomViewData(
                roomType: "roomType",
                numAdult: 1,
                numChild: 1,
                childAge1: 1,
                childAge2: 1)
          ],
          numRoom: 1),
    ),
    searchAvailableApi: true,
  );

  test("OTA getOtaSearchData loading", () async {
    bloc.getOtaSearchResult(otaSearchViewArgument);
    expect(bloc.state.pageState, OtaSearchViewPageState.loading);
  });
}
