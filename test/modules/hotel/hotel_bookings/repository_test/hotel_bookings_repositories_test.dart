import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_booking/data_sources/hotel_booking_list_remote_mock.dart';
import 'package:ota/domain/hotel/hotel_booking/models/hotel_booking_argument_domain.dart';
import 'package:ota/domain/hotel/hotel_booking/models/hotel_booking_list_model_domain.dart';
import 'package:ota/domain/hotel/hotel_booking/repositories/hotel_booking_list_repository_impl.dart';

import '../../repositories/internet_failure_mock.dart';
import '../../repositories/internet_success_mock.dart';
import '../repositories/hotel_booking_data_source_server_failure_mock.dart';

void main() {
  HotelBookingListRepository? hotelBookingListRepositoryServerException;
  HotelBookingListRepository? hotelBookingListRepositoryMock;
  HotelBookingListRepository? hotelBookingListRepositoryInternetFailure;
  setUpAll(() async {
    /// Code coverage for default implementation.
    hotelBookingListRepositoryMock = HotelBookingListRepositoryImpl();

    /// Code coverage for mock class
    hotelBookingListRepositoryMock = HotelBookingListRepositoryImpl(
        remoteDataSource: HotelBookingListMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    /// Server Exception
    hotelBookingListRepositoryServerException = HotelBookingListRepositoryImpl(
        remoteDataSource: HotelBookingsServerFailureDataSourceMock(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    hotelBookingListRepositoryInternetFailure = HotelBookingListRepositoryImpl(
        remoteDataSource: HotelBookingListMockDataSourceImpl(),
        internetInfo: InternetFailureMock());
  });

  test(
      'Hotel Booking List analytics Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResult =
        await hotelBookingListRepositoryMock!.getHotelBookingListData(args);

    /// Get model from mock data.
    final HotelBookingListModelDomain model = consentResult.right;

    /// Condition check for hotel value null
    expect(model.getBookingSummaryV2 != null, true);
  });

  test(
      'Hotel Booking List analytics Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final consentResult = await hotelBookingListRepositoryInternetFailure!
        .getHotelBookingListData(args);

    expect(consentResult.isLeft, true);
  });

  test(
      'Hotel Booking List analytics Repository '
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final consentResult = await hotelBookingListRepositoryServerException!
        .getHotelBookingListData(args);

    expect(consentResult.isLeft, true);
  });
}

HotelBookingArgumentDomain args = HotelBookingArgumentDomain(
  serviceType: 'HOTEL',
  activityType: 'CANCELLED',
  limit: 10,
  pageNo: 0,
);
