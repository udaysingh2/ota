import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';

//---This code is directly copied from flutter RoundRangeSliderThumbShape class.
class OtaSliderThumb extends RangeSliderThumbShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(20, 20);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool? isOnTop,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
    bool? isPressed,
  }) {
    assert(sliderTheme.showValueIndicator != null);
    assert(sliderTheme.overlappingShapeStrokeColor != null);
    final Canvas canvas = context.canvas;
    final Tween<double> radiusTween = Tween<double>(
      begin: 10,
      end: 10,
    );
    final ColorTween colorTween = ColorTween(
      begin: Colors.white,
      end: Colors.white,
    );
    final double radius = radiusTween.evaluate(enableAnimation);
    final Tween<double> elevationTween = Tween<double>(
      begin: 0,
      end: 0,
    );

    // Add a stroke of 1dp around the circle if this thumb would overlap
    // the other thumb.
    if (isOnTop == true) {
      final Paint strokePaint = Paint()
        ..color = sliderTheme.overlappingShapeStrokeColor!
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(center, radius, strokePaint);
    }

    final Color color = colorTween.evaluate(enableAnimation)!;

    final double evaluatedElevation =
        isPressed! ? elevationTween.evaluate(activationAnimation) : 0;
    final Path shadowPath = Path()
      ..addArc(
          Rect.fromCenter(
              center: center, width: 2 * radius, height: 2 * radius),
          0,
          pi * 2);
    canvas.drawShadow(shadowPath, Colors.black, evaluatedElevation, true);
    canvas.drawCircle(
      center,
      radius + 1,
      Paint()..color = AppColors.kBorderGrey,
    );
    canvas.drawCircle(
      center,
      radius - 1.5,
      Paint()..color = color,
    );
  }
}
