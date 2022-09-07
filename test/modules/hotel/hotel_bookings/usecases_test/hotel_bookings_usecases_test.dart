import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_booking/data_sources/hotel_booking_list_remote_mock.dart';
import 'package:ota/domain/hotel/hotel_booking/models/hotel_booking_argument_domain.dart';
import 'package:ota/domain/hotel/hotel_booking/models/hotel_booking_list_model_domain.dart';
import 'package:ota/domain/hotel/hotel_booking/repositories/hotel_booking_list_repository_impl.dart';
import 'package:ota/domain/hotel/hotel_booking/usecases/hotel_booking_list_use_cases.dart';

import '../../repositories/internet_success_mock.dart';

void main() {
  HotelBookingListUseCases? hotelBookingListUseCases;
  setUpAll(() async {
    /// Code coverage for default implementation.
    hotelBookingListUseCases = HotelBookingListUseCasesImpl();

    /// Code coverage for mock class
    hotelBookingListUseCases = HotelBookingListUseCasesImpl(
        repository: HotelBookingListRepositoryImpl(
            internetInfo: InternetSuccessMock(),
            remoteDataSource: HotelBookingListMockDataSourceImpl()));
  });

  test(
      'Hotel Booking analytics use cases '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResult =
        await hotelBookingListUseCases!.getHotelBookingListData(args);

    /// Get model from mock data.
    final HotelBookingListModelDomain model = consentResult!.right;

    /// Condition check for hotel value null
    expect(model.getBookingSummaryV2 != null, true);
  });
}

HotelBookingArgumentDomain args = HotelBookingArgumentDomain(
  serviceType: 'HOTEL',
  activityType: 'CANCELLED',
  limit: 10,
  pageNo: 0,
);
