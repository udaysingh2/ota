import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/consts.dart';

class OtaSwitchButton extends StatelessWidget {
  final Function() onTap;
  final AnimationController? animationController;
  final Animation? circleAnimation;
  final bool isDisabled;

  const OtaSwitchButton({
    Key? key,
    required this.onTap,
    this.animationController,
    this.circleAnimation,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (animationController != null && circleAnimation != null) {
      return AnimatedBuilder(
        animation: animationController!,
        builder: (context, child) {
          return GestureDetector(
            onTap: onTap,
            child: SizedBox(
              width: kSize32,
              height: kSize19,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: kSize32,
                      height: kSize13,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kSize16),
                        gradient:
                            circleAnimation!.value == Alignment.centerRight
                                ? const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppColors.kGradientEnd,
                                      AppColors.kGradientStart,
                                    ],
                                  )
                                : LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: isDisabled
                                        ? [
                                            AppColors.kGrey10,
                                            AppColors.kGrey10,
                                          ]
                                        : [
                                            AppColors.kGrey20,
                                            AppColors.kGrey20,
                                          ],
                                  ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: circleAnimation!.value,
                    child: SizedBox(
                      width: kSize19,
                      height: kSize19,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.kBorderGrey, width: kSize1),
                            shape: BoxShape.circle,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    return const SizedBox();
  }
}
