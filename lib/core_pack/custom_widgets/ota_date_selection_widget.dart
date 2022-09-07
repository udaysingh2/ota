import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const String _kChangeDateKey = "ChangeDateKey";

class OtaDateSelectionWidget extends StatelessWidget {
  final String selectedDate;
  final Function()? changeDate;
  final EdgeInsets padding;
  const OtaDateSelectionWidget({
    Key? key,
    required this.selectedDate,
    this.changeDate,
    this.padding = const EdgeInsets.only(top: kSize15, bottom: kSize8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                getTranslated(context, AppLocalizationsStrings.selectedDate),
                style: AppTheme.kSmall1,
              ),
              const SizedBox(height: kSize2),
              Text(selectedDate, style: AppTheme.kBodyMedium),
            ],
          ),
          InkWell(
            key: const Key(_kChangeDateKey),
            onTap: changeDate,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return AppColors.gradient1
                    .createShader(Offset.zero & bounds.size);
              },
              child: Text(
                getTranslated(context, AppLocalizationsStrings.changeDate),
                style: AppTheme.kSmallRegularGradient,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
