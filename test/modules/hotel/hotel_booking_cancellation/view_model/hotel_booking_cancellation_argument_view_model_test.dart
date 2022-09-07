import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/hotel_booking_cancellation_argument_view_model.dart';

void main() {
  test('For class HotelBookingCancellationArgumentViewModel then', () {
    HotelBookingCancellationArgumentViewModel model = getArgs();

    expect(model.bookingStatus.isNotEmpty, true);
    expect(model.cancellationPolicyList?.isEmpty, true);
    expect(model.bookingStatus, 'SUCCESS');
  });
}

HotelBookingCancellationArgumentViewModel getArgs() =>
    HotelBookingCancellationArgumentViewModel(
      confirmNo: 'confirmNo',
      bookingUrn: 'bookingUrn',
      bookingStatus: 'SUCCESS',
      cancellationPolicyList: [],
    );
