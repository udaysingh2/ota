import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/models/tours_booking_cancellation_argument_model.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/models/tours_booking_cancellation_model_domain.dart';
import 'package:ota/modules/tours/tour_booking_cancellation/bloc/tour_booking_cancellation_bloc.dart';
import 'package:ota/modules/tours/tour_booking_cancellation/view_model/tour_booking_cancellation_argument.dart';
import 'package:ota/modules/tours/tour_booking_cancellation/view_model/tour_booking_cancellation_view_model.dart';

import 'mocks/tour_booking_cancellation_mocks.dart';

void main() {
  TourBookingCancellationArgumentDomain argumentDomain =
      TourBookingCancellationArgumentDomain(
          confirmationNo: 'TR220302-AA-0005', cancellationReason: '');
  TourBookingCancellationArgument argument = TourBookingCancellationArgument(
      confirmNo: 'TR220302-AA-0005', reason: '');
  TourBookingCancellationBloc bloc = TourBookingCancellationBloc();
  TourBookingCancellationSuccessMock successMock =
      TourBookingCancellationSuccessMock();
  TourBookingCancellationDataNullMock nullMock =
      TourBookingCancellationDataNullMock();
  TourBookingCancellationFailureMock failureMock =
      TourBookingCancellationFailureMock();

  group(
      'For class TourBookingCancellationBloc ==> getTourBookingCancellationData',
      () {
    test('For class TourBookingCancellationBloc ==> initDefaultValue', () {
      final actual = bloc.initDefaultValue();

      expect(actual.state, TourBookingCancellationScreenStates.initial);
    });

    test('For class TourBookingCancellationBloc ==> If Argument Null',
        () async {
      bloc.tourBookingCancellationUseCases = successMock;

      await bloc.getTourBookingCancellationData(null);

      expect(bloc.state.state, TourBookingCancellationScreenStates.failure);
    });

    test('For class TourBookingCancellationBloc ==> If Data Null', () async {
      bloc.tourBookingCancellationUseCases = nullMock;

      await bloc.getTourBookingCancellationData(argument);

      Either<Failure, TourBookingDetailCancellationDomain>? result =
          await nullMock.getTourCancellationDetail(argumentDomain);

      expect(result?.isRight, true);
      expect(result?.right.getTourBookingReject == null, true);
    });

    test('For class TourBookingCancellationBloc ==> If All TRUE Then',
        () async {
      bloc.tourBookingCancellationUseCases = successMock;

      await bloc.getTourBookingCancellationData(argument);

      Either<Failure, TourBookingDetailCancellationDomain>? result =
          await successMock.getTourCancellationDetail(argumentDomain);

      expect(result?.isRight, true);
      expect(result?.right.getTourBookingReject?.data?.actionStatus?.isNotEmpty,
          true);
    });

    test('For class TourBookingCancellationBloc ==> If Failure Then', () async {
      bloc.tourBookingCancellationUseCases = failureMock;

      await bloc.getTourBookingCancellationData(argument);

      Either<Failure, TourBookingDetailCancellationDomain>? result =
          await failureMock.getTourCancellationDetail(argumentDomain);

      expect(result?.isLeft, true);
    });
  });
}
