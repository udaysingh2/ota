import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view/widgets/guest_information_widget.dart';

import '../../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Guest Information Widget with full name ...', (tester) async {
    await tester.runAsync(() async {
      Widget widget = getMaterialWrapper(
        GuestInformationFieldWidget(
          firstName: 'first',
          lastName: "last",
          phoneNumber: '12345678',
          onTitleArrowClick: () {},
          isBookForSomeoneElse: true,
        ),
      );
      await tester.pumpWidget(widget);
      await tester.pump();
      expect(find.text("first last"), findsOneWidget);
      expect(find.text("12345678"), findsOneWidget);
      expect(find.byType(OtaIconButton), findsOneWidget);
    });
  });
  testWidgets('Guest Information Widget with last name missing ...',
      (tester) async {
    await tester.runAsync(() async {
      Widget widget = getMaterialWrapper(
        GuestInformationFieldWidget(
          firstName: 'first',
          phoneNumber: '12345678',
          onTitleArrowClick: () {},
          isBookForSomeoneElse: false,
        ),
      );
      await tester.pumpWidget(widget);
      await tester.pump();
      expect(find.text("first"), findsOneWidget);
    });
  });
}
