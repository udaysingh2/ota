import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_matching_result_widget.dart';
import '../../helper/material_wrapper.dart';

void main() {
  testWidgets('No Matching Result Widget Test', (WidgetTester tester) async {
    await tester
        .pumpWidget(getMaterialWrapper(const OtaNoMatchingResultWidget()));
    await tester.pumpAndSettle();
    expect(find.text("ไม่พบห้องว่างในวันที่คุณต้องการ กรุณาเลือกวันอื่น"),
        findsOneWidget);
  });
}
