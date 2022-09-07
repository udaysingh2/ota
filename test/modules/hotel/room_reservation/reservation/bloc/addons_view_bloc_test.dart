import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_data_argument.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_result_model.dart';
import 'package:ota/domain/hotel/hotel_addon_service/usecases/hotel_reservation_use_cases.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/bloc/addons_view_bloc.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/adons_view_model.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/reservation_argument_model.dart';

import 'mocks/addon_view_use_cases_mock.dart';

void main() {
  AddonsListBloc bloc = AddonsListBloc();
  HotelReservationUseCasesImpl successMock = AddOnViewUseCasesSuccessMock();
  HotelReservationUseCasesImpl failureMock = AddOnViewUseCasesFailureMock();

  test('For AddonsListBloc class ==> initDefaultValue()', () {
    final actual = bloc.initDefaultValue();

    expect(actual.addonsNetworkState, AddonsNetworkState.initial);
  });

  group('For AddonsListBloc class ==> getFromApiCall()', () {
    test('If Success then', () async {
      bloc.hotelReservationUseCasesImpl = successMock;
      bloc.getFromApiCall(getArgument());

      Either<Failure, HotelServiceResultModel>? result =
          await successMock.getHotelAddonServiceData(getServiceData());

      expect(result?.isRight, true);
    });

    test('If Failure then', () async {
      bloc.hotelReservationUseCasesImpl = failureMock;
      bloc.getFromApiCall(getArgument());

      Either<Failure, HotelServiceResultModel>? result =
          await failureMock.getHotelAddonServiceData(getServiceData());

      expect(result?.isLeft, true);
    });
  });

  test('For AddonsListBloc class ==> getTotalAmount()', () {
    bloc.state.addonsSelected = [
      AddonsModel(
        isFlight: true,
      ),
    ];
    final actual = bloc.getTotalAmount(1000.0);

    expect(actual, 1000.0);
  });

  test('For AddonsListBloc class ==> getUnselectedAddons()', () {
    bloc.state.addonsServices = [
      AddonsModel(
        isFlight: true,
      ),
    ];
    final actual = bloc.getUnselectedAddons();

    expect(actual.isEmpty, true);
  });

  test('For AddonsListBloc class ==> setSelected()', () {
    bloc.setSelected(AddonsModel(isFlight: true));

    expect(bloc.state.addonsSelected.isNotEmpty, true);
  });

  test('For AddonsListBloc class ==> getSelectedForArgument()', () {
    bloc.state.addonsSelected = [
      AddonsModel(
        isFlight: true,
        uniqueId: '',
      ),
    ];
    final actual = bloc.getSelectedForArgument();

    expect(actual.isNotEmpty, true);
  });

  test('For AddonsListBloc class ==> getListOfSelectedDateTime()', () {
    bloc.state.addonsSelected = [
      AddonsModel(
        isFlight: true,
        uniqueId: '111',
        selectedDate: Helpers().parseDateTime("2022-01-01"),
      ),
    ];

    final actual = bloc.getListOfSelectedDateTime(
      AddonsModel(
        isFlight: true,
        uniqueId: '111',
        selectedDate: Helpers().parseDateTime("2022-01-02"),
      ),
    );

    expect(actual?.isNotEmpty, true);

    ///For clearAddons()
    bloc.clearAddons();
    expect(bloc.state.addonsSelected.isEmpty, true);
  });

  test('For AddonsListBloc class ==> setUnSelected()', () {
    final model = AddonsModel(
      isFlight: true,
      uniqueId: '111',
      selectedDate: Helpers().parseDateTime("2022-01-01"),
    );

    bloc.state.addonsSelected = [model];

    bloc.setUnSelected(model);

    expect(bloc.state.addonsSelected.isEmpty, true);
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

HotelServiceDataArgument getServiceData() => HotelServiceDataArgument(
      hotelId: '',
      checkInDate: '',
      checkOutDate: '',
      currency: '',
      limit: 1,
      offset: 1,
    );
