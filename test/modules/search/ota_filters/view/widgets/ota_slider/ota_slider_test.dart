import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/search/ota_filters/view/widgets/ota_slider/ota_slider.dart';
import 'package:ota/modules/search/ota_filters/view/widgets/ota_slider/ota_slider_controller.dart';

import '../../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('ota slider Test', (WidgetTester tester) async {
    SliderController sliderController = SliderController();
    Widget widget = getMaterialWrapper(
        OtaSlider(min: 0, max: 100, sliderController: sliderController));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
