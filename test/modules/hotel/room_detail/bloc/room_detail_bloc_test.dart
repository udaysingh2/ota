import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/room_detail/models/room_detail_model.dart';
import 'package:ota/domain/hotel/room_detail/usecases/room_detail_usecases.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/hotel/room_detail/bloc/room_detail_bloc.dart';
import 'package:ota/modules/hotel/room_detail/view_model/room_argument_model.dart';
import 'package:ota/modules/hotel/room_detail/view_model/room_detail_view_model.dart';

import 'mocks/room_detail_bloc_failure_mock.dart';
import 'mocks/room_detail_bloc_null_mock.dart';
import 'mocks/room_detail_bloc_success_mock.dart';

void main() {
  RoomDetailViewBloc bloc = RoomDetailViewBloc();

  RoomDetailUseCasesImpl successMock = RoomDetailUseCasesImplSuccessMock();
  RoomDetailUseCasesImpl failureMock = RoomDetailUseCasesImplFailureMock();
  RoomDetailUseCasesImpl nullMock = RoomDetailUseCasesImplNullMock();
  RoomDetailArgument argument = RoomDetailArgument(
    hotelId: "",
    cityId: "",
    checkInDate: "",
    checkOutDate: "",
    rooms: [
      Room(
        adults: 5,
        children: 4,
      )
    ],
    currency: "",
    countryId: "",
    roomCode: "",
    roomCategory: 4,
    price: 12.5,
    freefoodDelivery: true,
    rating: "",
    address: "",
    supplierId: '123',
    supplierName: 'Mark All Services Co., Ltd',
    mealCode: 'BB',
  );

  test('For RoomDetailViewBloc class ==> initDefaultValue()', () async {
    bloc.initDefaultValue();
  });

  test('For RoomDetailViewBloc class ==> getRoomDetail(), isRefresh = false',
      () async {
    bloc.getRoomDetail(argument, false);
  });

  test('For RoomDetailViewBloc class ==> getRoomDetail(), isRefresh = true',
      () async {
    bloc.getRoomDetail(argument, true);
  });

  test('For RoomDetailViewBloc class ==> getRoomDetail(), argument null',
      () async {
    bloc.getRoomDetail(null, true);
  });

  test('For RoomDetailViewBloc class ==> mapRoomDetail(), failureMock',
      () async {
    bloc.roomDetailUseCasesImpl = failureMock;
    await bloc.mapRoomDetail(failureMock, argument, false);

    Either<Failure, RoomDetailData?>? result =
        (await failureMock.getRoomDetail(argument.toRoomDataArgument()));

    expect(result?.isLeft, true);
    expect(bloc.state.pageState, RoomDetailViewPageState.internetFailure);
  });

  test('For RoomDetailViewBloc class ==> mapRoomDetail(), nullMock', () async {
    bloc.roomDetailUseCasesImpl = nullMock;
    await bloc.mapRoomDetail(nullMock, argument, true);

    Either<Failure, RoomDetailData?>? result =
        (await nullMock.getRoomDetail(argument.toRoomDataArgument()));

    expect(result?.isRight, true);
  });

  test('For RoomDetailViewBloc class ==> mapRoomDetail(), successMock',
      () async {
    bloc.roomDetailUseCasesImpl = successMock;

    Either<Failure, RoomDetailData?>? result =
        (await successMock.getRoomDetail(argument.toRoomDataArgument()));

    expect(result?.isRight, true);
  });
}
