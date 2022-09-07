import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/hotel_payment/helper/payment_method_helper.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_type.dart';

const int _kMaxLines = 1;
const LinearGradient _defaultBorder =
    LinearGradient(colors: <Color>[AppColors.kGrey10, AppColors.kGrey10]);

class PaymentMethodTile extends StatelessWidget {
  final String nickname;
  final String cardMask;
  final bool isDefault;
  final PaymentMethodType paymentMethodType;
  final Function()? onTap;

  const PaymentMethodTile({
    Key? key,
    required this.nickname,
    required this.cardMask,
    this.isDefault = false,
    this.paymentMethodType = PaymentMethodType.scb,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(kSize8),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(kSize1),
        decoration: BoxDecoration(
          gradient: isDefault ? AppColors.gradient1 : _defaultBorder,
          borderRadius: BorderRadius.circular(kSize8),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: kSize16,
            vertical:
                paymentMethodType == PaymentMethodType.scb ? kSize24 : kSize14,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(kSize8),
          ),
          child: paymentMethodType == PaymentMethodType.scb
              ? _buildSCBRow(context)
              : _buildCardRow(context),
        ),
      ),
    );
  }

  Widget _buildSCBRow(BuildContext context) {
    return Row(
      children: <Widget>[
        PlaymentMethodHelper.buildPaymentMethodImage(paymentMethodType),
        const SizedBox(width: kSize16),
        Expanded(child: _buildCardLabel(context)),
      ],
    );
  }

  Widget _buildCardRow(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildCardLabel(context),
        const SizedBox(height: kSize6),
        Row(
          children: <Widget>[
            Container(
              child: PlaymentMethodHelper.buildPaymentMethodImage(
                  paymentMethodType),
            ),
            const SizedBox(width: kSize16),
            Expanded(
              child: Text(
                cardMask,
                style: AppTheme.kSmall1,
                maxLines: _kMaxLines,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCardLabel(BuildContext context) {
    return Text(
      paymentMethodType == PaymentMethodType.scb
          ? getTranslated(context, AppLocalizationsStrings.scbEasyApp)
          : nickname,
      style: AppTheme.kBodyRegular,
      maxLines: _kMaxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
