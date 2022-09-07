import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/public_promo_view_model.dart';

const String _kPlaceholderImage =
    'assets/images/icons/promo_code_placeholder.svg';
const int _kMaxLines = 1;

class PromoCodeTileWidget extends StatelessWidget {
  final PublicPromotion promotion;
  final Function()? onUseNowClick;
  final Function()? onItemClick;

  const PromoCodeTileWidget({
    Key? key,
    required this.promotion,
    this.onUseNowClick,
    this.onItemClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onItemClick,
      child: Container(
        padding: const EdgeInsets.all(kSize16),
        margin: const EdgeInsets.symmetric(horizontal: kSize24),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.kGrey10),
          borderRadius: BorderRadius.circular(kSize8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kSize10),
              child: promotion.iconUrl != null
                  ? _buildPromoImage()
                  : _buildDefaultImage(context),
            ),
            const SizedBox(width: kSize16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildPromoCodeWidget(),
                  _buildPromotionNameWidget(context),
                  _buildValidityWidget(context),
                ],
              ),
            ),
            Container(
              height: kSize58,
              padding: const EdgeInsets.only(left: kSize20),
              alignment: Alignment.bottomRight,
              child: InkWell(
                key: const Key("key_apply_promo"),
                onTap: onUseNowClick,
                child: _getGradientTextWidget(
                    context, AppLocalizationsStrings.promoUseNow),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoImage() {
    return ClipRRect(
      child: CachedNetworkImage(
        imageUrl: promotion.iconUrl ?? '',
        fit: BoxFit.cover,
        width: kSize36,
        height: kSize36,
        errorWidget: (context, url, error) => _buildDefaultImage(context),
        placeholder: (context, url) => _buildDefaultImage(context),
      ),
    );
  }

  Widget _buildDefaultImage(BuildContext context) {
    return SvgPicture.asset(
      _kPlaceholderImage,
      fit: BoxFit.cover,
      width: kSize36,
      height: kSize36,
    );
  }

  Widget _buildPromoCodeWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSize4),
      child: Text(
        promotion.promotionCode,
        style: AppTheme.kSmallMedium,
        overflow: TextOverflow.ellipsis,
        maxLines: _kMaxLines,
      ),
    );
  }

  Widget _buildPromotionNameWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSize4),
      child: Text(
        promotion.shortDescription,
        style: AppTheme.kSmallRegular,
        overflow: TextOverflow.ellipsis,
        maxLines: _kMaxLines,
      ),
    );
  }

  Widget _buildValidityWidget(BuildContext context) {
    String expiryString = Helpers.getddMMMyyyy(promotion.endDate);
    return Text(
      '${getTranslated(context, AppLocalizationsStrings.promoValidUntil)} $expiryString ',
      style: AppTheme.kSmallerRegular.copyWith(color: AppColors.kGrey50),
      overflow: TextOverflow.ellipsis,
      maxLines: _kMaxLines,
    );
  }

  Widget _getGradientTextWidget(BuildContext context, String titleKey) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return AppColors.gradient1.createShader(Offset.zero & bounds.size);
      },
      child: Text(
        getTranslated(context, titleKey),
        style: AppTheme.kSmallRegular.copyWith(color: AppColors.kTrueWhite),
      ),
    );
  }
}
