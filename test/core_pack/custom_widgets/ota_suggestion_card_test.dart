import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_suggestion_card.dart';

import '../../helper/material_wrapper.dart';

void main() {
  testWidgets('ota suggestion card ...', (tester) async {
    await tester.pumpWidget(getMaterialWrapper(const OtaSuggestionCard(
      addressText: "test",
      discount: "test",
      headerText: "test",
      offerPercent: "test",
      ratingText: "test",
    )));
    await tester.pumpAndSettle();
    expect(find.byType(SizedBox), findsWidgets);
  });
}
