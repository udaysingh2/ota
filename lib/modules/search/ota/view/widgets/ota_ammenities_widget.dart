import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/modules/favourites/helper/favourite_helper.dart';
import '../../../../../core_pack/custom_widgets/ota_amentities_widget.dart';

const double _kMargin7 = 7;
const double _kPromoImageHeight = 50;
const double _kDiscountWidth = 80;
const int _kMaxLine = 1;
const double _kImageCardBorderRadius = 10.0;
const double _kZero = 0;
const _kIconOffer = 'assets/images/icons/bg_offer_top.svg';
const _kIconPlaceholder = 'assets/images/icons/suggetion_card_palceholder.svg';
const _kAspectRatio = 2.15;
const String _kOtaSuggestionCardKey = 'ota_suggestion_card_key';
const double _kHeight = 152;
const String serviceKey = "CARRENTAL";

class OtaSuggestionCardAmenities extends StatelessWidget {
  final String headerText;
  final String description;
  final String offerPercent;
  final String imageUrl;
  final String adminPromotionLine1;
  final String adminPromotionLine2;
  final bool isInHorizontalScroll;
  final bool isDefaultSvg;
  final String placeholderImage;
  final Function()? onPress;
  final List<String> amenitiesList;

  const OtaSuggestionCardAmenities({
    Key? key,
    this.headerText = '',
    this.description = '',
    this.offerPercent = '',
    this.imageUrl = '',
    this.isInHorizontalScroll = true,
    this.onPress,
    this.isDefaultSvg = true,
    this.placeholderImage = _kIconPlaceholder,
    this.adminPromotionLine1 = '',
    this.adminPromotionLine2 = '',
    this.amenitiesList = const [],
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
                maxLines: _kMaxLine,
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(FavouriteHelper.getSvg(serviceKey)),
                const SizedBox(
                  width: kSize4,
                ),
                Flexible(
                    child: Text(
                  description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: _kMaxLine,
                  style: AppTheme.kSmall1,
                )),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius:
                  BorderRadius.all(Radius.circular(_kImageCardBorderRadius))),
          child: ClipRRect(
            key: const Key("suggetion_card_image"),
            borderRadius: const BorderRadius.all(
                Radius.circular(_kImageCardBorderRadius)),
            child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
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
    return isDefaultSvg
        ? SvgPicture.asset(placeholderImage,
            fit: isInHorizontalScroll ? BoxFit.fitHeight : BoxFit.fitWidth)
        : Image.asset(placeholderImage,
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
