import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/core_pack/custom_widgets/ota_refresh_indicator/ota_refresh_indicator.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

import 'car_network_error_widget.dart';

const double _kTopPadding = 24;

class CarNetworkErrorWidgetWithRefresh extends StatelessWidget {
  final double height;
  final Text? loadingText;
  final String? errorTextFooter;
  final Future<void> Function()? onRefresh;
  const CarNetworkErrorWidgetWithRefresh(
      {Key? key,
      required this.height,
      this.onRefresh,
      this.loadingText,
      this.errorTextFooter})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return getErrorWidget(context);
  }

  Widget getErrorWidget(BuildContext context) {
    return Material(
      child: Container(
        transform: Matrix4.translationValues(
            Offset.zero.dx, -_kTopPadding, Offset.zero.dy),
        color: AppColors.kLight100,
        height: height,
        child: OtaRefreshIndicator(
          text: loadingText ??
              Text(getTranslated(context, AppLocalizationsStrings.loading)),
          onRefresh: onRefresh ?? () async {},
          child: ListView(
            shrinkWrap: false,
            padding: EdgeInsets.zero,
            // physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(
                  height: height - _kTopPadding,
                  child: OtaCarNetworkErrorWidget(
                      errorTextHeader:
                          getTranslated(context, AppLocalizationsStrings.sorry),
                      errorTextFooter: errorTextFooter))
            ],
          ),
        ),
      ),
    );
  }
}