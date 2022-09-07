import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_add_member_card.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view/widgets/member_text_widget.dart';

void main() {
  testWidgets("memberTextWidgetTest", (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: MemberTextWidget(
        hintMemberText: '',
        characterCount: 25,
        textFormatter: "",
        subText: "",
        headerText: "",
        invalidFormatter: "",
        maxLines: null,
        textController: TextEditingController.fromValue(TextEditingValue.empty),
      ),
    )));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(OtaAddMemberCard));
    await tester.pumpAndSettle();
  });
}
