import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

import 'ota_countdown_controller.dart';

const kSecondsInMinutes = 60;

class OtaCountDownTimer extends StatefulWidget {
  final OtaCountDownController controller;
  final String label;
  const OtaCountDownTimer(
      {Key? key,
      required this.controller,
      this.label = AppLocalizationsStrings.pleaseReserveWithin})
      : super(key: key);

  @override
  OtaCountDownTimerState createState() => OtaCountDownTimerState();
}

class OtaCountDownTimerState extends State<OtaCountDownTimer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.kGrey4,
      height: kSize37,
      padding: kPaddingHori24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return AppColors.gradient1
                    .createShader(Offset.zero & bounds.size);
              },
              child: Text(
                getTranslated(context, widget.label),
                style: AppTheme.kSmallRegular
                    .copyWith(color: AppColors.kTrueWhite),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Row(children: [
            SvgPicture.asset(
              "assets/images/icons/uil_clock-three.svg",
              width: kSize16,
              height: kSize16,
            ),
            const SizedBox(
              width: kSize5,
            ),
            ValueListenableBuilder<int>(
              valueListenable: widget.controller.countValue,
              builder: (context, value, child) {
                return ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return AppColors.gradient1
                        .createShader(Offset.zero & bounds.size);
                  },
                  child: Text(
                    getTimeMinutes(value),
                    style: AppTheme.kSmallRegular
                        .copyWith(color: AppColors.kTrueWhite),
                  ),
                );
              },
            ),
          ]),
        ],
      ),
    );
  }

  String getTimeMinutes(int value) {
    int minutes = (value / kSecondsInMinutes).floor();
    int seconds = (value % kSecondsInMinutes);
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} ${getTranslated(context, AppLocalizationsStrings.countdownTimeTitle)}";
  }
}
