import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/models/hotel_detail_interest_data.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/models/hotel_detail_interest_data_argument.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/usecases/hotel_detail_interest_use_cases.dart';
import 'package:ota/modules/hotel/hotel_detail/bloc/hotel_detail_interest_bloc.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/hotel_detail_interest_view_model.dart';

import 'mocks/hotel_detail_interest_bloc_mock.dart';

void main() {
  HotelDetailInterestBloc bloc = HotelDetailInterestBloc();

  HotelDetailInterestUseCasesImpl successMock =
      HotelDetailInterestImplSuccessMock();

  HotelDetailInterestUseCasesImpl failureMock =
      HotelDetailInterestImplFailureMock();

  test('For class HotelDetailInterestBloc ==> initDefaultValue Test', () async {
    bloc.initDefaultValue();

    expect(bloc.state.viewState, HotelDetailInterestViewModelState.initial);
  });

  group('For class HotelDetailInterestBloc group test', () {
    test(
        'For class HotelDetailInterestBloc ==> getInterests() If details is NULL then',
        () async {
      bloc.hotelDetailInterestUseCases = successMock;
      bloc.getInterests(null);

      expect(bloc.state.viewState, HotelDetailInterestViewModelState.failure);
    });

    test('For class HotelDetailInterestBloc ==> getInterests() If Success then',
        () async {
      bloc.hotelDetailInterestUseCases = successMock;
      bloc.getInterests(getDetails());

      Either<Failure, HotelDetailInterestData>? result =
          await successMock.getHotelDetailInterest(getArgs());

      expect(result?.isRight, true);
      expect(bloc.state.viewState, HotelDetailInterestViewModelState.success);
    });

    test('For class HotelDetailInterestBloc ==> getInterests() If Failure then',
        () async {
      bloc.hotelDetailInterestUseCases = failureMock;
      bloc.getInterests(getDetails());

      Either<Failure, HotelDetailInterestData>? result =
          await failureMock.getHotelDetailInterest(getArgs());

      expect(result?.isLeft, true);
      expect(bloc.state.viewState, HotelDetailInterestViewModelState.failure);
    });
  });
}

HotelDetailArgument getDetails() => HotelDetailArgument(
      userType: HotelDetailUserType.loggedInUser,
      currencyCode: 'BH',
      checkOutDate: '10/05/2022',
      checkInDate: '12/05/2022',
      rooms: [
        Room(
          adults: 2,
          children: 1,
        ),
      ],
      cityId: 'cityId',
      countryCode: 'countryCode',
      hotelId: 'hotelId',
    );

HotelDetailInterestDataArgument getArgs() => HotelDetailInterestDataArgument(
      hotelId: 'hotelId',
      lat: 0.0,
      long: 0.0,
      epoch: '1122334455',
      checkOutDate: '10/05/2022',
      checkInDate: '12/05/2022',
      maxHotel: 1,
      roomCapacity: [],
    );
