import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const int _characterLimit = 255;
const String _searchFormatter = r'([A-Za-z\u0E00-\u0E7F0-9 ]{0,5})';

class PackageAdditionalInformationWidget extends StatelessWidget {
  final EdgeInsets padding;
  final TextEditingController controller;
  final String placeholder;
  final String subtitle;
  const PackageAdditionalInformationWidget({
    Key? key,
    this.padding = kPaddingHori24,
    required this.controller,
    this.placeholder =
        AppLocalizationsStrings.toursAdditionalRequestPlaceholder,
    this.subtitle = AppLocalizationsStrings.toursAdditionalRequest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kSize24),
          Text(
            getTranslated(context, AppLocalizationsStrings.additionalRequests),
            style: AppTheme.kHeading1Medium,
          ),
          const SizedBox(height: kSize4),
          Text(
            getTranslated(context, subtitle),
            style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
          ),
          const SizedBox(height: kSize16),
          OtaTextInputWidget(
            placeHolder: getTranslated(context, placeholder),
            padding: EdgeInsets.zero,
            textEditingController: controller,
            textInputFormatter: getInputFormatter(),
            maxLines: null,
          ),
          const SizedBox(height: kSize24),
          const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        ],
      ),
    );
  }

  static List<TextInputFormatter> getInputFormatter() {
    List<TextInputFormatter> formatterList = [
      LengthLimitingTextInputFormatter(_characterLimit),
      FilteringTextInputFormatter.allow(
        RegExp(_searchFormatter),
      ),
    ];
    return formatterList;
  }
}
