import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/package_detail/view/widget/package_section_widget_without_bullet.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Package section widget without bullet  ', (tester) async {
    await tester
        .pumpWidget(getMaterialWrapper(const PackageSectionWidgetWithoutBullet(
      title: "test",
      subtitle: "test ",
      body: "test",
      isHtml: true,
      elementsList: [],
    )));
    await tester.pumpAndSettle();
    expect(find.byType(Column), findsWidgets);
  });
}
