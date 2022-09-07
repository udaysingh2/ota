import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_reserve_details_widget.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Tour reserve details widget', (tester) async {
    Widget widget = getMaterialWrapper(TourReserveDetailsWidget(
      packageDate: Helpers().parseDateTime(
        Helpers.getYYYYmmddFromDateTime(
            DateTime.now().add(const Duration(days: 1))),
      ),
      contactName: "MILD MARADENA",
      numberOfDays: "1",
      noOfParticipants: "3",
      activityDuration: "4 Hours",
      participationInformation: "Thai",
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
