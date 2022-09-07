import 'package:flutter/cupertino.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

class TicketBookingCancellationPolicy extends StatelessWidget {
  final EdgeInsets padding;
  final String? cancelPolicy;
  final bool showDivider;
  const TicketBookingCancellationPolicy({
    Key? key,
    this.padding = kPaddingHori24,
    this.cancelPolicy,
    this.showDivider = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kSize16),
          Text(
            getTranslated(
                context, AppLocalizationsStrings.tourCancellationPolicy),
            style: AppTheme.kHeading3.copyWith(color: AppColors.kGreyScale),
          ),
          const SizedBox(height: kSize10),
          if (cancelPolicy != null && cancelPolicy!.isNotEmpty)
            getCancellationPolicy(context),
          const SizedBox(height: kSize10),
          getNewCancellationPolicy(context),
          const SizedBox(height: kSize24),
          if (showDivider)
            const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
          const SizedBox(height: kSize24),
        ],
      ),
    );
  }

  Widget getNewCancellationPolicy(BuildContext context) {
    String cancelText =
        getTranslated(context, AppLocalizationsStrings.ticketCancellationLine)
            .replaceAll('\\n', '\n')
            .trim();
    return Text(
      cancelText,
      style: AppTheme.kBodyRegularGrey50,
    );
  }

  String getCancellationStatus(BuildContext context, String statusKey) {
    return statusKey;
  }

  Widget getCancellationPolicy(BuildContext context) {
    return Text(
      cancelPolicy!,
      style: AppTheme.kBody,
    );
  }
}
