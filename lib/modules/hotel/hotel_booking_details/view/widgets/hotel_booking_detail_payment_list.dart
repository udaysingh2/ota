import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/core_pack/custom_widgets/ota_booking_details_wallet_widget/ota_pay_with_wallet_widget.dart';
import 'package:ota/core_pack/custom_widgets/promo_widget/view/ota_promo_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/ota_common/helper/ota_service_enabled_helper.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/promo_code_view_model.dart';

const int _kMaxLines = 1;

class HotelBookingDetailPaymentList extends StatelessWidget {
  final double totalRoomPrice;
  final double totalServicePrice;
  final double discountAmount;
  final double grandTotal;
  final CurrencyUtil _currencyUtil = CurrencyUtil();
  final PromoCodeData? appliedPromo;
  final bool isWalletAvailable;
  final String? walletAmount;

  HotelBookingDetailPaymentList({
    Key? key,
    required this.discountAmount,
    required this.grandTotal,
    required this.totalServicePrice,
    required this.totalRoomPrice,
    this.appliedPromo,
    this.isWalletAvailable = false,
    this.walletAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: kSize24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getPriceWidget(
                    context,
                    AppLocalizationsStrings.hotelBookingRoomsLabel,
                    _currencyUtil.getFormattedPrice(totalRoomPrice)),
                const SizedBox(height: kSize10),
                _getPriceWidget(
                  context,
                  AppLocalizationsStrings.additionalService,
                  _currencyUtil.getFormattedPrice(totalServicePrice),
                ),
                if (appliedPromo != null) const SizedBox(height: kSize8),
                if (appliedPromo != null)
                  OtaPromoWidget(
                    isPromoApplied: true,
                    promoCode: appliedPromo!,
                  ),
                isWalletAvailable && OtaServiceEnabledHelper.isWalletEnabled()
                    ? OtaPayWithWalletWidget(
                        walletPrice:
                            double.tryParse(walletAmount ?? '0') ?? 0.00,
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: kSize16),
                _getTotalPriceWidget(
                    context,
                    AppLocalizationsStrings.totalPayment,
                    AppLocalizationsStrings.includeVatAndFees,
                    _currencyUtil.getFormattedPrice(grandTotal)),
                const SizedBox(height: kSize8),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getTotalPriceWidget(
    BuildContext context,
    String topText,
    String bottomText,
    String totalText,
  ) {
    return Row(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getTranslated(context, topText),
              style: AppTheme.kBodyMedium,
            ),
            Text(getTranslated(context, bottomText),
                style: AppTheme.kSmallRegular.copyWith(
                  color: AppColors.kGrey50,
                )),
          ],
        )),
        Text(
          getTranslated(context, totalText),
          style: AppTheme.kBodyMedium,
        ),
      ],
    );
  }

  Widget _getPriceWidget(
      BuildContext context, String leftText, String rightText) {
    return Row(
      children: [
        Expanded(
            child: Text(
          getTranslated(context, leftText),
          style: AppTheme.kBodyRegular,
          maxLines: _kMaxLines,
          overflow: TextOverflow.ellipsis,
        )),
        Text(rightText, style: AppTheme.kBodyMedium),
      ],
    );
  }
}
