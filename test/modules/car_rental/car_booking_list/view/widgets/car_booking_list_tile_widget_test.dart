import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_booking_list/view/widgets/car_booking_list_tile_widget.dart';
import 'package:ota/modules/car_rental/car_booking_list/view_model/car_booking_list_view_model.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets(' Car Booking List tile test', (tester) async {
    Widget widget = getMaterialWrapper(
      CarBookingListTile(
        carBookings: CarBookingViewModel(
          bookingId: "bookingId",
          carBookingStatus: "confirmed",
          carBookingUrn: 'carBookingUrn',
          carName: 'carName',
          pickupDateTime: DateTime.now(),
          carSupplierName: 'carSupplierName',
          carTotalPrice: 1234.0,
          productType: 'productType',
          returnDateTime: DateTime.now(),
          bookingStatus: CarBookingListStatus.confirmed,
          returnExtraCharge: 500.00,
        ),
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
