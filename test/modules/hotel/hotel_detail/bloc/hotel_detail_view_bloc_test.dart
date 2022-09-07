import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_detail/usecases/hotel_detail_use_cases.dart';
import 'package:ota/modules/hotel/hotel_detail/bloc/hotel_detail_view_bloc.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/hotel_detail_view_model.dart';

import '../../../../mocks/hotel/hotel_details/hotel_detail_mock.dart';
import '../../repositories/hotel_detail_failure_usecase_mock.dart';
import '../../repositories/hotel_detail_no_room_usecase_mock.dart';
import '../../repositories/hotel_detail_success_usecase_mock.dart';

void main() {
  ///Use Case Success
  HotelDetailUseCasesImpl hotelDetailUseCasesSuccessImpl =
      HotelDetailUseCaseImplSuccessMock();

  ///No Room Usecase
  HotelDetailUseCasesImpl hotelDetailUseCasesNoRoomImpl =
      HotelDetailUseCaseImplNoRoomMock();

  ///Failure Usecase
  HotelDetailUseCasesImpl hotelDetailUseCasesFailureImpl =
      HotelDetailUseCaseImplFailureMock();

  HotelDetailArgument hotelDetailArgument = getHotelDetailArgumentMock();

  HotelDetailViewBloc hotelDetailViewBloc = HotelDetailViewBloc();

  test("Hotel Detail View Bloc Test", () async {
    ///default
    expect(
        hotelDetailViewBloc.state.pageState, HotelDetailViewPageState.initial);

    ///Case of null argument
    hotelDetailViewBloc.getHotelDetail(null, true);
    expect(
        hotelDetailViewBloc.state.pageState, HotelDetailViewPageState.failure);

    ///Case isRefresh is false
    hotelDetailViewBloc.getHotelDetail(hotelDetailArgument, false);
    expect(
        hotelDetailViewBloc.state.pageState, HotelDetailViewPageState.loading);

    ///Case when full data available
    hotelDetailViewBloc.getHotelDetail(hotelDetailArgument, true);
    await hotelDetailViewBloc.mapHotelDetail(
        hotelDetailUseCasesSuccessImpl, hotelDetailArgument, true);
    expect(
        hotelDetailViewBloc.state.pageState, HotelDetailViewPageState.success);

    ///Case when no rooms available
    hotelDetailViewBloc.getHotelDetail(hotelDetailArgument, true);
    await hotelDetailViewBloc.mapHotelDetail(
        hotelDetailUseCasesNoRoomImpl, hotelDetailArgument, true);
    expect(hotelDetailViewBloc.state.pageState,
        HotelDetailViewPageState.noRoomData);

    ///Case of Failure
    hotelDetailViewBloc.getHotelDetail(hotelDetailArgument, true);
    await hotelDetailViewBloc.mapHotelDetail(
        hotelDetailUseCasesFailureImpl, hotelDetailArgument, true);
    expect(hotelDetailViewBloc.state.pageState,
        HotelDetailViewPageState.internetFailure);
  });
}
