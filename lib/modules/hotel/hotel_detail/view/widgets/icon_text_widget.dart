import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const _kDefaultAddressLine = 2;

class IconTextWidget extends StatelessWidget {
  final String iconName;
  final String text;
  final TextStyle textStyle;
  final double iconTextGutter;
  final bool isExpanded;
  final int maxLines;
  final double iconSize;
  final CrossAxisAlignment variableAlignment;

  const IconTextWidget({
    Key? key,
    required this.iconName,
    this.iconTextGutter = kSize9_33,
    required this.text,
    this.textStyle = AppTheme.kSmall1,
    this.isExpanded = false,
    this.maxLines = _kDefaultAddressLine,
    this.variableAlignment = CrossAxisAlignment.start,
    this.iconSize = kSize16,
  })  : assert(maxLines > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: variableAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          iconName,
          height: iconSize,
          width: iconSize,
        ),
        SizedBox(width: iconTextGutter),
        isExpanded
            ? Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    text,
                    style: textStyle,
                    maxLines: maxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            : Text(
                text,
                style: textStyle,
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis,
              ),
      ],
    );
  }
}
