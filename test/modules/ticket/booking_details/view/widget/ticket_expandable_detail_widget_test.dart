import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tickets/booking_details/view/widget/ticket_expandable_detail_widget.dart';
import 'package:ota/modules/tickets/booking_details/view_model/ticket_booking_details_view_model.dart';
import 'package:ota/modules/tours/reservation/helper/tour_expandable_controller.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_expandable_view_model.dart';
import '../../../../../helper/material_wrapper.dart';

void main() {
  final TourExpandableController controller = TourExpandableController();
  testWidgets('Ticket Expandable Detail Widget', (tester) async {
    Widget widget = getMaterialWrapper(
      TicketExpandableDetailWidget(
        controller: controller,
        title: "Dream World(Hello We Sell Tour & Ticket)",
        facilityMap: [
          TicketBookingDetailsHighlight(value: "Full day tour starts at 08:00 AM",key: "ticketTime")
        ],
        ticketType: [
          TicketBookingDetailsTicketTypeInfo(
              paxId: "MA21110021",
              name: "ผู้ใหญ่",
              price: 100,
              noOfTickets: 1)
        ],
      ),
    );
    controller.state.state = TourExpandableModelState.expanded;
    controller.emit(controller.state);
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
