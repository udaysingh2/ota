import 'package:ota/domain/hotel/hotel_booking_cancellation/models/hotel_booking_cancellation_model.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/cancellation_reason_view_model.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/hotel_booking_cancellation_argument.dart';

const _kSuccess = 'success';
const _kFailure = 'fail';

class HotelBookingCancellationViewModel {
  final HotelBookingCancellationData? data;
  final HotelBookingCancellationScreenStates state;
  final CancellationReasonViewModel? cancellationReasonViewModel;
  HotelBookingCancellationViewModel({
    required this.state,
    this.data,
    this.cancellationReasonViewModel,
  });
}

class HotelBookingCancellationData {
  CancellationStatus actionStatus;
  String? cancellationDate;
  double? totalAmount;
  RefundData? refundData;

  factory HotelBookingCancellationData({
    required CancellationStatus actionStatus,
    String? cancellationDate,
    double? totalAmount,
    RefundData? refundData,
  }) {
    return HotelBookingCancellationData._named(
      actionStatus: actionStatus,
      cancellationDate: cancellationDate,
      totalAmount: totalAmount,
      refundData: refundData,
    );
  }

  HotelBookingCancellationData._named({
    required this.actionStatus,
    this.cancellationDate,
    this.totalAmount,
    this.refundData,
  });

  factory HotelBookingCancellationData.fromDomain(
      HotelBookingCancellationModelDomain data,
      HotelBookingCancellationArgument argument) {
    return HotelBookingCancellationData(
      actionStatus: getCancellationStatus(data.data?.actionStatus ?? ''),
      cancellationDate: data.data?.cancellationDate.toString(),
      totalAmount: data.data?.totalAmount,
      refundData: _getRefundData(data.data?.refund),
    );
  }

  static RefundData _getRefundData(Refund? data) {
    return RefundData(
        refundAmount: data?.refundAmount,
        reservationCancellationFee: data?.reservationCancellationFee,
        processingFee: data?.processingFee);
  }

  static CancellationStatus getCancellationStatus(String? status) {
    switch (status) {
      case _kSuccess:
        return CancellationStatus.success;
      case _kFailure:
        return CancellationStatus.failure;
      default:
        return CancellationStatus.failure;
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

enum HotelBookingCancellationScreenStates {
  initial,
  loading,
  success,
  failure,
  failure1899,
  internetFailure,
}

enum CancellationStatus { success, failure }
