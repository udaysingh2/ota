import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/search/filters/view_model/filter_argument.dart';
import 'package:ota/modules/search/filters/view_model/filter_view_model.dart';

import '../../../../mocks/hotel/hotel_details/hotel_detail_mock.dart';

void main() {
  testWidgets('filter argument ...', (tester) async {
    FilterArgument filterArgument =
        FilterArgument.fromHotelDetailArguments(getHotelDetailArgumentMock());

    expect(filterArgument.checkInDate, '2021-08-12');
    expect(filterArgument.checkOutDate, '2021-08-14');
    expect(filterArgument.roomList?.length, 2);

    FilterViewModel filterViewModel =
        FilterViewModel.mapFilterArgument(filterArgument);
    FilterArgument filterArgument1 =
        FilterArgument.fromFilterViewModel(filterViewModel);
    expect(filterArgument1.roomList?.length, 2);
  });
}
