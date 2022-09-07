import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/custom_widgets/ota_gradient_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/promo_code_view_model.dart';

const _kPlusIcon = "assets/images/icons/plus_group.svg";

class OtaPromoWidget extends StatelessWidget {
  final Function()? onAddPromo;
  final Function()? onRemovePromo;
  final PromoCodeData? promoCode;
  final bool isPromoApplied;

  const OtaPromoWidget({
    Key? key,
    this.onAddPromo,
    this.onRemovePromo,
    this.promoCode,
    required this.isPromoApplied,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isPromoApplied && promoCode != null
        ? _buildAvialablePromoWidget(context)
        : _buildNoPromoWidget(context);
  }

  Widget _buildAvialablePromoWidget(BuildContext context) {
    return InkWell(
      onTap: onRemovePromo,
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
                    text: getTranslated(context,
                            AppLocalizationsStrings.applyPromoPrefixLabel)
                        .addTrailingSpace(),
                    style: AppTheme.kBodyMedium
                        .copyWith(color: AppColors.kTrueWhite),
                  ),
                  TextSpan(
                    text: promoCode!.promotion.promotionCode,
                    style: AppTheme.kBodyRegular
                        .copyWith(color: AppColors.kTrueWhite),
                  )
                ],
              ),
            ),
          ),
          const Spacer(),
          _getPrice(promoCode!.priceViewModel!.effectiveDiscount),
        ],
      ),
    );
  }

  Widget _buildNoPromoWidget(BuildContext context) {
    return InkWell(
      onTap: onAddPromo,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            _kPlusIcon,
            width: kSize16,
            height: kSize16,
          ),
          const SizedBox(width: kSize4),
          OtaGradientTextWidget(
              text: getTranslated(context, AppLocalizationsStrings.promo),
              style: AppTheme.kBodyRegular)
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
