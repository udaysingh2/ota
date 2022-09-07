import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core_pack/custom_widgets/ota_reservation_details_widget.dart';

import '../../helper/material_wrapper.dart';

void main() {
  testWidgets('Reservation Details Widget ...', (tester) async {
    await tester.pumpWidget(getMaterialWrapper(OtaReservationDetailsWidget(
      checkInDate: Helpers().parseDateTime(Helpers.getYYYYmmddFromDateTime(
          DateTime.now().add(const Duration(days: 1)))),
      checkOutDate: Helpers().parseDateTime(Helpers.getYYYYmmddFromDateTime(
          DateTime.now().add(const Duration(days: 2)))),
      numberOfAdults: 2,
      numberOfNights: 1,
      numberOfRooms: 1,
      numberOfChildren: 2,
    )));
    await tester.pumpAndSettle();
  });
}
