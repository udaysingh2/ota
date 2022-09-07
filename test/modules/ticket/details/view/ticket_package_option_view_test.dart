import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/domain/tickets/details/models/ticket_details_model.dart';
import 'package:ota/modules/tickets/details/view/widget/ticket_package_option_view.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_view_model.dart';
import 'package:ota/modules/tickets/package_details/view_model/ticket_package_detail_view_model.dart';

import '../../../../helper/material_wrapper.dart';

void main() {
  TicketPackage ticketPackage = TicketPackage(
      packageDetail: TicketPackageDetail(
    currency: "THB",
    name: "Snow Town Admission Tickets (all nationalities)",
    rateKey: "TUEyMTEwMDAwMzcz",
    refCode: "CL213",
    serviceId: "MA2111000168",
    totalPrice: 1000.00,
    zoneId: "MA21110048",
    highlights: [
      TicketHighlight.mapFromTicketHighlight(
          Highlight(key: "isNonRefund", value: "Refundable")),
    ],
    ticketTypes: [
      TicketTypeData.mapFromTicketType(TicketType(
          available: 200,
          minimum: 2,
          name: "VIP xx",
          paxId: "MA01010003",
          price: 100.00))
    ],
  ));
  testWidgets('Ticket Package Option View with next Icon tap',
      (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(MaterialApp(
      routes: AppRoutes.getRoutes(),
      home: Scaffold(
        body: TicketPackageOptionView(
          ticketPackage: ticketPackage,
          onReservePress: () {},
        ),
      ),
    ));

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
  testWidgets('Ticket Package Option View with reserve now Screen',
      (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(MaterialApp(
      routes: AppRoutes.getRoutes(),
      home: Scaffold(
        body: TicketPackageOptionView(
          ticketPackage: ticketPackage,
          onReservePress: () {
            debugPrint("Reserve Now");
          },
        ),
      ),
    ));

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key("OtaTextButton")));
    await tester.pump();
  });
}
