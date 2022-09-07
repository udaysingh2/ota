import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';

enum ButtonType { plusButton, minusButton }

const kPlusIcon = "assets/images/icons/plus_icon.svg";
const kMinusIcon = "assets/images/icons/minus_icon.svg";

class PlusMinusButton extends StatelessWidget {
  final ButtonType buttonType;
  final bool isEnabled;
  final Function()? onPressed;
  const PlusMinusButton({
    Key? key,
    this.buttonType = ButtonType.plusButton,
    this.onPressed,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OtaIconButton(
      icon: buildSvgPicture(),
      onTap: isEnabled ? onPressed : null,
    );
  }

  Widget buildSvgPicture() {
    return isEnabled
        ? ShaderMask(
            shaderCallback: (Rect bounds) =>
                AppColors.gradient1.createShader(Offset.zero & bounds.size),
            child: SvgPicture.asset(
              buttonType == ButtonType.plusButton ? kPlusIcon : kMinusIcon,
              width: kSize24,
              height: kSize24,
              color: AppColors.kWhiteColor,
            ),
          )
        : SvgPicture.asset(
            buttonType == ButtonType.plusButton ? kPlusIcon : kMinusIcon,
            width: kSize24,
            height: kSize24,
            color: AppColors.kGrey10,
          );
  }
}
