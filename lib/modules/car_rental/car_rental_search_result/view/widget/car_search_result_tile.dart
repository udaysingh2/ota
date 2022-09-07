import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/custom_widgets/ota_amentities_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/domain/car_rental/car_search_result/model/car_search_result_domain_model.dart';

const String _kCarPlaceholder =
    'assets/images/illustrations/car_list_placeholder.png';
const double _kImageHeight = 160;
const int _kMaxLine = 1;
const double _kImageCardBorderRadius = 10.0;
const double _kPromoImageHeight = 50;
const double _kDiscountWidth = 80;
const _kIconOffer = 'assets/images/icons/bg_offer_top.svg';
const _kSize3 = 3.0;

class CarSearchResultTile extends StatelessWidget {
  const CarSearchResultTile({
    Key? key,
    this.imageUrl = "",
    this.craftType = "",
    this.brandName = "",
    this.carName = "",
    this.providerCount = 0,
    this.startPrice = 0,
    this.onPressed,
    this.promotionList,
    this.capsulePromotion = const [],
  }) : super(key: key);

  final String imageUrl;
  final String craftType;
  final String brandName;
  final String carName;
  final int providerCount;
  final double startPrice;
  final Function()? onPressed;
  final OverlayPromotion? promotionList;
  final List<String> capsulePromotion;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: kSize24, right: kSize24, bottom: kSize16),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageUrl.isEmpty ? _defaultImage() : _buildImage(context),
            const SizedBox(height: kSize8),
            if (capsulePromotion.isNotEmpty)
              KeyAmenitiesWidget(capsulePromotion),
            const SizedBox(height: _kSize3),
            Text(
              brandName.addTrailingSpace() + carName,
              style: AppTheme.kBodyMedium,
              maxLines: _kMaxLine,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Text(
                  craftType,
                  style: AppTheme.kSmallerRegular
                      .copyWith(color: AppColors.kGrey50),
                ),
                Text(
                  " ${getTranslated(context, AppLocalizationsStrings.orSimilar)}",
                  style: AppTheme.kSmallerRegular
                      .copyWith(color: AppColors.kGrey50),
                ),
              ],
            ),
            const SizedBox(height: kSize4),
            Row(
              children: [
                Text(
                  "$providerCount${getTranslated(context, AppLocalizationsStrings.provider).addLeadingSpace()}",
                  style:
                      AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
                ),
                const Spacer(),
                RichText(
                  text: TextSpan(
                    text: getTranslated(
                            context, AppLocalizationsStrings.startPrice)
                        .addTrailingSpace(),
                    style: AppTheme.kSmallRegular.copyWith(
                      color: AppColors.kGrey50,
                    ),
                    children: [
                      TextSpan(
                        text: CurrencyUtil()
                            .getFormattedPrice(startPrice)
                            .addTrailingSpace(),
                        style: AppTheme.kBodyMedium,
                      ),
                      TextSpan(
                        text:
                            getTranslated(context, AppLocalizationsStrings.day)
                                .addLeadingSlash(),
                        style: AppTheme.kSmallRegular.copyWith(
                          color: AppColors.kGrey50,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _defaultImage() {
    return Image.asset(
      _kCarPlaceholder,
      fit: BoxFit.contain,
      height: _kImageHeight,
      width: double.infinity,
    );
  }

  Widget _buildImage(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(
              Radius.circular(_kImageCardBorderRadius),
            ),
          ),
          child: ClipRRect(
            key: const Key("search_car_image"),
            borderRadius: const BorderRadius.all(
              Radius.circular(_kImageCardBorderRadius),
            ),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.contain,
              height: _kImageHeight,
              width: double.infinity,
              errorWidget: (context, url, error) => _defaultImage(),
              placeholder: (context, url) => _defaultImage(),
            ),
          ),
        ),
        if (promotionList != null &&
            promotionList!.adminPromotionLine1!.isNotEmpty)
          _buildPromoImage(
            context,
            promotionList?.adminPromotionLine1 ?? '',
            promotionList?.adminPromotionLine2 ?? '',
          ),
      ],
    );
  }

  Widget _buildPromoImage(BuildContext context, String text, String text2) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        SvgPicture.asset(
          _kIconOffer,
          fit: BoxFit.fill,
          height: _kPromoImageHeight,
        ),
        Container(
          width: _kDiscountWidth,
          margin: const EdgeInsets.only(right: kSize7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (text.isNotEmpty)
                Transform(
                  transform: Matrix4.translationValues(kSize0, -kSize2, kSize0),
                  child: Text(
                    text,
                    overflow: TextOverflow.clip,
                    maxLines: _kMaxLine,
                    style: AppTheme.kofferPercentageNumber,
                    textAlign: TextAlign.right,
                  ),
                ),
              if (text2.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(left: kSize20),
                  child: Transform(
                    transform:
                        Matrix4.translationValues(kSize0, -kSize10, kSize0),
                    child: Text(
                      text2,
                      overflow: TextOverflow.clip,
                      maxLines: _kMaxLine,
                      style: AppTheme.kofferPercentageFooter,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
