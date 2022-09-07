import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ota/core_pack/graphql/queries/queries_reservation_detail.dart';
import 'package:ota/domain/hotel/booking_initiate/models/argument_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockedSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  test('OTA Queries Filter Sort ...', () async {
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
    String str = QueriesReservation.getData(argument);
    expect(str.isEmpty, false);
  });
}
