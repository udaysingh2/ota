import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const String _kResetButtonKey = "car_search_filter_reset_button_key";
const String _kSearchButtonKey = "car_search_filter_search_button_key";

class FilterSelectionButton extends StatelessWidget {
  const FilterSelectionButton({
    Key? key,
    required this.onResetPressed,
    required this.onSearchPressed,
  }) : super(key: key);
  final Function() onResetPressed;
  final Function() onSearchPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      right: false,
      left: false,
      child: Column(
        children: [
          const OtaHorizontalDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: kSize16, horizontal: kSize24),
            child: Row(
              children: [
                Expanded(
                  child: OtaTextButton(
                    key: const Key(_kResetButtonKey),
                    splashColor: AppColors.kSecondarySplash,
                    highlightColor: AppColors.kSecondarySplash,
                    hoverColor: AppColors.kSecondarySplash,
                    isSelected: false,
                    title:
                        getTranslated(context, AppLocalizationsStrings.reset),
                    onPressed: onResetPressed,
                  ),
                ),
                const SizedBox(width: kSize16),
                Expanded(
                  child: OtaTextButton(
                    key: const Key(_kSearchButtonKey),
                    title:
                        getTranslated(context, AppLocalizationsStrings.search),
                    onPressed: onSearchPressed,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
