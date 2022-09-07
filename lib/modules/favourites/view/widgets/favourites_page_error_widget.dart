import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_refresh_indicator/ota_refresh_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_no_result_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const double _kTopPadding = 24;
const kSearchErrorImage = "assets/images/icons/no_matching_result_image.svg";

class FavouritesPageErrorWidgetWithRefresh extends StatelessWidget {
  final double height;
  final String imageURL;
  final Text? loadingText;
  final Future<void> Function()? onRefresh;
  const FavouritesPageErrorWidgetWithRefresh(
      {Key? key,
      this.imageURL=kSearchErrorImage,
      required this.height,
      this.onRefresh,
      this.loadingText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return getErrorWidget(context);
  }

  Widget getErrorWidget(BuildContext context) {
    return OtaRefreshIndicator(
      text: loadingText ??
          Text(getTranslated(context, AppLocalizationsStrings.loading)),
      onRefresh: onRefresh ?? () async {},
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: height - _kTopPadding,
            child: OtaSearchNoResultWidget(
              imageUrl: imageURL,
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
          )
        ],
      ),
    );
  }
}
