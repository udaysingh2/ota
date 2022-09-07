import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const String _kRightArrow = 'assets/images/icons/arrow_right.svg';
const int _kMaxLine = 1;

class CarDetailHeaderButton extends StatelessWidget {
  final String headerTitle;
  final Function()? onPress;

  const CarDetailHeaderButton({
    required this.headerTitle,
    this.onPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: kSize24, right: kSize24, bottom: kSize16),
      child: Column(
        children: [
          const OtaHorizontalDivider(
            dividerColor: AppColors.kGrey10,
          ),
          const SizedBox(height: kSize24),
          GestureDetector(
            key: Key(headerTitle),
            onTap: onPress,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    getTranslated(context, headerTitle),
                    style: AppTheme.kHeading1Medium,
                    maxLines: _kMaxLine,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: kSize8),
                SvgPicture.asset(
                  _kRightArrow,
                  color: AppColors.kGrey70,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
