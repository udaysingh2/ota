import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/search/models/ota_search_model.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_view_model.dart';

void main() {
  test(
    'OTA search view model tests',
    () async {
      OtaSearchViewModel otaSearchViewModel = OtaSearchViewModel(
        pageState: OtaSearchViewPageState.empty,
      );

      expect(
          otaSearchViewModel.pageState == OtaSearchViewPageState.empty, true);
    },
  );

  test(
    'OTA search model tests',
    () async {
      OtaSearchModel otaSearchModel = OtaSearchModel(
        hotelView: HotelView.mapFromHotelDetail(
          Hotel(
            hotelList: [
              HotelList(hotelId: '100'),
              HotelList(hotelId: '101'),
            ],
            filter: Filter(minPrice: 0),
          ),
        ),
        flightView: FlightView.mapFromFlightDetail(Flight()),
        carView: CarView.mapFromCarDetail(CarRental()),
      );
      expect(otaSearchModel.hotelView?.hotelList?.first.hotelId, '100');
      expect(otaSearchModel.hotelView?.filter?.minPrice, 0);
      expect(otaSearchModel.hotelView?.hotelList?.length, 2);

      OtaSearchModel otaSearchModelFromMap = OtaSearchModel.mapFromSearchDetail(
        GetOtaSearchResultData(
          hotel: Hotel(
            hotelList: [HotelList(totalPrice: 100)],
          ),
        ),
      );

      expect(otaSearchModelFromMap.hotelView?.hotelList?.first.totalPrice, 100);

      OtaSearchModel otaSearchModelWithView = OtaSearchModel(
        hotelView: HotelView(
          hotelList: [HotelListResult(hotelName: 'Hotel Name')],
          filter: FilterResult(maxPrice: 100),
        ),
        flightView: FlightView(),
        carView: CarView(null),
      );
      expect(otaSearchModelWithView.hotelView?.hotelList?.first.hotelName,
          'Hotel Name');
      expect(otaSearchModelWithView.hotelView?.filter?.maxPrice, 100);
    },
  );
}
