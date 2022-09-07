import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ota/core_pack/graphql/queries/queries_room_reservation.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_data_argument.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockedSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  test('Queries Ota Filter OS...', () async {
    String str = QueriesRoomReservation.getHotelAddonServicesData(
        HotelServiceDataArgument(
            hotelId: "",
            checkInDate: "",
            checkOutDate: "",
            currency: "",
            limit: 1,
            offset: 1));
    expect(str.isEmpty, false);
  });
}
