import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/modules/tickets/confirm_booking/view_model/ticket_confirm_booking_model.dart';

import '../../../../helper/material_wrapper.dart';

void main() {
  List<TicketParticipantInfoViewModel> ticketParticipantList = [
    TicketParticipantInfoViewModel(
      dateOfBirth: "2000-01-01",
      expiryDate: "2029-11-05",
      name: "Unit",
      passportCountry: "Bangkok",
      passportCountryIssue: "Bangkok",
      passportNumber: "MABC1234",
      paxId: "adult",
      surname: "Test",
      weight: "68.00",
    ),
    TicketParticipantInfoViewModel(
      dateOfBirth: "2012-01-01",
      expiryDate: "2025-11-05",
      name: "Unit",
      passportCountry: "Bangkok",
      passportCountryIssue: "Bangkok",
      passportNumber: "MABC1237",
      paxId: "child",
      surname: "Test 2",
      weight: "48.00",
    ),
  ];
  testWidgets('Ticket Guest Detail Screen', (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(MaterialApp(
      routes: AppRoutes.getRoutes(),
      home: Scaffold(
        body: Builder(builder: (context) {
          return TextButton(
            child: const Text("press"),
            onPressed: () => Navigator.pushNamed(
                context, AppRoutes.ticketGuestDetailScreen,
                arguments: ticketParticipantList),
          );
        }),
      ),
    ));

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await tester.tap(find.text("press"));
    await tester.pump();
    await tester.pumpAndSettle();
  });
}
