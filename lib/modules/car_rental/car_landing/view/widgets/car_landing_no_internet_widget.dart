import 'package:flutter/cupertino.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_network_error_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_refresh_indicator/ota_refresh_indicator.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const double _kTopPadding = 24;

class CarLandingErrorWidget extends StatelessWidget {
  final double height;
  final Future<void> Function()? onRefresh;

  const CarLandingErrorWidget({
    Key? key,
    this.onRefresh,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getErrorWidget(context);
  }

  Widget _getErrorWidget(BuildContext context) {
    return OtaRefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      text: _buildLoadingText(context),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        child: SizedBox(
          height: height - _kTopPadding,
          child: const OtaNetworkErrorWidget(
            paddingHeight: kSize8,
          ),
        ),
      ),
    );
  }

  Text _buildLoadingText(BuildContext context) {
    return Text(
      getTranslated(context, AppLocalizationsStrings.loading),
      style: AppTheme.kSmallerRegular.copyWith(
        color: AppColors.kGrey50,
      ),
    );
  }
}
