import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_additional_information_widget.dart';
import '../../../../../helper.dart';

void main() {
  TextEditingController controller = TextEditingController();
  testWidgets('Package Additional Information Widget Test', (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(PackageAdditionalInformationWidget(
      controller: controller,
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Column), findsWidgets);

  });
}