import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/car_rental/car_booking_cancellation/models/car_booking_cancellation_model.dart';
import 'package:ota/domain/car_rental/car_booking_cancellation/use_cases/car_booking_cancellation_use_cases.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/view_model/cancellation_reason_view_model.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/view_model/car_booking_cancellation_argument.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/view_model/car_booking_cancellation_view_model.dart';

String _kSuccessCode = "1000";

class CarBookingCancellationBloc extends Bloc<CarBookingCancellationViewModel> {
  @override
  CarBookingCancellationViewModel initDefaultValue() {
    return CarBookingCancellationViewModel(
      state: CarBookingCancellationScreenStates.initial,
      cancellationReasonViewModel: CancellationReasonViewModel(
          cancellationReason: '', isSelected: false),
    );
  }

  Future<void> getCarBookingCancellationData(
      CarBookingCancellationArgument? argument) async {
    emit(CarBookingCancellationViewModel(
        state: CarBookingCancellationScreenStates.loading));
    if (argument == null) {
      emit(CarBookingCancellationViewModel(
          state: CarBookingCancellationScreenStates.failure));
      return;
    }
    CarBookingCancellationUseCases carBookingCancellationUseCases =
        CarBookingCancellationUseCasesImpl();
    await _mapCarBookingCancellationData(
        carBookingCancellationUseCases, argument);
  }

  Future<void> _mapCarBookingCancellationData(
      CarBookingCancellationUseCases carBookingCancellationUseCases,
      CarBookingCancellationArgument argument) async {
    Either<Failure, CarBookingCancellationModelDomain?>? result =
        await carBookingCancellationUseCases
            .getCarBookingCancellationData(argument);
    if (result?.isRight ?? false) {
      CarBookingCancellationModelDomain? data = result!.right;
      if (data != null && data.status?.code == _kSuccessCode) {
        emit(CarBookingCancellationViewModel(
            state: CarBookingCancellationScreenStates.success,
            data: CarBookingCancellationData.fromDomain(data)));
      } else {
        emit(CarBookingCancellationViewModel(
            state: CarBookingCancellationScreenStates.bookingCancelFailure,
            data: CarBookingCancellationData.fromDomain(data!)));
      }
    } else {
      if (result?.left is InternetFailure) {
        emit(CarBookingCancellationViewModel(
            state: CarBookingCancellationScreenStates.failureNetwork));
      } else {
        emit(CarBookingCancellationViewModel(
            state: CarBookingCancellationScreenStates.failure));
      }
    }
  }
}
