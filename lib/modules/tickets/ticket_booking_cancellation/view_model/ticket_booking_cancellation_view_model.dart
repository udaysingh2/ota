import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_model_domain.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/view_model/ticket_cancellation_reason_view_model.dart';

const _kSuccess = 'success';
const _kFailure = 'fail';

class TicketBookingCancellationViewModel {
  final TicketBookingCancellationData? data;
  final TicketBookingCancellationScreenStates state;
  final TicketCancellationReasonViewModel? cancellationReasonViewModel;
  TicketBookingCancellationViewModel({
    required this.state,
    this.data,
    this.cancellationReasonViewModel,
  });
}

class TicketBookingCancellationData {
  TicketCancellationStatus actionStatus;
  String? cancellationDate;
  double? totalAmount;
  RefundData? refundData;

  TicketBookingCancellationData({
    required this.actionStatus,
    this.cancellationDate,
    this.totalAmount,
    this.refundData,
  });

  factory TicketBookingCancellationData.fromDomain(
      GetTicketBookingReject data) {
    return TicketBookingCancellationData(
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

  static TicketCancellationStatus getCancellationStatus(String status) {
    switch (status) {
      case _kSuccess:
        return TicketCancellationStatus.success;
      case _kFailure:
        return TicketCancellationStatus.failure;
      default:
        return TicketCancellationStatus.failure;
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

enum TicketBookingCancellationScreenStates {
  initial,
  loading,
  success,
  failure,
  failure1899,
  internetFailure,
}

enum TicketCancellationStatus { success, failure }
