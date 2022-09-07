import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/room_detail/view/widgets/hotel_room_facility.dart';

void main() {
  // Map<String, dynamic> map = {"key": "WIFI", "value": "1"};
  List<String> roomFacility = ['Ac conditionor', 'Wifi'];
  testWidgets("room Facility test", (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: HotelRoomFacility(facilityList: roomFacility)));
    await tester.pumpAndSettle();
  });
}
