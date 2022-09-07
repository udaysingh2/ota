import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/modules/tickets/details/view/widget/ticket_package_option_view.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_view_model.dart';

void main() {
  testWidgets('Ticket Package Option View OtaTextButton',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        MaterialApp(
          routes: AppRoutes.getRoutes(),
          home: Scaffold(
            body: TicketPackageOptionView(
              ticketPackage: TicketPackage(
                  packageDetail: TicketPackageDetail(
                      name: "Package name", totalPrice: 800.00)),
              onReservePress: () {},
            ),
          ),
        ),
      );
      await tester.tap(find.byType(OtaTextButton));
      await tester.pumpAndSettle();
    });
  });
}
