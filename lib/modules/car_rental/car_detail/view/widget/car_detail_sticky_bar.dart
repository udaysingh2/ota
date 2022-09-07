import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_gradient_text_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const int _kMaxLine = 1;
const String _kCarDetailStickyBarKey = 'car_detail_sticky_bar_key';

class CarDetailStickyBar extends StatelessWidget {
  final String pickUpDate;
  final String pickUpTime;
  final String dropOffDate;
  final String dropOffTime;
  final bool isSticky;
  final Function()? onPressed;

  const CarDetailStickyBar({
    Key? key,
    this.pickUpDate = "",
    this.pickUpTime = "",
    this.dropOffDate = "",
    this.dropOffTime = "",
    this.isSticky = true,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: isSticky
            ? [
                const BoxShadow(
                  color: Color.fromRGBO(162, 143, 163, 0.16),
                  spreadRadius: 4,
                  blurRadius: 12,
                  offset: Offset(0, 15),
                ),
              ]
            : [],
      ),
      child: Material(
        child: InkWell(
          onTap: onPressed,
          key: const Key(_kCarDetailStickyBarKey),
          child: Ink(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: isSticky ? kSize8 : kSize16),
                  child: OtaHorizontalDivider(
                    dividerColor:
                        isSticky ? AppColors.kGrey4 : AppColors.kGrey10,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kSize24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: _getTile(
                          header: AppLocalizationsStrings.pickUp,
                          date: pickUpDate,
                          time: pickUpTime,
                          context: context,
                        ),
                      ),
                      const SizedBox(width: kSize4),
                      Expanded(
                        child: _getTile(
                          header: AppLocalizationsStrings.dropOff,
                          date: dropOffDate,
                          time: dropOffTime,
                          context: context,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: isSticky ? kSize8 : kSize16),
                  child: isSticky
                      ? const SizedBox.shrink()
                      : const OtaHorizontalDivider(
                          dividerColor: AppColors.kGrey10,
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getTile({
    required String header,
    required String date,
    required String time,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          getTranslated(context, header),
          style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
          maxLines: _kMaxLine,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          children: [
            OtaGradientText(
              gradientText: date,
              gradientTextStyle: AppTheme.kSmallMedium,
              textGradientStartColor: AppColors.kGradientStart,
              textGradientEndColor: AppColors.kGradientEnd,
              maxlines: _kMaxLine,
              overflow: TextOverflow.ellipsis,
            ),
            Container(
              height: kSize4,
              width: kSize4,
              margin: const EdgeInsets.symmetric(horizontal: kSize4),
              decoration: const BoxDecoration(
                color: AppColors.kSecondary,
                shape: BoxShape.circle,
              ),
            ),
            OtaGradientText(
              gradientText: time,
              gradientTextStyle: AppTheme.kSmallMedium,
              textGradientStartColor: AppColors.kGradientStart,
              textGradientEndColor: AppColors.kGradientEnd,
              maxlines: _kMaxLine,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }
}
