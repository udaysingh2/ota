import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/drop_down_menu_widget.dart';

import 'helper.dart';

void main() {
  testWidgets('Drop Down Menu Button Test', (WidgetTester tester) async {
    await tester.pumpWidget(getMaterialWrapper(
        const DropDownMenuButton(buttonText: "Testing", borderRadius: 10.0)));
    await tester.pumpAndSettle();
    expect(find.text("Testing"), findsOneWidget);
  });
}
