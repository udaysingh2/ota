import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/bloc/filter_view_bloc.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/filter_view_model.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/reservation_argument_model.dart';

void main() {
  FilterViewBloc bloc = FilterViewBloc();

  test('For FilterViewBloc class ==> initDefaultValue()', () {
    final actual = bloc.initDefaultValue();

    expect(actual.filterViewModelDataState, FilterViewModelDataState.initial);
  });

  test('For FilterViewBloc class ==> getFromArgument()', () {
    ///If argument is Empty
    bloc.getFromArgument(null);

    expect(
        bloc.state.filterViewModelDataState, FilterViewModelDataState.loading);

    ///If argument is Not Empty
    bloc.getFromArgument(getArgument());

    expect(bloc.state.filterViewModelDataState,
        FilterViewModelDataState.loadedFromArgument);
  });

  test('For FilterViewBloc class ==> updateNightCountFromServer()', () {
    bloc.updateNightCountFromServer('1');

    expect(bloc.state.filterViewModelDataState,
        FilterViewModelDataState.loadedFromServer);
  });
}

ReservationArgumentModel getArgument() => ReservationArgumentModel(
      secondName: 'secondName',
      firstName: 'firstName',
      email: 'email',
      fromDate: Helpers().parseDateTime("2022-11-11"),
      mobileNumber: 'mobileNumber',
      toDate: Helpers().parseDateTime("2022-11-13"),
      hotelId: 'hotelId',
      currency: 'currency',
      cityId: 'cityId',
      rooms: [],
      countryId: 'countryId',
      roomCode: 'roomCode',
      price: 1000,
      roomCategory: 1,
      freefoodDelivery: true,
      rating: 'rating',
      address: 'address',
      supplierId: 'CL213',
      supplierName: 'Mark All Services Co., Ltd',
      mealCode: 'BB',
    );
