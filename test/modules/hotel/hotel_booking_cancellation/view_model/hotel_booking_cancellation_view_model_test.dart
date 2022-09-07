import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/domain/hotel/hotel_booking_cancellation/models/hotel_booking_cancellation_model.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/cancellation_reason_view_model.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/hotel_booking_cancellation_argument.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/hotel_booking_cancellation_view_model.dart';

void main() {
  test('For class HotelBookingCancellationViewModel Test', () {
    HotelBookingCancellationViewModel model = getHotelBookingCancellation();

    expect(model.state, HotelBookingCancellationScreenStates.initial);
    expect(model.cancellationReasonViewModel?.isSelected, true);
    expect(model.data != null, true);
    expect(model.data?.actionStatus, CancellationStatus.success);
    expect(model.data?.totalAmount, 1000.0);
  });

  test('For class HotelBookingCancellationData Test', () {
    HotelBookingCancellationData model = getCancellationData();
    expect(model.actionStatus, CancellationStatus.success);
    expect(model.totalAmount, 1000.0);
    expect(model.cancellationDate?.isNotEmpty, true);
    expect(model.refundData != null, true);
  });

  test('For class HotelBookingCancellationData.fromDomain Test', () {
    HotelBookingCancellationData model =
        HotelBookingCancellationData.fromDomain(
      getModelDomain(),
      getCancellationArgs(),
    );

    expect(model.actionStatus, CancellationStatus.success);
    expect(model.cancellationDate?.isNotEmpty, true);
    expect(model.actionStatus, CancellationStatus.success);
  });
}

HotelBookingCancellationViewModel getHotelBookingCancellation() =>
    HotelBookingCancellationViewModel(
      state: HotelBookingCancellationScreenStates.initial,
      cancellationReasonViewModel: CancellationReasonViewModel(
        isSelected: true,
        cancellationReason: 'Plan Cancelled',
      ),
      data: HotelBookingCancellationData(
        actionStatus: CancellationStatus.success,
        totalAmount: 1000.0,
        cancellationDate: '06-05-2022',
        refundData: RefundData(
          reservationCancellationFee: 100.0,
          processingFee: 100.0,
          refundAmount: 800.0,
        ),
      ),
    );

HotelBookingCancellationData getCancellationData() =>
    HotelBookingCancellationData(
      actionStatus: CancellationStatus.success,
      totalAmount: 1000.0,
      cancellationDate: '06-05-2022',
      refundData: RefundData(
        reservationCancellationFee: 100.0,
        processingFee: 100.0,
        refundAmount: 800.0,
      ),
    );

HotelBookingCancellationModelDomain getModelDomain() =>
    HotelBookingCancellationModelDomain(
      data: HotelBookingCancellationDataDomain(
        actionStatus: 'success',
        totalAmount: 1000.0,
        cancellationDate: Helpers().parseDateTime('06-05-2022'),
        refund: Refund(
          reservationCancellationFee: 100.0,
          processingFee: 100.0,
          refundAmount: 800.0,
        ),
      ),
    );

HotelBookingCancellationArgument getCancellationArgs() =>
    HotelBookingCancellationArgument(
      confirmNo: '',
      reason: '',
    );
