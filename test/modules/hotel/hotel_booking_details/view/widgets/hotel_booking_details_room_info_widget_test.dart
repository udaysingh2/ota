import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view/widgets/hotel_details_room_info/hotel_booking_details_room_info_widget.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view_model/hotel_booking_details_room_info_view_model.dart';

import '../../../../../helper.dart';

void main() {
  testWidgets("hotel booking room info widget test ", (tester) async {
    Widget widget = getMaterialWrapper(HotelBookingDetailsRoomInfoWidget(
      address: "",
      facilityMap: [
        HotelBookingDetailsFacilityList(
          key: "",
          value: "",
        )
      ],
      imageUrl: "",
      offerName: "",
      pricePerNight: 2,
      propertyName: "",
      starRating: 2,
      roomDetailsList: [
        HotelBookingDetailsRoomDetails(
          category: "",
          numberOfRooms: 2,
          roomType: "",
        )
      ],
      longitude: 2,
      latitude: 2,
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Text), findsWidgets);
  });
}
