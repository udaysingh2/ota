import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/hotel/booking_initiate/data_sources/reservation_remote_data_source.dart';
import 'package:ota/domain/hotel/booking_initiate/data_sources/reservation_remote_data_source_mock.dart';
import 'package:ota/domain/hotel/booking_initiate/models/argument_data_model.dart';
import 'package:ota/domain/hotel/booking_initiate/models/booking_data_model.dart';
import 'package:ota/domain/hotel/booking_initiate/repositories/reservation_repository_impl.dart';

import '../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../modules/hotel/repositories/internet_success_mock.dart';

class ReservationRemoteDataSourceFailureMock implements ReservationDataSource {
  @override
  Future<BookingData> getRoomDetail(ReservationDataArgument argument) {
    throw exp.ServerException(null);
  }
}

void main() {
  ReservationRepository? reservationRepositoryMock;
  ReservationRepository? reservationRepositoryInternetFailure;
  ReservationRepository? reservationRepositoryServerException;

  List<RoomCapacity> _getDefaultArgument() {
    return <RoomCapacity>[
      RoomCapacity(
        adult: 2,
        children: 2,
        childAge1: 2,
        childAge2: 3,
      ),
    ];
  }

  ReservationDataArgument argument = ReservationDataArgument(
    hotelId: 'MA0511000344',
    cityId: 'MA05110041',
    checkInDate: '2021-11-01',
    checkOutDate: '2021-12-02',
    room: _getDefaultArgument(),
    currency: 'THB',
    countryId: 'MA05110001',
    roomCode: 'MA07080326',
    roomCategory: 1,
    price: 170500.0,
    supplierId: 'CL213',
    supplierName: 'Mark All Services Co., Ltd',
    mealCode: 'BB',
  );

  setUpAll(() async {
    /// Code coverage for default implementation.
    reservationRepositoryMock = ReservationRepositoryImpl();

    /// Code coverage for mock class
    reservationRepositoryMock = ReservationRepositoryImpl(
        remoteDataSource: ReservationMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    reservationRepositoryServerException = ReservationRepositoryImpl(
        remoteDataSource: ReservationRemoteDataSourceFailureMock(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    reservationRepositoryInternetFailure = ReservationRepositoryImpl(
        remoteDataSource: ReservationMockDataSourceImpl(),
        internetInfo: InternetFailureMock());
  });

  test(
      'Reservation analytics Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final result = await reservationRepositoryMock!.getRoomDetail(argument);

    /// Get model from mock data.
    final BookingData? bookingData = result.right;

    /// Condition check for hotel value null
    expect(bookingData?.data != null, false);
  });

  test(
      'Reservation analytics Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final result =
        await reservationRepositoryInternetFailure!.getRoomDetail(argument);

    expect(result.isLeft, true);
  });

  test(
      'Reservation analytics Repository'
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final result =
        await reservationRepositoryServerException!.getRoomDetail(argument);

    expect(result.isLeft, true);
  });
}
