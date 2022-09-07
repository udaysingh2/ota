import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';

const _kPadding = EdgeInsets.fromLTRB(kSize24, kSize16, kSize24, kSize32);
const double _kSpaceBetweenButton = 0;

class OtaBottomButtonBar extends StatelessWidget {
  final Widget button1;
  final Widget? button2;
  final double? containerHeight;
  final double? spaceBetweenButton;
  final MainAxisAlignment mainAxisAlignment;
  final bool showHorizontalDivider;
  final bool isExpandedRightButton;
  final EdgeInsetsGeometry? padding;
  final bool safeAreaBottom;
  final Color? color;

  const OtaBottomButtonBar({
    Key? key,
    required this.button1,
    this.button2,
    this.spaceBetweenButton = _kSpaceBetweenButton,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.containerHeight = kSize100,
    this.showHorizontalDivider = true,
    this.isExpandedRightButton = false,
    this.padding = _kPadding,
    this.safeAreaBottom = true,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: safeAreaBottom,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (showHorizontalDivider) const OtaHorizontalDivider(),
            Container(
              color: color ?? AppColors.kLight100.withOpacity(0.94),
              height: containerHeight,
              padding: padding,
              alignment: Alignment.center,
              child: button2 == null
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: button1,
                    )
                  : Row(
                      mainAxisAlignment: mainAxisAlignment,
                      children: <Widget>[
                        Expanded(child: button1),
                        SizedBox(
                          width: spaceBetweenButton,
                        ),
                        Expanded(
                          child: isExpandedRightButton
                              ? button2!
                              : Align(
                                  alignment: Alignment.centerRight,
                                  child: button2!,
                                ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
