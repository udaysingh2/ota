import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/hotel/hotel_booking_cancellation/data_source/hotel_booking_cancellation_mock.dart';
import 'package:ota/domain/hotel/hotel_booking_cancellation/data_source/hotel_booking_cancellation_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_booking_cancellation/models/hotel_booking_cancellation_model.dart';
import 'package:ota/domain/hotel/hotel_booking_cancellation/repositories/hotel_booking_cancellation_repository_impl.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/hotel_booking_cancellation_argument.dart';
import '../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../modules/hotel/repositories/internet_success_mock.dart';

class HotelBookingCancellationRemoteDataSourceFailureMock
    implements HotelBookingCancellationRemoteDataSource {
  @override
  Future<HotelBookingCancellationModelDomain> getHotelBookingCancellationData(
      HotelBookingCancellationArgument argument) {
    throw exp.ServerException(null);
  }
}

void main() {
  HotelBookingCancellationRepository? hotelBookingCancellationRepositoryMock;
  HotelBookingCancellationRepository?
      hotelBookingCancellationRepositoryInternetFailure;
  HotelBookingCancellationRepository?
      hotelBookingCancellationRepositoryServerException;

  HotelBookingCancellationArgument argument =
      HotelBookingCancellationArgument(reason: '', confirmNo: '');

  setUpAll(() async {
    /// Code coverage for default implementation.
    hotelBookingCancellationRepositoryMock =
        HotelBookingCancellationRepositoryImpl();

    /// Code coverage for mock class
    hotelBookingCancellationRepositoryMock =
        HotelBookingCancellationRepositoryImpl(
            remoteDataSource: HotelBookingCancellationMockDataSourceImpl(),
            internetInfo: InternetSuccessMock());

    hotelBookingCancellationRepositoryServerException =
        HotelBookingCancellationRepositoryImpl(
            remoteDataSource:
                HotelBookingCancellationRemoteDataSourceFailureMock(),
            internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    hotelBookingCancellationRepositoryInternetFailure =
        HotelBookingCancellationRepositoryImpl(
            remoteDataSource:
                HotelBookingCancellationRemoteDataSourceFailureMock(),
            internetInfo: InternetFailureMock());
  });

  test(
      'Hotel Booking Cancellation analytics Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final result = await hotelBookingCancellationRepositoryMock!
        .getHotelBookingCancellationData(argument);

    /// Get model from mock data.
    final HotelBookingCancellationModelDomain bookingData = result.right;

    /// Condition check for booking data value null
    expect(bookingData.data != null, true);
  });

  test(
      'Hotel Booking Cancellation analytics Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final result = await hotelBookingCancellationRepositoryInternetFailure!
        .getHotelBookingCancellationData(argument);

    expect(result.isLeft, true);
  });

  test(
      'Hotel Booking Cancellation analytics Repository'
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final result = await hotelBookingCancellationRepositoryServerException!
        .getHotelBookingCancellationData(argument);

    expect(result.isLeft, true);
  });
}
