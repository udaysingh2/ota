import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_contact_details.dart';
import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Tour Booking Contact Details Widget', (tester) async {
    Widget widget = getMaterialWrapper(const TourBookingContactDetailsWidget(
      providerInformation: "SEA LIFE BANGKOK",
      phoneNumber: "021477789",
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
