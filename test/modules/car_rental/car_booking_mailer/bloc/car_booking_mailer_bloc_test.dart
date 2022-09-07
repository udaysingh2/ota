import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/models/car_booking_mailer_argument_domain.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/models/car_booking_mailer_model_domain.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/use_cases/car_booking_mailer_use_cases.dart';
import 'package:ota/modules/car_rental/car_booking_mailer/bloc/car_booking_mailer_bloc.dart';
import 'package:ota/modules/car_rental/car_booking_mailer/view_model/car_booking_mailer_view_model.dart';

import 'mocks/car_booking_mailer_bloc_failure_mock.dart';
import 'mocks/car_booking_mailer_bloc_success_mock.dart';

const String _kStatusSuccess = 'success';

void main() {
  CarBookingMailerBloc bloc = CarBookingMailerBloc();
  CarBookingMailerUseCases successMock = CarBookingMailerUseCasesSuccessMock();
  CarBookingMailerUseCases failureMock = CarBookingMailerUseCasesFailureMock();

  test('For CarBookingMailerBloc class ==> initDefaultValue()', () {
    bloc.initDefaultValue();

    expect(bloc.initDefaultValue().actionStatus.isEmpty, true);
  });

  test('For CarBookingMailerBloc class ==> boolean Test()', () {
    bloc.resetState();
    bloc.isLoading();
    bloc.isActionStatusSuccess();
    bloc.state.actionStatus = _kStatusSuccess;
    expect(bloc.state.actionStatus, _kStatusSuccess);
    bloc.isSuccess();
  });

  test('For CarBookingMailerBloc class ==> sendCarBookingMailer() Values', () {
    bloc.sendCarBookingMailer('', '', '', '');
    expect(bloc.state.carBookingMailerStatus, CarBookingMailerState.loading);
  });

  test('For CarBookingMailerBloc class ==> sendCarBookingMailer() Failure',
      () async {
    bloc.carBookingMailerUseCases = failureMock;
    bloc.sendCarBookingMailer('', '', '', '');

    Either<Failure, CarBookingMailerModelDomain>? result =
        (await failureMock.sendBookingCarMailer(
      CarBookingMailerArgumentDomain(confirmNo: "", mailId: "", bookingUrn: ""),
    ));
    expect(result?.isLeft, true);
  });

  test('For CarBookingMailerBloc class ==> sendCarBookingMailer() Success',
      () async {
    bloc.carBookingMailerUseCases = successMock;
    bloc.sendCarBookingMailer('', '', '', '');

    Either<Failure, CarBookingMailerModelDomain>? result =
        (await successMock.sendBookingCarMailer(
      CarBookingMailerArgumentDomain(confirmNo: "", mailId: "", bookingUrn: ""),
    ));
    expect(result?.isRight, true);
  });
}
