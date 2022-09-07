import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/booking_initiate/data_sources/reservation_remote_data_source.dart';
import 'package:ota/domain/hotel/booking_initiate/data_sources/reservation_remote_data_source_mock.dart';
import 'package:ota/domain/hotel/booking_initiate/models/argument_data_model.dart';

void main() {
  ReservationDataArgument argument = ReservationDataArgument(
    hotelId: 'MA0511000344',
    cityId: 'MA05110041',
    checkInDate: '2021-11-01',
    checkOutDate: '2021-12-02',
    room: [],
    currency: 'THB',
    countryId: 'MA05110001',
    roomCode: 'MA07080326',
    roomCategory: 1,
    price: 170500.0,
    supplierId: 'CL213',
    supplierName: 'Mark All Services Co., Ltd',
    mealCode: 'BB',
  );

  TestWidgetsFlutterBinding.ensureInitialized();

  group("Reservation mock data source group", () {
    test('Reservation data source', () async {
      ReservationDataSource reservationRemoteDataSource =
          ReservationMockDataSourceImpl();
      reservationRemoteDataSource.getRoomDetail(argument);
    });
    test(
        'Reservation analytics Repository '
        'With Success response data', () async {
      /// Consent user cases impl
      ReservationDataSource reservationRemoteDataSource =
          ReservationMockDataSourceImpl();
      final result = await reservationRemoteDataSource.getRoomDetail(argument);

      /// Condition check for hotel value null
      expect(result.data != null, false);
    });
  });
}
