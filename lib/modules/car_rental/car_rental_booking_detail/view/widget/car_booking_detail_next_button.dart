import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const String _kRightArrow = 'assets/images/icons/arrow_right.svg';
const int _kMaxLine = 1;

class CarDetailNextButton extends StatelessWidget {
  final String headerTitle;
  final TextStyle style;
  final Function()? onPress;

  const CarDetailNextButton({
    required this.headerTitle,
    this.style = AppTheme.kHeading3,
    this.onPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OtaHorizontalDivider(
          dividerColor: AppColors.kGrey10,
        ),
        const SizedBox(height: kSize24),
        GestureDetector(
          onTap: onPress,
          key: Key(headerTitle),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  getTranslated(context, headerTitle),
                  style: style,
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
        const SizedBox(height: kSize24),
      ],
    );
  }
}
