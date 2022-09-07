import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/rating_count_widget.dart';

import '../../../../../helper/material_wrapper.dart';
void main() {
  testWidgets('Rating Count widget Test', (tester) async {
    Widget widget = getMaterialWrapper(
      const RatingCountWidget(),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Container), findsOneWidget);
    expect(find.text("0"), findsOneWidget);
  });
}
