import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/reservation_room_info_view_model.dart';

void main() {
  test('For RoomDetails class Test', () {
    final actual = RoomDetails(
      roomType: '',
      category: '',
      numberOfRooms: 1,
    );

    expect(actual.numberOfRooms, 1);
  });

  test('For FacilityList class Test', () {
    final actual = FacilityList(
      key: 'key',
      value: 'value',
    );

    expect(actual.key, 'key');
    expect(actual.value, 'value');
  });
}
