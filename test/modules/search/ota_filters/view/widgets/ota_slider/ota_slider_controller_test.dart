import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/search/ota_filters/view/widgets/ota_slider/ota_slider_controller.dart';

void main() {
  test('ota slider controller Test', () async {
    SliderController sliderController = SliderController();
    expect(sliderController.state.rangeValues, const RangeValues(1, 1));
    sliderController.updateRange(sliderController.state.rangeValues);
  });
}
