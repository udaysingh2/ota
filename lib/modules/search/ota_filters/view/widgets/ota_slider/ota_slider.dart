import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';

import 'ota_rounded_rect_slider_track_shape.dart';
import 'ota_slider_controller.dart';
import 'ota_slider_thumb_image.dart';

const double _kOverlayRadius = 11.0;

class OtaSlider extends StatelessWidget {
  final double min;
  final double max;
  final SliderController sliderController;
  final Function(RangeValues value)? onChanged;
  const OtaSlider({
    Key? key,
    required this.min,
    required this.max,
    required this.sliderController,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getSlider(context);
  }

  Widget getSlider(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
          overlayShape:
              const RoundSliderOverlayShape(overlayRadius: _kOverlayRadius),
          inactiveTrackColor: AppColors.kSliderUnSelectedColor,
          rangeTrackShape: const OtaRoundedRectSliderTrackShape(),
          rangeThumbShape: OtaSliderThumb()),
      child: BlocBuilder(
          bloc: sliderController,
          builder: () {
            return RangeSlider(
              values: RangeValues(sliderController.state.rangeValues.start,
                  sliderController.state.rangeValues.end),
              onChanged: onChanged,
              min: min,
              divisions: (max - min).ceil(),
              max: max,
            );
          }),
    );
  }
}
