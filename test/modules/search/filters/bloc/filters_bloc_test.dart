import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/search/filters/bloc/filters_bloc.dart';
import 'package:ota/modules/search/filters/view_model/filter_argument.dart';
import 'package:ota/modules/search/filters/view_model/filter_view_model.dart';

import '../../../../mocks/hotel/hotel_details/hotel_detail_mock.dart';

void main() {
  FiltersBloc bloc = FiltersBloc();
  HotelDetailArgument hotelDetailArgument = getHotelDetailArgumentMock();
  FilterArgument filterArgument =
      FilterArgument.fromHotelDetailArguments(hotelDetailArgument);
  FilterViewModel model = FilterViewModel.mapFilterArgument(filterArgument);
  test('filters bloc ...', () async {
    bloc.setFilterViewModelData(filterArgument);
    expect(bloc.state.roomList.length, model.roomList.length);

    bloc.addNewRoom();
    expect(bloc.state.roomList.length, 3);

    bloc.addAdult(0, 2);
    expect(bloc.state.roomList[0].adults, 2);

    bloc.addChild(1, 12);
    expect(bloc.state.roomList[0].childAgeList[1], 9);

    bloc.updateChild(0, 0, 14);
    expect(bloc.state.roomList[0].childAgeList[0], 14);

    bloc.removeChild(0);
    expect(bloc.state.roomList[0].childAgeList.length, 1);

    bloc.removeAdult(0, 1);
    expect(bloc.state.roomList[0].adults, 1);

    expect(bloc.getAdultsCount(), 6);
    expect(bloc.getChildrenCount(), 3);

    bloc.removeRoom();
    expect(bloc.state.roomList.length, 2);

    bloc.setSelectedCheckInOutPeriod(
        DateTime(2021, 11, 1), DateTime(2021, 11, 4));
    expect(bloc.state.checkInDate?.day, 1);
    expect(bloc.state.checkOutDate?.day, 4);
  });
}
