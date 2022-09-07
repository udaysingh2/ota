import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tickets/reservation/view/widget/ticket_detail_widget.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_review_reservation_view_model.dart';
import 'package:ota/modules/tours/reservation/helper/tour_expandable_controller.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_expandable_view_model.dart';
import '../../../../../helper/material_wrapper.dart';

void main() {
  final TourExpandableController controller = TourExpandableController();
  testWidgets('Ticket Detail Widget', (tester) async {
    Widget widget = getMaterialWrapper(
      TicketDetailWidget(
        controller: controller,
        title: "บัตรเข้าเมืองหิมะ ทุกสัญชาติ (ต้องซื้อบัตรเข้าสวนสนุกก่อน) PaxType",
        facilityMap: [
          TicketHighlight(value: "Full day tour starts at 09:00 AM",key: "ticketTime")
        ],
        ticketType: [
          TicketTypeViewModel(
              paxId: "MA01010002",
              name: "ADULT",
              price: 904.12,
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
