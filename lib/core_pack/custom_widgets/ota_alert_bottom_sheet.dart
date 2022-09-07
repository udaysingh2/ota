import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_button_bottom_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';

const double _kBackgroundOpacity = 0.94;
const _kRightButtonKey = "RightButtonKey";
const double _kSize92 = 92;

class OtaAlertBottomSheet extends StatelessWidget {
  final String? alertTitle;
  final String? alertText;
  final Widget? textWidget;
  final String leftButtonText;
  final String rightButtonText;
  final Function()? onLeftButtonTap;
  final Function()? onRightButtonTap;
  final bool isSafeArea;
  const OtaAlertBottomSheet({
    Key? key,
    this.alertTitle,
    this.alertText,
    required this.leftButtonText,
    required this.rightButtonText,
    this.onLeftButtonTap,
    this.onRightButtonTap,
    this.textWidget,
    this.isSafeArea = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(kSize24),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: AppColors.kLight100.withOpacity(_kBackgroundOpacity),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(kSize24),
                    topRight: Radius.circular(kSize24))),
            child: Column(
              children: [
                Offstage(
                  offstage: alertTitle == null,
                  child: Text(
                    alertTitle ?? "",
                    style: AppTheme.kHeading1Medium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: kSize8,
                ),
                textWidget != null
                    ? textWidget!
                    : Offstage(
                        offstage: alertText == null,
                        child: Text(
                          alertText ?? "",
                          style: AppTheme.kSmallRegular
                              .copyWith(color: AppColors.kGrey50),
                          textAlign: TextAlign.center,
                        ),
                      )
              ],
            )),
        OtaBottomButtonBar(
          button1: OtaTextButton(
            title: leftButtonText,
            onPressed: onLeftButtonTap,
            backgroundColor: Colors.transparent,
            fontColor: AppColors.kGradientStart,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return AppColors.gradient1
                    .createShader(Offset.zero & bounds.size);
              },
              child: Text(
                leftButtonText,
                style:
                    AppTheme.kBodyMedium.copyWith(color: AppColors.kTrueWhite),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          button2: OtaTextButton(
            title: rightButtonText,
            onPressed: onRightButtonTap,
            key: const Key(_kRightButtonKey),
            child: Text(
              rightButtonText,
              style: AppTheme.kBodyMedium.copyWith(color: AppColors.kTrueWhite),
              textAlign: TextAlign.center,
            ),
          ),
          safeAreaBottom: isSafeArea,
          isExpandedRightButton: true,
          spaceBetweenButton: kSize16,
          containerHeight: _kSize92,
        ),
      ],
    );
  }
}
