import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/models/car_booking_mailer_argument_domain.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/models/car_booking_mailer_model_domain.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/use_cases/car_booking_mailer_use_cases.dart';
import 'package:ota/modules/car_rental/car_booking_mailer/view_model/car_booking_mailer_view_model.dart';

const String _kStatusSuccess = 'success';

class CarBookingMailerBloc extends Bloc<CarBookingMailerViewModel> {
  CarBookingMailerUseCases carBookingMailerUseCases =
      CarBookingMailerUseCasesImpl();
  @override
  initDefaultValue() {
    return CarBookingMailerViewModel(actionStatus: '');
  }

  void sendCarBookingMailer(String? confirmNo, String? mailId,
      String? bookingUrn, String? serviceName) async {
    if (confirmNo != null && mailId != null) {
      state.carBookingMailerStatus = CarBookingMailerState.failure;
      emit(state);
    }

    state.carBookingMailerStatus = CarBookingMailerState.loading;
    emit(state);

    Either<Failure, CarBookingMailerModelDomain>? result =
        await carBookingMailerUseCases.sendBookingCarMailer(
      CarBookingMailerArgumentDomain(
          confirmNo: confirmNo!,
          mailId: mailId!,
          bookingUrn: bookingUrn,
          serviceName: serviceName),
    );

    if (result != null && result.isRight) {
      state.actionStatus =
          result.right.sendEmailConfirmation?.data?.actionStatus ?? '';
      state.carBookingMailerStatus = CarBookingMailerState.success;
      emit(state);
    } else {
      if (result?.left is InternetFailure) {
        state.carBookingMailerStatus = CarBookingMailerState.failureNetwork;
        emit(state);
      } else {
        state.carBookingMailerStatus = CarBookingMailerState.failure;
        emit(state);
      }
    }
  }

  void resetState() {
    state.carBookingMailerStatus = CarBookingMailerState.none;
  }

  bool isLoading() =>
      state.carBookingMailerStatus == CarBookingMailerState.loading;

  bool isFailure() =>
      state.carBookingMailerStatus == CarBookingMailerState.failure;

  bool isFailureNetwork() =>
      state.carBookingMailerStatus == CarBookingMailerState.failureNetwork;

  bool isActionStatusSuccess() => state.actionStatus == _kStatusSuccess;

  bool isSuccess() =>
      state.carBookingMailerStatus == CarBookingMailerState.success;
}
