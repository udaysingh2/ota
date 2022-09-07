import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/core_pack/custom_widgets/ota_gradient_text_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const _kMaxLines = 1;

class TourAndTicketBookingDetailsRefundWidget extends StatelessWidget {
  final double? netPrice;
  final double? cancellationFee;
  final double? totalRefund;
  final bool showHeader;
  final CurrencyUtil _currencyUtil = CurrencyUtil();

  TourAndTicketBookingDetailsRefundWidget({
    Key? key,
    this.netPrice,
    this.cancellationFee,
    required this.totalRefund,
    this.showHeader = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kSize24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (showHeader) _getHeaderWidget(context),
          _getRowWidget(
            label:
                getTranslated(context, AppLocalizationsStrings.paymentReserve),
            value: netPrice,
            isTotalRefund: false,
          ),
          _getRowWidget(
            label: getTranslated(
                context, AppLocalizationsStrings.tourCancellationFee),
            value: cancellationFee,
            isTotalRefund: false,
          ),
          const OtaHorizontalDivider(
            dividerColor: AppColors.kGrey10,
            height: kSize32,
          ),
          _getRowWidget(
            label: getTranslated(
                context, AppLocalizationsStrings.totalRefundAmount),
            value: totalRefund,
            isTotalRefund: true,
          ),
        ],
      ),
    );
  }

  Widget _getHeaderWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSize8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              getTranslated(context, AppLocalizationsStrings.refundDetails),
              style: AppTheme.kHeading1Medium,
              maxLines: _kMaxLines,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: kSize24),
        ],
      ),
    );
  }

  Widget _getRowWidget(
      {String? label, double? value, bool isTotalRefund = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSize8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(label ?? '',
                style: isTotalRefund
                    ? AppTheme.kBodyMedium
                    : AppTheme.kBodyRegular,
                maxLines: _kMaxLines,
                overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(width: kSize10),
          isTotalRefund
              ? OtaGradientText(
                  gradientText: _currencyUtil.getFormattedPrice(value ?? 0.0),
                  gradientTextStyle: AppTheme.kBodyMedium,
                )
              : Text(_currencyUtil.getFormattedPrice(value ?? 0.0),
                  style: AppTheme.kBodyMedium),
        ],
      ),
    );
  }
}
