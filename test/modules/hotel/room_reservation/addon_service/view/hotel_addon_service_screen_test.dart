import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service/view/hotel_addon_service_screen.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service/view_model/hotel_service_view_argument.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Hotel Addon Screen Test', (tester) async {
    HotelServiceViewArgument hotelServiceViewArgument =
        HotelServiceViewArgument(
      checkInDate: '',
      checkOutDate: '',
      currency: 'THB',
      hotelId: 'hotelID',
      noOfAdults: 2,
      selectedAddons: [
        AddonServiceModel(serviceId: 'serviceID', selectedDate: DateTime(2021))
      ],
      onUpdate: (p0) {},
    );
    Widget widget = getMaterialWrapperWithArguments(
        HotelAddonServiceScreen(
          key: GlobalKey(),
        ),
        AppRoutes.hotelAddonServiceScreen,
        hotelServiceViewArgument);

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
