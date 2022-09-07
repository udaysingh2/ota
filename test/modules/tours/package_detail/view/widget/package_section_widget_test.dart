import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/package_detail/view/widget/package_section_widget.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Package section widget  ', (tester) async {
    await tester.pumpWidget(getMaterialWrapper(const PackageSectionWidget(
      title: "test",
      subtitle: "test",
      svgAsset: "",
      body: "test ",
      isHtml: true,
      isList: false,
      elementsList: [],
    )));
    await tester.pumpAndSettle();
    expect(find.byType(Column), findsWidgets);
  });
}
