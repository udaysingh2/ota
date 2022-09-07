import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/search/filters/view_model/filter_argument.dart';
import 'package:ota/modules/search/filters/view_model/filter_view_model.dart';

import '../../../../mocks/hotel/hotel_details/hotel_detail_mock.dart';

void main() {
  testWidgets('filter view model ...', (tester) async {
    FilterArgument filterArgument =
        FilterArgument.fromHotelDetailArguments(getHotelDetailArgumentMock());
    FilterViewModel filterViewModel =
        FilterViewModel.mapFilterArgument(filterArgument);
    expect(filterViewModel.roomList.length, 2);
    expect(filterViewModel.checkInDate?.day, 12);
    expect(filterViewModel.checkOutDate?.day, 14);
    expect(filterViewModel.checkOutDate?.day, 14);

    expect(RoomViewModel.newRoom().adults, 2);
    expect(RoomViewModel.newRoom().childAgeList, []);

    FilterArgument filterArgument1 =
        FilterArgument.fromHotelDetailArguments(getHotelDetailArgumentMock());
    filterArgument1.checkInDate = null;
    filterArgument1.checkOutDate = null;
    FilterViewModel filterViewModel1 =
        FilterViewModel.mapFilterArgument(filterArgument1);
    expect(filterViewModel1.checkInDate?.day, DateTime.now().day);
    expect(filterViewModel1.checkOutDate?.day, DateTime.now().day);
  });
}
