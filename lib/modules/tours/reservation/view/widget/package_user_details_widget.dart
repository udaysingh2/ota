import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/tours/reservation/view/widget/user_detail_widget.dart';

const double _kContentHeight = 1.15;

class PackageUserDetailsWidget extends StatelessWidget {
  final EdgeInsets padding;
  final bool isBookForSomeoneElse;
  final String? lastName;
  final Function()? onTitleArrowClick;
  final String firstName;
  final String mobileNumber;
  const PackageUserDetailsWidget({
    Key? key,
    this.padding = kPaddingHori24,
    this.isBookForSomeoneElse = false,
    this.lastName,
    this.onTitleArrowClick,
    required this.firstName,
    required this.mobileNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kSize24),
          Text(
            getTranslated(context, AppLocalizationsStrings.contactInformation),
            style: AppTheme.kHeading1Medium,
          ),
          const SizedBox(height: kSize8),
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return AppColors.gradient1
                  .createShader(Offset.zero & bounds.size);
            },
            child: Text(
              getTranslated(
                  context, AppLocalizationsStrings.pleaseProvideContactInfo),
              style: AppTheme.kSmall1.copyWith(
                color: AppColors.kTrueWhite,
                fontWeight: FontWeight.w400,
                height: _kContentHeight,
              ),
            ),
          ),
          const SizedBox(height: kSize8),
          UserDetailsWidget(
            onTitleArrowClick: onTitleArrowClick,
            fullName: _getFullName(),
            mobileNumber: mobileNumber,
            isWarningNeeded: _isWarningIconVisible(),
          ),
          const SizedBox(height: kSize16),
        ],
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
