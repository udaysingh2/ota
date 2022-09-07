import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_refresh_indicator/ota_refresh_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_no_result_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const double _kTopPadding = 24;
const String _kEmptyStateUrl = "assets/images/icons/search_empty_error.svg";

class MessageAndNotificationEmptyStateWithRefresh extends StatelessWidget {
  final double height;
  final Text? loadingText;
  final Future<void> Function()? onRefresh;
  const MessageAndNotificationEmptyStateWithRefresh(
      {Key? key, required this.height, this.onRefresh, this.loadingText})
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
              dividerHeight: kSize10,
              imageUrl: _kEmptyStateUrl,
              errorTextHeader: getTranslated(
                context,
                AppLocalizationsStrings.noMessage,
              ),
              errorTextFooter: getTranslated(
                context,
                AppLocalizationsStrings.emptyMessageText,
              ),
              paddingHeight: kSize8,
            ),
          )
        ],
      ),
    );
  }
}
