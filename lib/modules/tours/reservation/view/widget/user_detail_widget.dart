import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_next_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const _kGuestInformationContainerPadding =
    EdgeInsets.only(left: kSize12, top: kSize9, right: kSize18, bottom: kSize9);
const double _kDefaultCornerRadius = 8;
const double _kContainerHeight = 68;
const String _kWarningIcon = 'assets/images/icons/warning_icon.svg';

class UserDetailsWidget extends StatelessWidget {
  final Function()? onTitleArrowClick;
  final String? mobileNumber;
  final bool isWarningNeeded;
  final String fullName;
  const UserDetailsWidget({
    Key? key,
    this.onTitleArrowClick,
    this.mobileNumber,
    required this.fullName,
    this.isWarningNeeded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTitleArrowClick,
      borderRadius: BorderRadius.circular(_kDefaultCornerRadius),
      child: Ink(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_kDefaultCornerRadius),
            border: Border.all(color: AppColors.kGrey4, width: kSize2),
            color: AppColors.kLight100),
        height: _kContainerHeight,
        width: double.infinity,
        child: Padding(
          padding: _kGuestInformationContainerPadding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      fullName,
                      style: AppTheme.kBodyRegular,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (mobileNumber != null)
                      Text(
                        mobileNumber!,
                        style:
                            AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey20),
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (mobileNumber == null && isWarningNeeded)
                      Text(
                        getTranslated(context,
                            AppLocalizationsStrings.moreInformationRequired),
                        style: AppTheme.kSmall1
                            .copyWith(color: AppColors.kSystemWrong),
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              if (isWarningNeeded)
                OtaIconButton(
                  padding: const EdgeInsets.only(top: kSize7),
                  width: kSize20,
                  height: kSize22,
                  icon: SvgPicture.asset(
                    _kWarningIcon,
                    width: kSize20,
                    height: kSize22,
                  ),
                ),
              OtaNextButton(onPress: onTitleArrowClick),
            ],
          ),
        ),
      ),
    );
  }
}
