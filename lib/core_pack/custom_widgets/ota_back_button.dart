import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';

const String _backButton = "assets/images/icons/arrow_left.svg";

class OtaBackButton extends StatelessWidget {
  final Function()? onPress;
  final bool isWhite;
  const OtaBackButton({Key? key, this.onPress, this.isWhite = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OtaIconButton(
      onTap: onPress,
      icon: isWhite
          ? SvgPicture.asset(_backButton, color: AppColors.kTrueWhite)
          : SvgPicture.asset(_backButton),
    );
  }
}
