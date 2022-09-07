import 'package:ota/domain/tours/tour_booking_cancellation/models/tours_booking_cancellation_model_domain.dart';
import 'package:ota/modules/tours/tour_booking_cancellation/view_model/tour_cancellation_reason_view_model.dart';

const _kSuccess = 'success';
const _kFailure = 'fail';

class TourBookingCancellationViewModel {
  final TourBookingCancellationData? data;
  final TourBookingCancellationScreenStates state;
  final TourCancellationReasonViewModel? cancellationReasonViewModel;
  TourBookingCancellationViewModel({
    required this.state,
    this.data,
    this.cancellationReasonViewModel,
  });
}

class TourBookingCancellationData {
  TourCancellationStatus actionStatus;
  String? cancellationDate;
  double? totalAmount;
  RefundData? refundData;

  TourBookingCancellationData({
    required this.actionStatus,
    this.cancellationDate,
    this.totalAmount,
    this.refundData,
  });

  factory TourBookingCancellationData.fromDomain(GetTourBookingReject data) {
    return TourBookingCancellationData(
      actionStatus: getCancellationStatus(data.data!.actionStatus!),
      cancellationDate: data.data!.cancellationDate,
      totalAmount: data.data!.totalAmount,
      refundData: _getRefundData(data.data!.refund),
    );
  }

  static RefundData _getRefundData(Refund? data) {
    return RefundData(
        refundAmount: data?.refundAmount,
        reservationCancellationFee: data?.reservationCancellationFee,
        processingFee: data?.processingFee);
  }

  static TourCancellationStatus getCancellationStatus(String status) {
    switch (status) {
      case _kSuccess:
        return TourCancellationStatus.success;
      case _kFailure:
        return TourCancellationStatus.failure;
      default:
        return TourCancellationStatus.failure;
    }
  }
}

class RefundData {
  final double? reservationCancellationFee;
  final double? processingFee;
  final double? refundAmount;
  RefundData(
      {this.reservationCancellationFee, this.processingFee, this.refundAmount});
}

enum TourBookingCancellationScreenStates {
  initial,
  loading,
  success,
  failure,
  failure1899,
  internetFailure,
}

enum TourCancellationStatus { success, failure }
