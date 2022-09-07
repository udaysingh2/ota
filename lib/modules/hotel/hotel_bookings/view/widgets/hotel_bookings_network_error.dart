import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/core_pack/custom_widgets/ota_network_error_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_refresh_indicator/ota_refresh_indicator.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const double _kTopPadding = 24;

class HotelBookingsNetworkErrorWidget extends StatelessWidget {
  final double height;
  final Text? loadingText;
  final Future<void> Function()? onRefresh;
  const HotelBookingsNetworkErrorWidget(
      {Key? key, required this.height, this.onRefresh, this.loadingText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return getErrorWidget(context);
  }

  Widget getErrorWidget(BuildContext context) {
    return onRefresh != null
        ? OtaRefreshIndicator(
            text: loadingText ??
                Text(
                  getTranslated(context, AppLocalizationsStrings.loading),
                  style: AppTheme.kBody12,
                ),
            onRefresh: onRefresh ?? () async {},
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: height - _kTopPadding,
                  child: const OtaNetworkErrorWidget(),
                )
              ],
            ),
          )
        : ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: height - _kTopPadding,
                child: const OtaNetworkErrorWidget(),
              )
            ],
          );
  }
}
