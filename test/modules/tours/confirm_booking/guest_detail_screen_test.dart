import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/modules/tours/confirm_booking/view/guest_detail_screen.dart';
import 'package:ota/modules/tours/confirm_booking/view_model/tour_confirm_booking_view_model.dart';

import '../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Tour Guest Detail Screen', (WidgetTester tester) async {
    List<ParticipantInfoViewModel> argument = [
      ParticipantInfoViewModel(
          paxId: "adult",
          name: "Steve",
          dateOfBirth: "01-01-1999",
          passportCountry: "Australia",
          passportCountryIssue: "Australia",
          weight: 55.00,
          expiryDate: "01-01-2030",
          passportNumber: "ABC123",
          surname: "Smith"),
      ParticipantInfoViewModel(
          paxId: "adult",
          name: "Ross",
          dateOfBirth: "01-01-1998",
          passportCountry: "NewZealand",
          passportCountryIssue: "NewZealand",
          weight: 55.00,
          expiryDate: "01-01-2030",
          passportNumber: "XYZ123",
          surname: "Taylor"),
      ParticipantInfoViewModel(
          paxId: "child",
          name: "Joe",
          dateOfBirth: "01-01-2002",
          passportCountry: "England",
          passportCountryIssue: "England",
          weight: 55.00,
          expiryDate: "01-01-2030",
          passportNumber: "PQR123",
          surname: "Root"),
    ];
    Widget widget = getMaterialWrapperWithArguments(
        const GuestDetailScreen(), AppRoutes.guestDetailScreen, argument);
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
