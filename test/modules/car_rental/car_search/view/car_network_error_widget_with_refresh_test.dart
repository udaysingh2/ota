import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view/widget/car_network_error_widget_with_refresh.dart';

import '../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Car Network error widget with refresh Test',
      (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(const CarNetworkErrorWidgetWithRefresh(
      height: 500,
      key: Key("Key"),
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await tester.pump();
  });
}
