import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_no_result_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

class OtaShareErrorScreen extends StatelessWidget {
  const OtaShareErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OtaAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
            left: kSize60, right: kSize60, bottom: kSize60),
        child: OtaSearchNoResultWidget(
          paddingHeight: kSize8,
          errorTextHeader:
              getTranslated(context, AppLocalizationsStrings.sorry),
          errorTextFooter:
              getTranslated(context, AppLocalizationsStrings.shareErrorMessage),
        ),
      ),
    );
  }
}
