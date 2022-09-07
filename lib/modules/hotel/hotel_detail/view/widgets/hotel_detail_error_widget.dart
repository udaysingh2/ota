import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/core_pack/custom_widgets/ota_network_error_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_refresh_indicator/ota_refresh_indicator.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const double _kTopPadding = 24;

class HotelDetailErrorWidget extends StatelessWidget {
  final double height;
  final Text? loadingText;
  final Future<void> Function()? onRefresh;
  const HotelDetailErrorWidget(
      {Key? key, required this.height, this.onRefresh, this.loadingText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return getErrorWidget(context);
  }

  Text _buildLoadingText(BuildContext context) {
    return Text(
      getTranslated(context, AppLocalizationsStrings.loading),
      style: AppTheme.kBody12,
    );
  }

  Widget getErrorWidget(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(
          Offset.zero.dx, -_kTopPadding, Offset.zero.dy),
      color: Theme.of(context).canvasColor,
      height: height,
      child: OtaRefreshIndicator(
        text: loadingText ?? _buildLoadingText(context),
        onRefresh: onRefresh ?? () async {},
        child: ListView(
          shrinkWrap: false,
          padding: EdgeInsets.zero,
          // physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
                height: height - _kTopPadding, child: const OtaNetworkErrorWidget())
          ],
        ),
      ),
    );
  }
}
