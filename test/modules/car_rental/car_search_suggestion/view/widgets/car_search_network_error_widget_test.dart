import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view/widget/car_network_error_widget.dart';
import '../../../../../helper.dart';

void main() {
  testWidgets('Network Error Widget Test', (WidgetTester tester) async {
    await tester
        .pumpWidget(getMaterialWrapper(const OtaCarNetworkErrorWidget()));
    await tester.pumpAndSettle();
  });
}
