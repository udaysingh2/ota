import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/hotel/hotel_booking/data_sources/hotel_booking_list_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_booking/models/hotel_booking_argument_domain.dart';
import 'package:ota/domain/hotel/hotel_booking/repositories/hotel_booking_list_repository_impl.dart';

import '../../repositories/internet_success_mock.dart';
import '../repositories/hotel_booking_mock_graphql.dart';

void main() {
  GraphQlResponse graphQlResponseRoom = MockHotelBookingDetailGraphQl();
  HotelBookingListRepository? hotelBookingListRepository;

  hotelBookingListRepository = HotelBookingListRepositoryImpl();

  /// Code coverage for mock class
  HotelBookingListRemoteDataSourceImpl.setMock(graphQlResponseRoom);
  hotelBookingListRepository = HotelBookingListRepositoryImpl(
      remoteDataSource: HotelBookingListRemoteDataSourceImpl(),
      internetInfo: InternetSuccessMock());
  test("RoomDetail Data Source", () {
    HotelBookingListRemoteDataSource hotelBookingListRemoteDataSource =
        HotelBookingListRemoteDataSourceImpl();
    HotelBookingListRemoteDataSourceImpl.setMock(graphQlResponseRoom);
    hotelBookingListRemoteDataSource.getHotelBookingListData(args);
  });
  test(
      'Room Detail analytics Repository '
      'When calling getRoomDetailData '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResult =
        await hotelBookingListRepository!.getHotelBookingListData(args);

    /// Condition check for hotel value null
    expect(consentResult.isLeft, false);
  });
}

HotelBookingArgumentDomain args = HotelBookingArgumentDomain(
  serviceType: 'HOTEL',
  activityType: 'CANCELLED',
  limit: 10,
  pageNo: 0,
);
