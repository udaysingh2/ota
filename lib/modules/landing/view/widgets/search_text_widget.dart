import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const double _kImageSize = 20;
const double _kIconRightPadding = 8;
const double _kUnderlineWidth = 1;
const int _kMaxLine = 1;
const double _kMinWidth = 10;
const String _kSearchIconPath = "assets/images/icons/feather_search.svg";

class SearchTextWidget extends StatelessWidget {
  final String searchCustomText;
  final Color color;
  final double maxWidth;
  final Function()? onTap;
  const SearchTextWidget({
    Key? key,
    required this.searchCustomText,
    this.color = AppColors.kLight100,
    this.maxWidth = double.infinity,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(child: getContent(color, context)),
    );
  }

  Widget getContent(Color color, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: _kUnderlineWidth, color: color))),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            _kSearchIconPath,
            height: _kImageSize,
            width: _kImageSize,
            color: color,
          ),
          const SizedBox(
            width: _kIconRightPadding,
          ),
          ConstrainedBox(
            constraints:
                BoxConstraints(minWidth: _kMinWidth, maxWidth: maxWidth),
            child: Text(
              searchCustomText,
              maxLines: _kMaxLine,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.kHeading1Regular.copyWith(color: color, shadows: [
                kTextHardShadow,
              ]),
            ),
          )
        ],
      ),
    );
  }
}
