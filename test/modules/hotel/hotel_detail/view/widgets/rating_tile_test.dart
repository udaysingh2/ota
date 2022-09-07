import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/rating_tile.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Rating Tile Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(
      const RatingTile(
        text: "hello",
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Padding), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);
  });
}
