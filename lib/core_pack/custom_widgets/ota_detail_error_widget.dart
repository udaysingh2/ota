import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_network_error_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_refresh_indicator/ota_refresh_indicator.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

class OtaDetailErrorWidget extends StatelessWidget {
  final double height;
  final Text? loadingText;
  final Future<void> Function()? onRefresh;
  const OtaDetailErrorWidget(
      {Key? key,required this.height, this.onRefresh, this.loadingText}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return getErrorWidget(context);
  }

  Text _buildLoadingText(BuildContext context) {
    return Text(
      getTranslated(context, AppLocalizationsStrings.loading),
      style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
    );
  }

  Widget getErrorWidget(BuildContext context) {
    return Container(
      transform:
          Matrix4.translationValues(Offset.zero.dx, -kSize48, Offset.zero.dy),
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
            SizedBox(height: height - kSize12, child: const OtaNetworkErrorWidget())
          ],
        ),
      ),
    );
  }
}
