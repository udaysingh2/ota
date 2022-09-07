import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/rating_tile.dart';

import 'ota_star_rating/ota_star_rating.dart';
import 'ota_star_rating/ota_star_rating_controller.dart';

const double _kPaddingHorizontal = 8;
const double _kSpacing5 = 5;
const double _kMargine7 = 7;

const double _kPromoImageHeight = 50;
const double _kDiscountWidth = 80;
const int _kMaxLine = 1;
const double _kImageCardBorderRadius = 8.0;
const double _kZero = 0;
const int _kDefaultRating = 1;
const _kIconOffer = 'assets/images/icons/bg_offer_top.svg';
const _kIconPlaceholder = 'assets/images/icons/suggetion_card_palceholder.svg';
const _kAspectRatio = 2.15;
const String _kOtaSuggestionCardKey = 'ota_suggestion_card_key';

// TODO THIS CONST WILL BE USED WHEN THE BOTTOM DISCOUNT HAS TO BE IMPLEMENTED
// const double _kTextTop = 6;
// const double _kDiscountImageHeight = 29;
// const _kIconDiscount = 'assets/images/icons/bg_discount_bottom.svg';

class OtaSuggestionCard extends StatelessWidget {
  final String? headerText;
  final String? ratingText;
  final String? score;
  final String? reviewText;
  final String? ratingTitle;
  final String? addressText;
  final String? offerPercent;
  final String? discount;
  final String? imageUrl;
  final String? adminPromotionLine1;
  final String? adminPromotionLine2;
  final bool isInHorizonalScroll;
  final Function()? onPress;

  const OtaSuggestionCard({
    Key? key,
    this.headerText,
    this.ratingText,
    this.score,
    this.reviewText,
    this.ratingTitle,
    this.addressText,
    this.offerPercent,
    this.discount,
    this.imageUrl,
    this.isInHorizonalScroll = true,
    this.onPress,
    this.adminPromotionLine1,
    this.adminPromotionLine2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: const Key(_kOtaSuggestionCardKey),
      borderRadius:
          const BorderRadius.all(Radius.circular(_kImageCardBorderRadius)),
      onTap: onPress,
      child: Column(
        children: [
          isInHorizonalScroll
              ? Expanded(
                  child: _buildImageCard(context),
                )
              : AspectRatio(
                  aspectRatio: _kAspectRatio,
                  child: _buildImageCard(context),
                ),
          Padding(
            padding: const EdgeInsets.only(top: kSize6),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                headerText ?? '',
                style: AppTheme.kHeading2,
                overflow: TextOverflow.ellipsis,
                maxLines: _kMaxLine,
              ),
            ),
          ),
          _buildStartWidget(),
        ],
      ),
    );
  }

  Widget buildRatingTile() {
    return Row(
      children: [
        if (score != null && score!.isNotEmpty)
          RatingTile(
            text: score!,
          ),
        if (score != null && score!.isNotEmpty)
          const SizedBox(
            width: _kSpacing5,
          ),
        if (ratingTitle != null)
          Flexible(
              child: Text(
            ratingTitle!,
            overflow: TextOverflow.ellipsis,
            maxLines: _kMaxLine,
            style: AppTheme.kSmall1.copyWith(
              color: AppColors.kSecondary,
            ),
          )),
        if (ratingTitle != null)
          const SizedBox(
            width: kSize4,
          ),
        if (reviewText != null)
          Text(
            reviewText!,
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
          starRating: (double.tryParse(ratingText ?? _kDefaultRating.toString())
                  ?.floor() ??
              _kDefaultRating),
          forceToOne: true,
          otaStarRatingController: OtaStarRatingController(),
        ),
        const SizedBox(
          width: _kPaddingHorizontal,
        ),
        Expanded(
          child: Text(
            addressText ?? '',
            overflow: TextOverflow.ellipsis,
            maxLines: _kMaxLine,
            style: AppTheme.kSmall1,
          ),
        ),
      ],
    );
  }

  Widget _buildImageCard(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          key: const Key("suggetion_card_image"),
          borderRadius:
              const BorderRadius.all(Radius.circular(_kImageCardBorderRadius)),
          child: CachedNetworkImage(
              imageUrl: imageUrl ?? '',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorWidget: (context, url, error) => getDefaultImages(),
              placeholder: (context, url) => getDefaultImages()),
        ),

        if (adminPromotionLine1 != null && adminPromotionLine1!.isNotEmpty)
          Positioned(
            top: 0,
            right: 0,
            child: _buildPromoImage(
                context, adminPromotionLine1!, adminPromotionLine2 ?? ''),
          ),

        // TODO THIS WILL BE USED WHEN THE BOTTOM DISCOUNT HAS TO BE IMPLEMENTED
        // if (discount?.isNotEmpty ?? false)
        //   Positioned(
        //     bottom: 0,
        //     child: _buildDiscountImage(context, discount ?? ''),
        //   ),
      ],
    );
  }

  Widget getDefaultImages() {
    return SvgPicture.asset(_kIconPlaceholder,
        fit: isInHorizonalScroll ? BoxFit.fitHeight : BoxFit.fitWidth);
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
          margin: const EdgeInsets.only(right: _kMargine7),
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

  //TODO THIS WIDGET WILL BE USED WHEN THE BOTTOM DISCOUNT HAS TO BE IMPLEMENTED

  // Widget _buildDiscountImage(BuildContext context, String text) {
  //   return Stack(
  //     alignment: Alignment.bottomLeft,
  //     children: [
  //       SvgPicture.asset(
  //         _kIconDiscount,
  //         fit: BoxFit.cover,
  //         height: _kDiscountImageHeight,
  //       ),
  //       Container(
  //         width: _kDiscountWidth,
  //         margin: EdgeInsets.only(left: _kMargine7),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //             Transform(
  //               transform: Matrix4.translationValues(_kZero, _kTextTop, _kZero),
  //               child: Text(
  //                 '${getTranslated(context, AppLocalizationsStrings.reduceOther)}',
  //                 style: AppTheme.kofferDiscountHeader,
  //               ),
  //             ),
  //             Text(
  //               '$text ${getTranslated(context, AppLocalizationsStrings.baht)}',
  //               style: AppTheme.kofferDiscountFooter,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
