import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/core_pack/custom_widgets/ota_network_error_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

class OtaNoMatchingResultWidget extends StatelessWidget {
  final String imageUrl;
  final String? errorTextHeader;
  final String? errorTextFooter;

  const OtaNoMatchingResultWidget(
      {this.imageUrl = "assets/images/icons/no_matching_result_image.svg",
      this.errorTextHeader,
      this.errorTextFooter,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OtaNetworkErrorWidget(
      imageUrl: imageUrl,
      errorTextFooter: errorTextFooter ??
          getTranslated(
              context, AppLocalizationsStrings.noMatchingResultMessage),
      errorTextHeader: errorTextHeader,
    );
  }
}
