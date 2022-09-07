import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/modules/tickets/confirm_booking/view/ticket_guest_detail_screen.dart';
import 'package:ota/modules/tickets/confirm_booking/view_model/ticket_confirm_booking_model.dart';

import '../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Ticket Guest Detail Screen', (WidgetTester tester) async {
    List<TicketParticipantInfoViewModel> argument = [
      TicketParticipantInfoViewModel(
          paxId: "MA21110020",
          name: "Steve",
          dateOfBirth: "01-01-1999",
          passportCountry: "Australia",
          passportCountryIssue: "Australia",
          weight: "55.00",
          expiryDate: "01-01-2030",
          passportNumber: "ABC123",
          surname: "Smith"),
      TicketParticipantInfoViewModel(
          paxId: "MA21110021",
          name: "Ross",
          dateOfBirth: "01-01-1998",
          passportCountry: "NewZealand",
          passportCountryIssue: "NewZealand",
          weight: "55.00",
          expiryDate: "01-01-2030",
          passportNumber: "XYZ123",
          surname: "Taylor"),
      TicketParticipantInfoViewModel(
          paxId: "MA21110022",
          name: "Joe",
          dateOfBirth: "01-01-2002",
          passportCountry: "England",
          passportCountryIssue: "England",
          weight: "55.00",
          expiryDate: "01-01-2030",
          passportNumber: "PQR123",
          surname: "Root"),
    ];
    Widget widget = getMaterialWrapperWithArguments(
        const TicketGuestDetailScreen(),
        AppRoutes.ticketGuestDetailScreen,
        argument);
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
