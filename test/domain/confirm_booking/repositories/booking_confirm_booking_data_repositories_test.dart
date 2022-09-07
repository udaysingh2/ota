import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/confirm_booking/data_sources/hotel_confirm_booking_mock.dart';
import 'package:ota/domain/confirm_booking/data_sources/hotel_confirm_booking_remote_data_source.dart';
import 'package:ota/domain/confirm_booking/models/argument_data_model.dart';
import 'package:ota/domain/confirm_booking/models/booking_confirmation_data_model.dart';
import 'package:ota/domain/confirm_booking/repositories/hotel_confirm_booking_repository_impl.dart';

import '../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../modules/hotel/repositories/internet_success_mock.dart';

class ConfirmBookingRemoteDataSourceFailureMock
    implements HotelConfirmBookingRemoteDataSource {
  @override
  Future<BookingConfirmationData> getHotelConfirmBooking(
      HotelConfirmBookingArgumentModelDomain argument) {
    throw exp.ServerException(null);
  }
}

void main() {
  HotelConfirmBookingRepository? hotelConfirmBookingRepositoryMock;
  HotelConfirmBookingRepository? hotelConfirmBookingRepositoryInternetFailure;
  HotelConfirmBookingRepository? hotelConfirmBookingRepositoryServerException;
  HotelConfirmBookingArgumentModelDomain argument =
      HotelConfirmBookingArgumentModelDomain(
    bookingUrn: '',
    hotelId: '',
    additionalNeedsText: '',
    bookingForSomeoneElse: false,
    roomCode: '',
    totalPrice: 2,
    customerInfo:
        CustomerInfoDataDomain(firstName: '', lastName: '', membershipId: ''),
  );

  setUpAll(() async {
    /// Code coverage for default implementation.
    hotelConfirmBookingRepositoryMock = HotelConfirmBookingRepositoryImpl();

    /// Code coverage for mock class
    hotelConfirmBookingRepositoryMock = HotelConfirmBookingRepositoryImpl(
        remoteDataSource: HotelConfirmBookingMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    hotelConfirmBookingRepositoryServerException =
        HotelConfirmBookingRepositoryImpl(
            remoteDataSource: ConfirmBookingRemoteDataSourceFailureMock(),
            internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    hotelConfirmBookingRepositoryInternetFailure =
        HotelConfirmBookingRepositoryImpl(
            remoteDataSource: ConfirmBookingRemoteDataSourceFailureMock(),
            internetInfo: InternetFailureMock());
  });

  test(
      'Hotel landing dynamic playlist Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final result = await hotelConfirmBookingRepositoryMock!
        .getHotelConfirmBooking(argument);

    /// Get model from mock data.
    final BookingConfirmationData bookingData = result.right;

    /// Condition check for booking data value null
    expect(bookingData.data != null, true);
  });

  test(
      'hotel Dynamic Playlist Repository Internet Failure Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final result = await hotelConfirmBookingRepositoryInternetFailure!
        .getHotelConfirmBooking(argument);

    expect(result.isLeft, true);
  });

  test(
      'hotel Dynamic Playlist Repository Server Exception Repository'
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final result = await hotelConfirmBookingRepositoryServerException!
        .getHotelConfirmBooking(argument);

    expect(result.isLeft, true);
  });
}
