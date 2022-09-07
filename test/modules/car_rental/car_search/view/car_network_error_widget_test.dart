import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view/widget/car_network_error_widget.dart';

import '../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Car Network error widget Test', (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(const OtaCarNetworkErrorWidget(
      imageUrl: "assets/images/icons/search_error_image.svg",
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await tester.pump();
  });
}
