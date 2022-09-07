import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/modules/tickets/reservation/bloc/ticket_traveller_detail_controller.dart';
import 'package:ota/modules/tickets/reservation/view/widget/ticket_package_traveller_detail_widget.dart';
import 'package:ota/modules/tours/reservation/view/widget/user_detail_widget.dart';

void main() {
  final TicketTravellerController ticketTravellerController =
      TicketTravellerController();
  testWidgets('TicketPackageTravellerDetailWidget',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        MaterialApp(
          routes: AppRoutes.getRoutes(),
          home: Scaffold(
              body: TicketPackageTravellerDetailWidget(
            ticketCount: 2,
            ticketTravellerController: ticketTravellerController,
          )),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byType(UserDetailsWidget).last);
    });
  });
}
