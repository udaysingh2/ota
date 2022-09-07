import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_gradient_text_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const _okOtaTextButtonWidget = 'OkCancellationOrder';

class CancellationBottomSheetWidget extends StatelessWidget {
  final BuildContext context;
  final String heading, body;
  final Key? cancelkey;
  final Function()? onCancel, onOK;
  const CancellationBottomSheetWidget({
    Key? key,
    required this.context,
    required this.heading,
    required this.body,
    this.onCancel,
    this.onOK,
    this.cancelkey,
  }) : super(key: key);

  @override
  Widget build(context) {
    return Container(
      padding: const EdgeInsets.only(top: kSize24),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: AppColors.kTrueWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kSize24),
          topRight: Radius.circular(kSize24),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kSize24),
              child: Text(
                heading,
                style: AppTheme.kHeading1Medium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: kSize8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kSize24),
              child: Text(
                body,
                style: AppTheme.kSmallRegular.copyWith(
                    color: AppColors.kGrey77, fontFamily: kFontFamily),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: kSize24),
            const OtaHorizontalDivider(),
            const SizedBox(height: kSize16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kSize24),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      key: cancelkey,
                      onPressed: onCancel,
                      child: OtaGradientText(
                        gradientText: getTranslated(
                            context, AppLocalizationsStrings.notNow),
                        gradientTextStyle: AppTheme.kButton
                            .copyWith(color: AppColors.kTrueWhite),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    child: OtaTextButton(
                      key: const Key(_okOtaTextButtonWidget),
                      title:
                          getTranslated(context, AppLocalizationsStrings.agree),
                      onPressed: onOK,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).padding.bottom > kSize0
                    ? kSize0
                    : kSize24),
          ],
        ),
      ),
    );
  }
}
