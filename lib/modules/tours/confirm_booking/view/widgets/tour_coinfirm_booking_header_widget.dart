import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_gradient_text_widget.dart';

class TourConfirmBookingHeaderWidget extends StatelessWidget {
  final String headerText;
  final double height;
  final String? tailingText;
  final Function()? onTap;
  const TourConfirmBookingHeaderWidget({
    Key? key,
    this.tailingText,
    required this.headerText,
    required this.height,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getHeader(headerText, height, tailingText: tailingText);
  }

  Widget getHeader(String headerText, double height, {tailingText}) {
    return Container(
      height: height,
      color: AppColors.kGrey4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSize24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: kSize8, top: kSize8),
              child: Text(
                headerText,
                style: AppTheme.kBodyMedium,
              ),
            ),
            const Spacer(),
            if (tailingText != null)
              InkWell(
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: kSize8, top: kSize8),
                  child: OtaGradientText(
                    gradientText: tailingText!,
                    gradientTextStyle: AppTheme.kBodyRegular,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
