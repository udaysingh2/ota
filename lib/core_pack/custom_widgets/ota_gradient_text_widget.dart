import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';

const double _kLinearGradientLeftAndTop = 0;
const double _kLinearGradientWidth = 411;
const double _kLinearGradientHeight = 78;

class OtaGradientText extends StatelessWidget {
  final String gradientText;
  final TextStyle gradientTextStyle;
  final AlignmentGeometry gradientTextBegin;
  final AlignmentGeometry gradientTextEnd;
  final Color textGradientStartColor;
  final Color textGradientEndColor;
  final int? maxlines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  const OtaGradientText(
      {this.gradientText = "",
      this.gradientTextStyle = AppTheme.kSmall1,
      this.gradientTextBegin = Alignment.topCenter,
      this.gradientTextEnd = Alignment.bottomCenter,
      this.textGradientStartColor = AppColors.kTextGradientStart,
      this.textGradientEndColor = AppColors.kTextGradientEnd,
      this.maxlines,
      this.overflow,
      this.textAlign,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      gradientText,
      style: gradientTextStyle.copyWith(
          foreground: Paint()
            ..shader = LinearGradient(
                    tileMode: TileMode.mirror,
                    stops: const [0.4, 1],
                    begin: gradientTextBegin,
                    end: gradientTextEnd,
                    colors: [textGradientStartColor, textGradientEndColor])
                .createShader(const Rect.fromLTWH(
                    _kLinearGradientLeftAndTop,
                    _kLinearGradientLeftAndTop,
                    _kLinearGradientWidth,
                    _kLinearGradientHeight))),
      maxLines: maxlines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}
