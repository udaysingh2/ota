import 'package:ota/domain/car_rental/car_booking_cancellation/models/car_booking_cancellation_model.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/view_model/cancellation_reason_view_model.dart';

const _kSuccess = '1000';

class CarBookingCancellationViewModel {
  final CarBookingCancellationData? data;
  final CarBookingCancellationScreenStates state;
  final CancellationReasonViewModel? cancellationReasonViewModel;
  CarBookingCancellationViewModel({
    required this.state,
    this.data,
    this.cancellationReasonViewModel,
  });
}

class CarBookingCancellationData {
  String actionStatus;
  String message;

  factory CarBookingCancellationData(
      {required String actionStatus, required String message}) {
    return CarBookingCancellationData._named(
        actionStatus: actionStatus, message: message);
  }

  CarBookingCancellationData._named(
      {required this.actionStatus, required this.message});

  factory CarBookingCancellationData.fromDomain(
      CarBookingCancellationModelDomain data) {
    return CarBookingCancellationData(
        actionStatus: data.data?.actionStatus ?? "",
        message: data.status?.description ?? "");
  }

  static CancellationStatus getCancellationStatus(String? status) {
    return status == _kSuccess
        ? CancellationStatus.success
        : CancellationStatus.failure;
  }
}

enum CarBookingCancellationScreenStates {
  initial,
  loading,
  success,
  failure,
  failureNetwork,
  bookingCancelFailure
}

enum CancellationStatus { success, failure }
