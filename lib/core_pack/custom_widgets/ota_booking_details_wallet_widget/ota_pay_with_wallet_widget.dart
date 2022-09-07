import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

class OtaPayWithWalletWidget extends StatelessWidget {
  final double walletPrice;
  final double topPadding;

  const OtaPayWithWalletWidget({
    Key? key,
    required this.walletPrice,
    this.topPadding = kSize8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildPaidWithWalletView(context);
  }

  Widget _buildPaidWithWalletView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Row(
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return AppColors.gradient2
                  .createShader(Offset.zero & bounds.size);
            },
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: getTranslated(
                        context, AppLocalizationsStrings.payWithWallet),
                    style: AppTheme.kBodyRegular
                        .copyWith(color: AppColors.kTrueWhite),
                  )
                ],
              ),
            ),
          ),
          const Spacer(),
          _getPrice(walletPrice),
        ],
      ),
    );
  }

  Widget _getPrice(double price) {
    CurrencyUtil currencyUtil = CurrencyUtil();
    return Text(currencyUtil.getFormattedPrice(price).addLeadingDash(),
        style: AppTheme.kBodyMedium.copyWith(color: AppColors.kSecondary));
  }
}
