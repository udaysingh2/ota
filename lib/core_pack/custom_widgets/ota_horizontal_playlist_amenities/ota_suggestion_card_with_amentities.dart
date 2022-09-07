import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_amentities_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_star_rating/ota_star_rating.dart';
import 'package:ota/core_pack/custom_widgets/ota_star_rating/ota_star_rating_controller.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/rating_tile.dart';

const double _kPaddingHorizontal = 8;
const double _kSpacing5 = 5;
const double _kMargin7 = 7;
const double _kPromoImageHeight = 50;
const double _kDiscountWidth = 80;
const int _kMaxLine = 1;
const int _kMaxLines2 = 2;
const double _kImageCardBorderRadius = 10.0;
const double _kZero = 0;
const String _kDefaultRating = '1';
const _kIconOffer = 'assets/images/icons/bg_offer_top.svg';
const _kIconPlaceholder = 'assets/images/icons/suggetion_card_palceholder.svg';
const _kAspectRatio = 2.15;
const String _kOtaSuggestionCardKey = 'ota_suggestion_card_key';
const double _kHeight = 152;
const double _kBorderRadius = 1.0;

class OtaSuggestionCardHorizontalAmenities extends StatelessWidget {
  final String headerText;
  final String ratingText;
  final String score;
  final String reviewText;
  final String ratingTitle;
  final String addressText;
  final String offerPercent;
  final String discount;
  final String imageUrl;
  final String adminPromotionLine1;
  final String adminPromotionLine2;
  final bool isInHorizontalScroll;
  final Function()? onPress;
  final List<String> amenitiesList;
  final bool isSoldOut;

  const OtaSuggestionCardHorizontalAmenities({
    Key? key,
    this.headerText = '',
    this.ratingText = _kDefaultRating,
    this.score = '',
    this.reviewText = '',
    this.ratingTitle = '',
    this.addressText = '',
    this.offerPercent = '',
    this.discount = '',
    this.imageUrl = '',
    this.isInHorizontalScroll = true,
    this.onPress,
    this.adminPromotionLine1 = '',
    this.adminPromotionLine2 = '',
    this.amenitiesList = const [],
    this.isSoldOut = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: const Key(_kOtaSuggestionCardKey),
      borderRadius:
          const BorderRadius.all(Radius.circular(_kImageCardBorderRadius)),
      onTap: onPress,
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isInHorizontalScroll
                ? SizedBox(height: _kHeight, child: _buildImageCard(context))
                : AspectRatio(
                    aspectRatio: _kAspectRatio,
                    child: _buildImageCard(context),
                  ),
            if (amenitiesList.isNotEmpty) KeyAmenitiesWidget(amenitiesList),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                headerText,
                style: AppTheme.kBodyMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: _kMaxLines2,
              ),
            ),
            _buildStartWidget(),
          ],
        ),
      ),
    );
  }

  Widget buildRatingTile() {
    return Row(
      children: [
        if (score.isNotEmpty)
          RatingTile(
            text: score,
          ),
        if (score.isNotEmpty)
          const SizedBox(
            width: _kSpacing5,
          ),
        if (ratingTitle.isNotEmpty)
          Flexible(
              child: Text(
            ratingTitle,
            overflow: TextOverflow.ellipsis,
            maxLines: _kMaxLine,
            style: AppTheme.kSmall1.copyWith(
              color: AppColors.kSecondary,
            ),
          )),
        if (ratingTitle.isNotEmpty)
          const SizedBox(
            width: kSize4,
          ),
        if (reviewText.isNotEmpty)
          Text(
            reviewText,
            overflow: TextOverflow.ellipsis,
            maxLines: _kMaxLine,
            style: AppTheme.kSmall1,
          ),
      ],
    );
  }

  Widget _buildStartWidget() {
    return Row(
      children: [
        OtaStarRating(
          starRating: (double.tryParse(ratingText)?.floor() ??
              int.parse(_kDefaultRating)),
          forceToOne: true,
          otaStarRatingController: OtaStarRatingController(),
        ),
        const SizedBox(
          width: _kPaddingHorizontal,
        ),
        Expanded(
          child: Text(
            addressText,
            overflow: TextOverflow.ellipsis,
            maxLines: _kMaxLine,
            style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
          ),
        ),
      ],
    );
  }

  Widget _buildImageCard(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: const BorderRadius.all(
                  Radius.circular(_kImageCardBorderRadius)),
              border: Border.all(
                color: AppColors.kBorderGrey,
                width: _kBorderRadius,
              )),
          child: ClipRRect(
            key: const Key("suggetion_card_image"),
            borderRadius: const BorderRadius.all(
                Radius.circular(_kImageCardBorderRadius)),
            child: CachedNetworkImage(
                colorBlendMode: isSoldOut ? BlendMode.dstOut : null,
                color: isSoldOut ? AppColors.kWhiteOpacity65 : null,
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorWidget: (context, url, error) => getDefaultImages(),
                placeholder: (context, url) => getDefaultImages()),
          ),
        ),
        if (adminPromotionLine1.isNotEmpty)
          Positioned(
            top: kSize1,
            right: kSize1,
            child: _buildPromoImage(
                context, adminPromotionLine1, adminPromotionLine2),
          ),
      ],
    );
  }

  Widget getDefaultImages() {
    return SvgPicture.asset(_kIconPlaceholder,
        fit: isInHorizontalScroll ? BoxFit.fitHeight : BoxFit.fitWidth);
  }

  Widget _buildPromoImage(BuildContext context, String text, String text2) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        SvgPicture.asset(
          _kIconOffer,
          fit: BoxFit.cover,
          height: _kPromoImageHeight,
        ),
        Container(
          width: _kDiscountWidth,
          margin: const EdgeInsets.only(right: _kMargin7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (text.isNotEmpty)
                Transform(
                  transform: Matrix4.translationValues(_kZero, -kSize2, _kZero),
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
                        Matrix4.translationValues(_kZero, -kSize10, _kZero),
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
