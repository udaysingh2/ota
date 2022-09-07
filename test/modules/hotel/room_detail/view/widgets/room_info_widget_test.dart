import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/room_detail/view/widgets/room_info_widget.dart';
import 'package:ota/modules/hotel/room_detail/view_model/room_category_view_model.dart';
import 'package:ota/modules/hotel/room_detail/view_model/room_detail_view_model.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Room Info Widget Test', (tester) async {
    Widget widget = getMaterialWrapper(HotelRoomDetailInfoWidget(facilityList: [
      FacilityModel("key", "value")
    ], roomList: [
      RoomCategoryViewModel(
          noOfRoomsAndName: "2 x DELUXE",
          roomCount: 2,
          roomName: "Super Delux",
          roomType: "Ac")
    ]));

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Text), findsWidgets);
  });
}
