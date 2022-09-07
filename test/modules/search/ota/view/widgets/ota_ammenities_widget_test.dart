import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/search/ota/view/widgets/ota_ammenities_widget.dart';

import '../../../../../helper.dart';

void main() {
  testWidgets('ota ammenities widget test', (tester) async {
    await tester.pumpWidget(getMaterialWrapper(const OtaSuggestionCardAmenities(
      adminPromotionLine1: "abcd",
      adminPromotionLine2: "efgh",
    )));
    await tester.pumpAndSettle();
  });
  testWidgets('ota ammenities widget test 2', (tester) async {
    await tester.pumpWidget(getMaterialWrapper(const OtaSuggestionCardAmenities(
      isInHorizontalScroll: false,
    )));
    await tester.pumpAndSettle();
  });
}
