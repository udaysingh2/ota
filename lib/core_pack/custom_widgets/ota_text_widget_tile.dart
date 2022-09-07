import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const double _kSize28 = 28;
const int _kMaxLines = 2;
const String _kCrokeryIcon = "assets/images/icons/crockery.svg";

class OtaTextWidgetTile extends StatelessWidget {
  final String? headerText;
  final String? subHeaderText;
  final String? headerIcon;
  final Function()? onCardTap;

  const OtaTextWidgetTile({
    Key? key,
    this.headerIcon,
    this.subHeaderText,
    this.headerText,
    this.onCardTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardTap,
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: kSize24),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(kSize8)),
            color: AppColors.kPrimary93,
          ),
          child: _buildWidgetField(context)),
    );
  }

  Widget _buildWidgetField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kSize16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                headerIcon ?? _kCrokeryIcon,
                height: kSize20,
                width: kSize20,
                color: AppColors.kSecondary,
              ),
              const SizedBox(
                width: kSize8,
              ),
              Expanded(
                child: Text(
                    headerText ??
                        getTranslated(context,
                            AppLocalizationsStrings.freeFoodDeliveryTitleHotel),
                    style: AppTheme.kSmallMedium
                        .copyWith(color: AppColors.kSecondary)),
              ),
            ],
          ),
          const SizedBox(
            height: kSize4,
          ),
          Row(
            children: [
              const SizedBox(
                width: _kSize28,
              ),
              Expanded(
                child: Text(
                  subHeaderText ??
                      getTranslated(context,
                          AppLocalizationsStrings.freeFoodDeliveryInfoHotel),
                  style:
                      AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey70),
                  maxLines: _kMaxLines,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
