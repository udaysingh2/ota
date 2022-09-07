import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

class OtaDiscountPriceWidget extends StatelessWidget {
  final double pricePerNight;
  final int? percentageDiscount;
  final bool isRightAlign;
  final double? priceBeforeDiscount;
  final double totalAmount;

  OtaDiscountPriceWidget({
    Key? key,
    required this.pricePerNight,
    this.percentageDiscount,
    this.isRightAlign = true,
    this.priceBeforeDiscount,
    required this.totalAmount,
  }) : super(key: key);

  final CurrencyUtil _currencyUtil = CurrencyUtil();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isRightAlign ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isRightAlign ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisAlignment: priceBeforeDiscount == null
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          if (isTrue())
            Row(
              mainAxisAlignment: isRightAlign
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Text(
                  _currencyUtil
                      .getFormattedPrice(priceBeforeDiscount!)
                      .addTrailingSpace(),
                  style: AppTheme.kSmallRegular.copyWith(
                    fontFamily: kFontFamily,
                    decoration: TextDecoration.lineThrough,
                    color: AppColors.kGrey50,
                  ),
                ),
                const SizedBox(
                  width: kSize4,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: kSize10),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.kBannerColor,
                    borderRadius: kBorderRad20,
                  ),
                  child: Text(
                      getTranslated(
                              context, AppLocalizationsStrings.upToDiscount)
                          .replaceAll("#", "$percentageDiscount"),
                      textAlign: TextAlign.center,
                      style: AppTheme.kSmallerRegular.copyWith(
                          fontFamily: kFontFamily,
                          decoration: TextDecoration.none,
                          color: AppColors.kLight100)),
                ),
              ],
            ),
          _getPrice(
            context,
          ),
          _totalPrice()
        ],
      ),
    );
  }

  bool isTrue() {
    return priceBeforeDiscount != null &&
        percentageDiscount != null &&
        priceBeforeDiscount != 0 &&
        percentageDiscount != 0;
  }

  Widget _getPrice(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: _currencyUtil
                .getFormattedPrice(pricePerNight)
                .addTrailingSpace(),
            style: isTrue()
                ? AppTheme.kBodyMedium.copyWith(
                    fontFamily: kFontFamily,
                    decoration: TextDecoration.none,
                    color: AppColors.kBannerColor)
                : AppTheme.kBodyMedium.copyWith(
                    fontFamily: kFontFamily,
                    decoration: TextDecoration.none,
                    color: AppColors.kGrey70)),
        TextSpan(
          text: getTranslated(context, AppLocalizationsStrings.night)
              .addLeadingSlash(),
          style: AppTheme.kBodyRegular.copyWith(
              fontFamily: kFontFamily,
              decoration: TextDecoration.none,
              color: AppColors.kGrey50),
        )
      ]),
    );
  }

  Widget _totalPrice() {
    return Builder(builder: (context) {
      return RichText(
        text: TextSpan(
          style: AppTheme.kSmallerRegular.copyWith(
              fontFamily: kFontFamily,
              decoration: TextDecoration.none,
              color: AppColors.kGrey50),
          children: [
            TextSpan(
              text: getTranslated(context, AppLocalizationsStrings.total),
            ),
            TextSpan(
              text: _currencyUtil
                  .getFormattedPrice(totalAmount)
                  .addLeadingSpace(),
            ),
          ],
        ),
      );
    });
  }
}
