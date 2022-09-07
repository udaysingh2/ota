import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_network_error_with_refresh_widget.dart';

import '../../helper/material_wrapper.dart';

void main() {
  testWidgets('Network Error Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(
        getMaterialWrapper(const OtaNetworkErrorWidgetWithRefresh(height: 24)));
    await tester.pumpAndSettle();
  });
}
