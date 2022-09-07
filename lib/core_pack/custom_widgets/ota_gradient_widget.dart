import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';

class OtaGradientTextWidget extends StatelessWidget {
  final String text;
  final TextStyle style;
  final int? maxLines;
  final Function()? onTap;
  final Alignment alignment;
  const OtaGradientTextWidget({
    Key? key,
    required this.text,
    required this.style,
    this.maxLines,
    this.onTap,
    this.alignment = Alignment.centerLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Align(
        alignment: alignment,
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return AppColors.gradient2.createShader(Offset.zero & bounds.size);
          },
          child: Text(
            text,
            style: style.copyWith(color: AppColors.kTrueWhite),
            textAlign: TextAlign.center,
            maxLines: maxLines,
          ),
        ),
      ),
    );
  }
}
