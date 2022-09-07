import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/domain/hotel/booking_initiate/models/argument_data_model.dart';
import 'package:ota/domain/hotel/booking_initiate/models/booking_data_model.dart';
import 'package:ota/domain/hotel/booking_initiate/usecases/reservation_room_usecases.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/bloc/filter_view_bloc.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/bloc/your_list_bloc.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/reservation_argument_model.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/your_list_view_model.dart';

import 'mocks/your_list_use_cases_mock.dart';

void main() {
  YourListBloc bloc = YourListBloc();
  ReservationRoomUseCase successMock = YourListUseCasesSuccessMock();
  ReservationRoomUseCase failureMock = YourListUseCasesFailureMock();

  test('For YourListBloc class ==> initDefaultValue()', () {
    final actual = bloc.initDefaultValue();

    expect(actual.yourListViewModelState, YourListViewModelState.initial);
  });

  group('For YourListBloc class ==> reloadFromRefresh()', () {
    test('If Argument is NULL then', () async {
      bloc.reloadFromRefresh(FilterViewBloc(), null);

      expect(bloc.state.yourListViewModelState, YourListViewModelState.failed);
    });

    test('If Argument has value then', () async {
      bloc.reservationRoomUseCasesImpl = successMock;
      bloc.reloadFromRefresh(FilterViewBloc(), getArgument());

      Either<Failure, BookingData?>? result =
          await successMock.getRoomDetail(getRoomArgument());

      expect(result?.isRight, true);
    });

    test('If Failure case then', () async {
      bloc.reservationRoomUseCasesImpl = failureMock;
      bloc.reloadFromRefresh(FilterViewBloc(), getArgument());

      Either<Failure, BookingData?>? result =
          await failureMock.getRoomDetail(getRoomArgument());

      expect(result?.isLeft, true);
    });
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

ReservationDataArgument getRoomArgument() => ReservationDataArgument(
      hotelId: 'hotelId',
      cityId: 'cityId',
      checkInDate: 'checkInDate',
      checkOutDate: 'checkOutDate',
      room: [],
      currency: '',
      countryId: '',
      roomCode: '',
      roomCategory: 1,
      price: 1000.0,
      supplierId: 'CL213',
      supplierName: 'Mark All Services Co., Ltd',
      mealCode: 'BB',
    );
