import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

import 'ota_switch_button.dart';

class CarLandingDifferentDropToggle extends StatelessWidget {
  final Function() onTap;
  final AnimationController? animationController;
  final Animation? circleAnimation;

  const CarLandingDifferentDropToggle({
    Key? key,
    required this.onTap,
    this.animationController,
    this.circleAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kSize16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            getTranslated(
                context, AppLocalizationsStrings.dropOffAtDiffrentLocation),
            style: AppTheme.kBodyRegular,
          ),
          OtaSwitchButton(
            onTap: onTap,
            animationController: animationController,
            circleAnimation: circleAnimation,
          ),
        ],
      ),
    );
  }
}
