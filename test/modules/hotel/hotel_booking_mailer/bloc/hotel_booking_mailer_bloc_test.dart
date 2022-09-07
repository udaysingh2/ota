import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/models/hotel_booking_mailer_argument_domain.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/models/hotel_booking_mailer_model_domain.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/use_cases/hotel_booking_mailer_use_cases.dart';
import 'package:ota/modules/hotel/hotel_booking_mailer/bloc/hotel_booking_mailer_bloc.dart';
import 'package:ota/modules/hotel/hotel_booking_mailer/view_model/hotel_booking_mailer_view_model.dart';

import 'Mocks/hotel_booking_mailer_bloc_failure_mock.dart';
import 'Mocks/hotel_booking_mailer_bloc_success_mock.dart';

const String _kStatusSuccess = 'success';

void main() {
  HotelBookingMailerBloc bloc = HotelBookingMailerBloc();
  HotelBookingMailerUseCases successMock =
      HotelBookingMailerUseCasesSuccessMock();
  HotelBookingMailerUseCases failureMock =
      HotelBookingMailerUseCasesFailureMock();

  test('For HotelBookingMailerBloc class ==> initDefaultValue()', () {
    bloc.initDefaultValue();

    expect(bloc.initDefaultValue().actionStatus.isEmpty, true);
  });

  test('For HotelBookingMailerBloc class ==> boolean Test()', () {
    bloc.resetState();
    bloc.isLoading();
    bloc.isActionStatusSuccess();
    bloc.state.actionStatus = _kStatusSuccess;
    expect(bloc.state.actionStatus, _kStatusSuccess);
    bloc.isSuccess();
  });

  test('For HotelBookingMailerBloc class ==> sendHotelBookingMailer() Values',
      () {
    bloc.sendHotelBookingMailer('', '', '', '');
    expect(
        bloc.state.hotelBookingMailerStatus, HotelBookingMailerState.loading);
  });

  test('For HotelBookingMailerBloc class ==> sendHotelBookingMailer() Failure',
      () async {
    bloc.hotelBookingMailerUseCases = failureMock;
    bloc.sendHotelBookingMailer('', '', '', '');

    Either<Failure, HotelBookingMailerModelDomain>? result =
        (await failureMock.sendBookingHotelMailer(
      HotelBookingMailerArgumentDomain(
          confirmNo: "", mailId: "", bookingUrn: ""),
    ));
    expect(result?.isLeft, true);
  });

  test('For HotelBookingMailerBloc class ==> sendHotelBookingMailer() Success',
      () async {
    bloc.hotelBookingMailerUseCases = successMock;
    bloc.sendHotelBookingMailer('', '', '', '');

    Either<Failure, HotelBookingMailerModelDomain>? result =
        (await successMock.sendBookingHotelMailer(
      HotelBookingMailerArgumentDomain(
          confirmNo: "", mailId: "", bookingUrn: ""),
    ));
    expect(result?.isRight, true);
  });
}
