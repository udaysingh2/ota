import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_gradient_text_widget.dart';

const String _kCheckGradient = "assets/images/icons/checkbox_gradient.svg";
const int _kMaxLines = 1;

class HotelBookingDetailsWithGradient extends StatelessWidget {
  final String gradientText;
  final bool isGradientText;

  const HotelBookingDetailsWithGradient({
    Key? key,
    required this.gradientText,
    this.isGradientText = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _getSvgIcon(),
        const SizedBox(width: kSize11),
        isGradientText
            ? OtaGradientText(
                gradientText: gradientText,
                gradientTextStyle: AppTheme.kBodyMedium,
                textGradientEndColor: AppColors.kGradientEnd,
                textGradientStartColor: AppColors.kGradientStart,
                maxlines: _kMaxLines,
                overflow: TextOverflow.ellipsis,
              )
            : Text(gradientText,
                style:
                    AppTheme.kBodyMedium.copyWith(color: AppColors.kSecondary)),
      ],
    );
  }

  Widget _getSvgIcon() {
    return SvgPicture.asset(_kCheckGradient, height: kSize20, width: kSize20);
  }
}
