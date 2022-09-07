import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/core_pack/custom_widgets/ota_network_error_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_refresh_indicator/ota_refresh_indicator.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const double _kTopPadding = 24;

class CarDetailErrorWidget extends StatelessWidget {
  final Future<void> Function()? onRefresh;
  final double height;

  const CarDetailErrorWidget({
    Key? key,
    this.onRefresh,
    required this.height,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(
          Offset.zero.dx, -_kTopPadding, Offset.zero.dy),
      color: Theme.of(context).canvasColor,
      height: height,
      child: OtaRefreshIndicator(
        text: _buildLoadingText(context),
        onRefresh: onRefresh ?? () async {},
        child: ListView(
          shrinkWrap: false,
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: height - _kTopPadding,
              child: const OtaNetworkErrorWidget(),
            )
          ],
        ),
      ),
    );
  }

  Text _buildLoadingText(BuildContext context) {
    return Text(
      getTranslated(context, AppLocalizationsStrings.loading),
      style: AppTheme.kSmallRegular,
    );
  }
}
