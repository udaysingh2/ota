import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_user_details_widget.dart';
import '../../../../../helper.dart';

void main() {
  testWidgets('Package User Detail Widget Test', (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(PackageUserDetailsWidget(
      mobileNumber: "0987654321",
      firstName: "Steve",
      isBookForSomeoneElse: false,
      onTitleArrowClick: (){},
      lastName: "Smith",
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Column), findsWidgets);
  });
}