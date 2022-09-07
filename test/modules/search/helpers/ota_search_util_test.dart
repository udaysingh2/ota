import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/search/filters/view_model/filter_argument.dart';
import 'package:ota/modules/search/helpers/ota_search_util.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_view_argument.dart';
import 'package:ota/modules/search/ota_filters/view_model/filter_ota_argument_model.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  test(
    'OTA search util tests',
    () async {
      OtaSearchUtil otaSearchUtil = OtaSearchUtil(
        hotelId: 'hotelId',
        cityId: 'CityId',
        locationId: 'locationId',
        searchKey: 'SearchKey',
        searchAvailableApi: false,
      );
      otaSearchUtil.updateFilterArgument(
        FilterArgument(
          checkInDate: DateTime.now().add(const Duration(days: 1)).toString(),
          checkOutDate: DateTime.now().add(const Duration(days: 2)).toString(),
          roomList: [
            RoomArgument(adults: 2, childAgeList: [2, 4])
          ],
        ),
      );
      expect(otaSearchUtil.roomNumber, 1);
      OtaSearchViewArgument otaSearchViewArgument =
          otaSearchUtil.getArguments();

      otaSearchUtil.updateFilterData(
        FilterOtaArgumentData(
          rangeStaringPrice: 10,
          rangeEndingPrice: 100,
        ),
      );
      expect(otaSearchViewArgument.hotelData?.filterData?.minPrice, 10);
      expect(otaSearchViewArgument.hotelData?.filterData?.maxPrice, 100);
      otaSearchUtil.updatePageNumber(2);
      expect(otaSearchViewArgument.pageNumber, 2);
      // expect(otaSearchUtil.getPageSize() is int, true);
      expect(otaSearchUtil.getSearchKey(), 'SearchKey');
      initializeDateFormatting();
      // expect(otaSearchUtil.getDateRoomParseInfo() is String, true);
    },
  );
}
