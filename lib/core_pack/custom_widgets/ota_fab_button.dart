import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

class OtaFABButton extends StatelessWidget {
  final String iconSvgAsset;
  final Function()? onPressed;
  final bool withStroke;

  const OtaFABButton(
      {Key? key,
      required this.iconSvgAsset,
      this.onPressed,
      this.withStroke = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        borderRadius: AppTheme.kBorderRadiusAll24,
        child: Container(
          decoration: withStroke
              ? const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.fabGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.kBlackOpacity50,
                      offset: Offset(kSize0, kSize4),
                      blurRadius: kSize4,
                    ),
                  ],
                )
              : const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.kLight100,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.kBlackOpacity50,
                      offset: Offset(kSize0, kSize4),
                      blurRadius: kSize4,
                    ),
                  ],
                ),
          padding: const EdgeInsets.all(kSize2),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.kLight100,
            ),
            width: kSize48,
            height: kSize48,
            child: Center(
              child: SvgPicture.asset(
                iconSvgAsset,
                height: kSize24,
                width: kSize24,
              ),
            ),
          ),
        ));
  }
}
