import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';

const String _nextButton = "assets/images/icons/arrow_right.svg";

class OtaNextButton extends StatelessWidget {
  final Function()? onPress;
  final bool isWhite;
  const OtaNextButton({Key? key, this.onPress, this.isWhite = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OtaIconButton(
      onTap: onPress,
      icon: isWhite
          ? SvgPicture.asset(_nextButton, color: AppColors.kTrueWhite)
          : SvgPicture.asset(_nextButton),
    );
  }
}
