import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_detail_more_info/view/widgets/car_detail_more_info_title.dart';

import '../../../../helper.dart';

void main() {
  testWidgets('Additional Services Test ', (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(const CarDetailMoreInfoTitle(
      title: 'title',
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
