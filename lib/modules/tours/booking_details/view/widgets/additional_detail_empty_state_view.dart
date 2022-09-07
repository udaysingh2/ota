import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_no_result_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

class AdditionalDetailsEmptyStateView extends StatelessWidget {
  final Text? loadingText;
  const AdditionalDetailsEmptyStateView({Key? key, this.loadingText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getErrorWidget(context);
  }

  Widget getErrorWidget(BuildContext context) {
    return Container(
      padding: kPaddingHori24,
      child: OtaSearchNoResultWidget(
        dividerHeight: kSize10,
        errorTextHeader: getTranslated(
          context,
          AppLocalizationsStrings.sorry,
        ),
        errorTextFooter: getTranslated(
          context,
          AppLocalizationsStrings.informationNotAvialable,
        ),
        paddingHeight: kSize8,
      ),
    );
  }
}
