import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/consts.dart';

class OtaIconButton extends StatelessWidget {
  final Widget icon;
  final Function()? onTap;
  final EdgeInsets padding;
  final bool withGradient;
  final BoxDecoration? customDecoration;
  final double height;
  final double width;
  final double borderRadius;
  const OtaIconButton(
      {Key? key,
      required this.icon,
      this.onTap,
      this.padding = kPaddingAll8,
      this.withGradient = false,
      this.customDecoration,
      this.height = kSize40,
      this.width = kSize40,
      this.borderRadius = kSize20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Ink(
            height: height,
            width: width,
            padding: padding,
            decoration: customDecoration ??
                (withGradient
                    ? const BoxDecoration(
                        gradient: AppColors.kPurpleGradient,
                        shape: BoxShape.circle)
                    : const BoxDecoration(shape: BoxShape.circle)),
            child: icon,
          )),
    );
  }
}
