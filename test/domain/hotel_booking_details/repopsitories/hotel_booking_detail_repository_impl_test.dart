import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/hotel/hotel_booking_details/data_sources/hotel_booking_detail_mock.dart';
import 'package:ota/domain/hotel/hotel_booking_details/data_sources/hotel_booking_details_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_booking_details/models/hotel_booking_detail_model_domain.dart';
import 'package:ota/domain/hotel/hotel_booking_details/models/hotel_booking_details_argument_model.dart';
import 'package:ota/domain/hotel/hotel_booking_details/repositories/hotel_booking_detail_repository_impl.dart';

import '../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../modules/hotel/repositories/internet_success_mock.dart';

class HotelBookingDetailRemoteDataSourceFailureMock
    implements HotelBookingDetailRemoteDataSource {
  @override
  Future<HotelBookingDetailModelDomain> getHotelBookingDetail(
      HotelBookingDetailArgumentDomain argument) {
    throw exp.ServerException(null);
  }
}

void main() {
  HotelBookingDetailRepository? hotelBookingDetailRepositoryMock;
  HotelBookingDetailRepository? hotelBookingDetailRepositoryInternetFailure;
  HotelBookingDetailRepository? hotelBookingDetailRepositoryServerException;

  HotelBookingDetailArgumentDomain argument =
      HotelBookingDetailArgumentDomain(bookingUrn: '', confirmationNo: '');

  setUpAll(() async {
    /// Code coverage for default implementation.
    hotelBookingDetailRepositoryMock = HotelBookingDetailRepositoryImpl();

    /// Code coverage for mock class
    hotelBookingDetailRepositoryMock = HotelBookingDetailRepositoryImpl(
        remoteDataSource: HotelBookingDetailMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    hotelBookingDetailRepositoryServerException =
        HotelBookingDetailRepositoryImpl(
            remoteDataSource: HotelBookingDetailRemoteDataSourceFailureMock(),
            internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    hotelBookingDetailRepositoryInternetFailure =
        HotelBookingDetailRepositoryImpl(
            remoteDataSource: HotelBookingDetailRemoteDataSourceFailureMock(),
            internetInfo: InternetFailureMock());
  });

  test(
      'Hotel Booking Cancellation analytics Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final result =
        await hotelBookingDetailRepositoryMock!.getHotelBookingDetail(argument);

    /// Get model from mock data.
    final HotelBookingDetailModelDomain bookingData = result.right;

    /// Condition check for booking data value null
    expect(bookingData.data != null, true);
  });

  test(
      'Hotel Booking Cancellation analytics Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final result = await hotelBookingDetailRepositoryInternetFailure!
        .getHotelBookingDetail(argument);

    expect(result.isLeft, true);
  });

  test(
      'Hotel Booking Cancellation analytics Repository'
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final result = await hotelBookingDetailRepositoryServerException!
        .getHotelBookingDetail(argument);

    expect(result.isLeft, true);
  });
}
