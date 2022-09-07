import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';

import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_next_button.dart';

const double _kDefaultCornerRadius = 8;
const double _kContainerHeight = 68;
const _kGuestInformationWidgetPadding =
    EdgeInsets.only(top: kSize24, bottom: kSize16);
const _kGuestInformationContainerPadding =
    EdgeInsets.symmetric(horizontal: kSize10, vertical: kSize6);
const int _kMaxLines2 = 2;
const Color kRed40 = Color(0xffEB6666);
const String kWarningIcon = 'assets/images/icons/warning_icon.svg';

class CarGuestInformationFieldWidget extends StatelessWidget {
  final String firstName;
  final String? lastName;
  final String phoneNumber;
  final String headerText;
  final String? subheadText;
  final String? warningText;
  final bool isWarningEnabled;
  final bool isBookForSomeoneElse;
  final bool isDriverDetail;
  final void Function()? onTitleArrowClick;
  const CarGuestInformationFieldWidget({
    Key? key,
    required this.firstName,
    this.lastName,
    required this.phoneNumber,
    this.onTitleArrowClick,
    required this.isBookForSomeoneElse,
    required this.headerText,
    this.subheadText,
    this.warningText,
    this.isWarningEnabled = false,
    this.isDriverDetail = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: _kGuestInformationWidgetPadding,
        child: Container(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headerText,
                style: AppTheme.kHeading1Medium,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: kSize8,
              ),
              subheadText != null
                  ? Text(
                      subheadText!,
                      style: AppTheme.kSmallRegular
                          .copyWith(color: AppColors.kPurpleOutline),
                      overflow: TextOverflow.ellipsis,
                      maxLines: _kMaxLines2,
                    )
                  : const SizedBox(),
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
                  child: Padding(
                    padding: _kGuestInformationContainerPadding,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (_getFullName().isNotEmpty ||
                                  _getFullName() != "")
                                Text(
                                  _getFullName(),
                                  style: AppTheme.kBodyRegular,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              isWarningEnabled == false
                                  ? Text(
                                      phoneNumber,
                                      style: AppTheme.kSmallRegular
                                          .copyWith(color: AppColors.kGrey20),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  : Text(
                                      warningText!,
                                      style: AppTheme.kSmallRegular
                                          .copyWith(color: kRed40),
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
                              kWarningIcon,
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
    if (firstName.isNotEmpty) {
      String name = firstName;
      if (lastName != null) name = '$firstName ${lastName!}';
      return name;
    } else {
      return "";
    }
  }

  bool _isWarningIconVisible() {
    bool isVisible = (lastName == null ||
        lastName!.isEmpty ||
        kInvalidNameFormatter.hasMatch(lastName!) ||
        kInvalidNameFormatter.hasMatch(firstName));

    if (isVisible == true && isBookForSomeoneElse && !isDriverDetail) {
      isVisible = false;
    }

    return isVisible;
  }
}
