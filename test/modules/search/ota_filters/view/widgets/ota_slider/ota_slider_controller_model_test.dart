import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/search/ota_filters/view/widgets/ota_slider/ota_slider_controller_model.dart';

void main() {
  test('ota slider controller model Test', () async {
    SliderControllerModel sliderControllerModel =
        SliderControllerModel(rangeValues: const RangeValues(1, 1));
    expect(sliderControllerModel.rangeValues, const RangeValues(1, 1));
  });
}
