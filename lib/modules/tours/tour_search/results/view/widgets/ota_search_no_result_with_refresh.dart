import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_refresh_indicator/ota_refresh_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_no_result_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
const String _kImageUrl = "assets/images/icons/no_matching_result_image.svg";

class OtaSearchNoResultRefresh extends StatelessWidget {
  final double height;
  final Text? loadingText;
  final Future<void> Function()? onRefresh;
  final EdgeInsets padding;
  const OtaSearchNoResultRefresh(
      {Key? key,
      required this.height,
      this.onRefresh,
      this.loadingText,
      this.padding = EdgeInsets.zero})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return getNoResultWidget(context);
  }

  Text _buildLoadingText(BuildContext context) {
    return Text(
      getTranslated(context, AppLocalizationsStrings.loading),
      style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
    );
  }

  Widget getNoResultWidget(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      height: height,
      child: OtaRefreshIndicator(
        text: loadingText ?? _buildLoadingText(context),
        onRefresh: onRefresh ?? () async {},
        child: ListView(
          shrinkWrap: false,
          padding: padding,
          // physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
                height: height - kSize24,
                child: OtaSearchNoResultWidget(
                  imageUrl: _kImageUrl,
                  paddingHeight: kSize10,
                  errorTextHeader:
                      getTranslated(context, AppLocalizationsStrings.sorry),
                  errorTextFooter: getTranslated(context,
                      AppLocalizationsStrings.toursTicketsSearchErrorText),
                ))
          ],
        ),
      ),
    );
  }
}
