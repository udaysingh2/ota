import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/hotel_image_slider.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Hotel Image Slider Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(const HotelImageSlider(
      sliderHeight: 2,
      imageUrl: [""],
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(PageView), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });
}
