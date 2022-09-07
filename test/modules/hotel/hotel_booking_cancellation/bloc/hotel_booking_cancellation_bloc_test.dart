import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/hotel_booking_cancellation/models/hotel_booking_cancellation_model.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/bloc/hotel_booking_cancellation_bloc.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/hotel_booking_cancellation_argument.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/hotel_booking_cancellation_view_model.dart';

import 'mocks/hotel_booking_cancellation_use_cases_mock.dart';

void main() {
  HotelBookingCancellationBloc bloc = HotelBookingCancellationBloc();
  HotelBookingCancellationSuccessMock successMock =
      HotelBookingCancellationSuccessMock();
  HotelBookingCancellationDataNullMock dataNullMock =
      HotelBookingCancellationDataNullMock();
  HotelBookingCancellationFailureMock failureMock =
      HotelBookingCancellationFailureMock();

  test('For class HotelBookingCancellationBloc ==> initDefaultValue', () {
    final actual = bloc.initDefaultValue();

    expect(actual.state, HotelBookingCancellationScreenStates.initial);
  });

  group(
      'For class HotelBookingCancellationBloc ==> getHotelBookingCancellationData',
      () {
    test('For class HotelBookingCancellationBloc ==> If Argument Null',
        () async {
      bloc.hotelBookingCancellationUseCases = successMock;

      await bloc.getHotelBookingCancellationData(null);

      expect(bloc.state.state, HotelBookingCancellationScreenStates.failure);
    });

    test('For class HotelBookingCancellationBloc ==> If Data Null', () async {
      bloc.hotelBookingCancellationUseCases = dataNullMock;

      await bloc.getHotelBookingCancellationData(argument());

      Either<Failure, HotelBookingCancellationModelDomain?>? result =
          await dataNullMock.getHotelBookingCancellationData(argument());

      expect(result?.isRight, true);
      expect(result?.right?.data == null, true);
    });

    test('For class HotelBookingCancellationBloc ==> If All TRUE Then',
        () async {
      bloc.hotelBookingCancellationUseCases = successMock;

      await bloc.getHotelBookingCancellationData(argument());

      Either<Failure, HotelBookingCancellationModelDomain?>? result =
          await successMock.getHotelBookingCancellationData(argument());

      expect(result?.isRight, true);
      expect(result?.right?.data?.actionStatus?.isNotEmpty, true);
    });

    test('For class HotelBookingCancellationBloc ==> If Failure Then',
        () async {
      bloc.hotelBookingCancellationUseCases = failureMock;

      await bloc.getHotelBookingCancellationData(argument());

      Either<Failure, HotelBookingCancellationModelDomain?>? result =
          await failureMock.getHotelBookingCancellationData(argument());

      expect(result?.isLeft, true);
    });
  });
}

HotelBookingCancellationArgument argument() => HotelBookingCancellationArgument(
      confirmNo: '',
      reason: '',
    );
