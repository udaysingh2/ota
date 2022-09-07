import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const _kMaxLines = 1;

class HotelPaymentAddonServiceTile extends StatelessWidget {
  final String name;
  final double price;
  final String? currency;
  final String quantity;
  final DateTime requestDate;
  final bool showHeader;
  final Function()? onAddItemsTap;
  final Function()? onEditTap;
  final bool showDivider;

  const HotelPaymentAddonServiceTile({
    Key? key,
    required this.name,
    required this.price,
    this.currency,
    required this.quantity,
    required this.requestDate,
    this.showHeader = false,
    this.onAddItemsTap,
    this.onEditTap,
    this.showDivider = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kSize16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (showHeader) _getHeaderWidget(context),
          _getRowWidget(
            name,
            CurrencyUtil(currency: currency).getFormattedPrice(price),
          ),
          _getRowWidget(
            getTranslated(context, AppLocalizationsStrings.noOfServices),
            quantity,
          ),
          _getRowWidget(
            getTranslated(context, AppLocalizationsStrings.dateOfService),
            Helpers.getEEEdMMMyyyy(requestDate),
          ),
          const SizedBox(
            height: kSize12,
          ),
          if (showDivider)
            const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
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
              getTranslated(
                  context, AppLocalizationsStrings.additionalServices),
              style: AppTheme.kBodyMedium,
              maxLines: _kMaxLines,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getRowWidget(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSize8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(label,
                style: AppTheme.kBodyRegular,
                maxLines: _kMaxLines,
                overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(width: kSize10),
          Text(value, style: AppTheme.kBodyMedium),
        ],
      ),
    );
  }
}
