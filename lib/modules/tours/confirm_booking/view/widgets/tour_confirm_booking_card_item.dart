import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/hotel_payment/helper/payment_method_helper.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_type.dart';

const int _kDefaultMaxLine = 1;

class TourConfirmBookingCardItem extends StatelessWidget {
  final bool showDivider;
  final PaymentMethodType? paymentType;
  final String? cardName;
  final String cardNumber;
  final EdgeInsetsGeometry padding;
  const TourConfirmBookingCardItem({
    Key? key,
    this.showDivider = true,
    this.paymentType = PaymentMethodType.scb,
    this.cardName,
    this.cardNumber = "",
    this.padding =
        const EdgeInsets.symmetric(horizontal: kSize24, vertical: kSize20),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          PlaymentMethodHelper.buildPaymentMethodImage(paymentType!),
          const SizedBox(width: kSize20),
          Expanded(child: _setCardName(context, cardName)),
          Text(
            (paymentType != PaymentMethodType.scb) ? cardNumber : "",
            style: AppTheme.kBodyRegular,
            maxLines: _kDefaultMaxLine,
          ),
        ],
      ),
    );
  }

  Widget _setCardName(BuildContext context, String? text) {
    return Text(
      paymentType == PaymentMethodType.scb
          ? getTranslated(context, AppLocalizationsStrings.scbEasyApp)
          : text ?? '',
      style: AppTheme.kBodyRegular,
      maxLines: 1,
    );
  }
}
