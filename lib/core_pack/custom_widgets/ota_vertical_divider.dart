import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';

const double _kDividerWidth = 1;

class OtaVerticalDivider extends StatelessWidget {
  final Color? dividerColor;
  final double? width;
  final double? thickness;
  const OtaVerticalDivider({Key? key, this.width, this.dividerColor, this.thickness}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      color: dividerColor ?? AppColors.kGrey10,
      width: width ?? _kDividerWidth,
      thickness: thickness ?? _kDividerWidth,
    );
  }
}
