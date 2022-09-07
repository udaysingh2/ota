import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/core_pack/custom_widgets/ota_network_error_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const double _kContainerHeight = 375.0;

class GalleryDetailPlaceholder extends StatelessWidget {
  final bool isError;

  const GalleryDetailPlaceholder({
    Key? key,
    this.isError = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Container(
          color: isError ? Colors.transparent : AppColors.kGalleryPlaceholder,
          height: _kContainerHeight,
          child: isError
              ? OtaNetworkErrorWidget(
                  errorTextHeader:
                      getTranslated(context, AppLocalizationsStrings.sorry),
                  errorTextFooter: getTranslated(
                      context, AppLocalizationsStrings.somethingWentWrong),
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
