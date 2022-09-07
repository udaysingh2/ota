import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view/widgets/reservation_room_info/reservation_room_info_widget.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/reservation_room_info_view_model.dart';

import '../../../../../../helper/material_wrapper.dart';

void main() {
  List<RoomDetails>? getRoomDetailsList = [
    RoomDetails(category: "superior", numberOfRooms: 2, roomType: "single bed"),
    RoomDetails(category: "superior", numberOfRooms: 1, roomType: "twin bed")
  ];

  List<FacilityList>? getFacilityList = [
    FacilityList(key: "Wifi", value: "free.wifi"),
    FacilityList(key: "Breakfast", value: "breakfast"),
  ];
  testWidgets('Rating Count widget Test', (tester) async {
    Widget widget = getMaterialWrapper(
      ReservationRoomInfo(
        facilityMap: getFacilityList,
        roomDetailsList: getRoomDetailsList,
        imageUrl:
            "https://manage.robinhood.in.th/ImageData/Hotel/amora_neoluxe_bangkok-general1.jpg",
        offerName: "Superior room only Superior room r...",
        pricePerNight: 1200,
        propertyName: "Rimping Boutique Chiangmai ",
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
