import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_landing/view/widgets/car_landing_diffrent_drop_toggel.dart';
import 'package:ota/modules/car_rental/car_landing/view/widgets/ota_switch_button.dart';

import '../../../../../helper.dart';

void main() {
  testWidgets('Car Landing Drop Toggle', (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(CarLandingDifferentDropToggle(
      onTap: () {},
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(OtaSwitchButton), findsOneWidget);
  });
}
