import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/landing/view/widgets/landing_background_image.dart';

import '../../../../helper.dart';

void main() {
  testWidgets('Landing Background Image Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(
      const LandingBackgroundImage("https://www.linkpicture.com/q/background_11.png"),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });
}
