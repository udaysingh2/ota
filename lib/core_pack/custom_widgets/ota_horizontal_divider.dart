import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';

const double _kDividerWidth = 1;

class OtaHorizontalDivider extends StatelessWidget {
  final Color? dividerColor;
  final double? height;
  final double? thickness;
  const OtaHorizontalDivider(
      {Key? key, this.height, this.dividerColor, this.thickness})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: dividerColor ?? AppColors.kGrey4,
      height: height ?? _kDividerWidth,
      thickness: thickness ?? _kDividerWidth,
    );
  }
}
