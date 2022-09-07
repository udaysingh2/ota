import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_no_result_widget.dart';

import '../../helper/material_wrapper.dart';

void main() {
  testWidgets('Ota Search Error Widget Test', (tester) async {
    await tester
        .pumpWidget(getMaterialWrapper(const OtaSearchNoResultWidget()));
    await tester.pumpAndSettle();
    expect(find.byType(SizedBox), findsNWidgets(4));
  });
}
