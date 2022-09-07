import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/modules/car_rental/car_landing/view/widgets/car_custom_error_widget.dart';

import '../../../../../helper.dart';

void main() {
  testWidgets('Car Custom Error Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(getMaterialWrapper(CarCustomErrorWidgetWithRefresh(
      height: kSize100,
      widgetChild: ListView(),
    )));

    await tester.pumpAndSettle();
  });
}
