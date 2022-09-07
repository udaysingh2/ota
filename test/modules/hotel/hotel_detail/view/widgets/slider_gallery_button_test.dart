import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/slider_gallery_button.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Card Header Item Count Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(
      const SliderGalleryButton(buttonText: "buttonText"),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    // expect(find.byType(PageView), findsOneWidget);
    // expect(find.byType(CachedNetworkImage), findsOneWidget);
  });
}
