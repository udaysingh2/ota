import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_bloc.dart';
import 'package:ota/domain/get_customer_details/models/customer_data_model.dart';
import 'package:ota/domain/get_customer_details/usecases/customer_use_cases.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/bloc/user_detail_bloc.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/reservation_argument_model.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/userdetail_view_model.dart';

import 'mocks/user_detail_use_cases_mock.dart';

void main() {
  UserDetailBloc bloc = UserDetailBloc();

  test('For UserDetailBloc class ==> initDefaultValue()', () {
    final actual = bloc.initDefaultValue();

    expect(actual.userDetailViewModelDataState,
        UserDetailViewModelDataState.initial);
  });

  group('For UserDetailBloc class ==> getFromApiCall()', () {
    CustomerUseCasesImpl successMock = UserDetailUseCasesSuccessMock();
    CustomerUseCasesImpl failureMock = UserDetailUseCasesFailureMock();

    test('If Success then', () async {
      bloc.customerUseCasesImpl = successMock;
      bloc.getFromApiCall(getArgument());

      Either<Failure, CustomerData>? result =
          await successMock.getCustomerData();

      expect(result?.isRight, true);
    });

    test('If Failure then', () async {
      bloc.customerUseCasesImpl = failureMock;
      bloc.getFromApiCall(getArgument());

      Either<Failure, CustomerData>? result =
          await failureMock.getCustomerData();

      expect(result?.isLeft, true);
    });
  });

  test('For UserDetailBloc class ==> setUserDataFromArg()', () {
    bloc.setUserDataFromArg(
        firstName: '', lastName: '', email: '', mobileNumber: '');

    expect(bloc.state.userDetailViewModelDataState,
        UserDetailViewModelDataState.loaded);
  });

  test('For UserDetailBloc class ==> isBookForSomeoneElse()', () {
    bloc.isBookForSomeoneElse(OtaRadioButtonBloc());

    expect(bloc.state.userDetailViewModelDataState,
        UserDetailViewModelDataState.loaded);
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
