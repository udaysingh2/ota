import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/reservation/view/widget/user_detail_widget.dart';
import '../../../../../helper.dart';

void main() {
  testWidgets('User Detail Widget Test', (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(UserDetailsWidget(
      fullName: "Steve Smith",
      onTitleArrowClick: (){},
      isWarningNeeded: true,
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Column), findsWidgets);
  });
}