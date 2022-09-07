import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_next_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const double _kDefaultCornerRadius = 8;
const double _kContainerHeight = 68;
const _kGuestInformationWidgetPadding = EdgeInsets.only(
    left: kSize24, top: kSize24, right: kSize24, bottom: kSize16);
const _kGuestInformationContainerPadding =
    EdgeInsets.fromLTRB(kSize10, kSize6, kSize8, kSize6);
const int _kMaxLines2 = 2;

class GuestInformationFieldWidget extends StatelessWidget {
  final String firstName;
  final String? lastName;
  final String phoneNumber;
  final bool isBookForSomeoneElse;
  final void Function()? onTitleArrowClick;

  const GuestInformationFieldWidget({
    Key? key,
    required this.firstName,
    this.lastName,
    required this.phoneNumber,
    this.onTitleArrowClick,
    required this.isBookForSomeoneElse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: _kGuestInformationWidgetPadding,
      alignment: Alignment.topLeft,
      // color: Colors.red,
      child: Padding(
        padding: _kGuestInformationWidgetPadding,
        child: Container(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslated(context, AppLocalizationsStrings.guestInfolTitle),
                style: AppTheme.kHeading1Medium,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: kSize8,
              ),
              Text(
                getTranslated(
                    context, AppLocalizationsStrings.guestNameInfoTitle),
                style: AppTheme.kSmallRegular
                    .copyWith(color: AppColors.kPurpleOutline),
                overflow: TextOverflow.ellipsis,
                maxLines: _kMaxLines2,
              ),
              const SizedBox(
                height: kSize8,
              ),
              InkWell(
                onTap: onTitleArrowClick,
                borderRadius: BorderRadius.circular(_kDefaultCornerRadius),
                child: Ink(
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(_kDefaultCornerRadius),
                      border:
                          Border.all(color: AppColors.kGrey4, width: kSize2),
                      color: AppColors.kLight100),
                  height: _kContainerHeight,
                  width: double.infinity,
                  //    getTranslated(context, AppLocalizationsStrings.guestNameInfoTitle)
                  child: Padding(
                    padding: _kGuestInformationContainerPadding,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getFullName(),
                                style: AppTheme.kBodyRegular,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                phoneNumber,
                                style: AppTheme.kSmallRegular
                                    .copyWith(color: AppColors.kGrey20),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        if (_isWarningIconVisible())
                          OtaIconButton(
                            padding: const EdgeInsets.only(top: kSize6),
                            width: kSize20,
                            height: kSize22,
                            icon: SvgPicture.asset(
                              'assets/images/icons/warning_icon.svg',
                              width: kSize20,
                              height: kSize22,
                            ),
                          ),
                        OtaNextButton(onPress: onTitleArrowClick),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getFullName() {
    String name = firstName;
    if (lastName != null) name = '$firstName ${lastName!}';
    return name;
  }

  bool _isWarningIconVisible() {
    bool isVisible = (lastName == null ||
        lastName!.isEmpty ||
        kInvalidNameFormatter.hasMatch(lastName!) ||
        kInvalidNameFormatter.hasMatch(firstName));
    if (isVisible == true && isBookForSomeoneElse) {
      isVisible = false;
    }
    return isVisible;
  }
}
