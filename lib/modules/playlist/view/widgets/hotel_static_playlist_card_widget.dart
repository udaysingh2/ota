import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_amentities_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_star_rating/ota_star_rating.dart';
import 'package:ota/core_pack/custom_widgets/ota_star_rating/ota_star_rating_controller.dart';
import 'package:ota/modules/playlist/view_model/hotel_vertical_card_view_model.dart';

const double _kPaddingHorizontal = 8;
const int _kMaxLine = 1;
const double _kImageCardBorderRadius = 10.0;
const double _kPromoImageHeight = 50.0;
const double _kDiscountWidth = 80.0;
const int _kDefaultRating = 1;
const _kAspectRatio = 2.15;
const String _kOtaSuggestionCardKey = 'ota_suggestion_card_key';
const double _kHeight = 152;
const String _kPlaylistCardImageKey = 'playlist_card_image';

const String _kIconOffer = 'assets/images/icons/bg_offer_top.svg';
const _kIconPlaceholder = 'assets/images/icons/suggetion_card_palceholder.svg';
const double _kBorderRadius = 1.0;

class HotelStaticPlaylistCard extends StatelessWidget {
  final HotelVerticalCardViewModel model;
  final bool isInHorizontalScroll;
  final Function()? onPress;

  const HotelStaticPlaylistCard({
    Key? key,
    required this.model,
    this.isInHorizontalScroll = true,
    this.onPress,
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
            if (model.capsulePromotion != null &&
                model.capsulePromotion!.isNotEmpty)
              KeyAmenitiesWidget(getAmenitiesList(model.capsulePromotion!)),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                model.name!,
                style: AppTheme.kBodyMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: _kMaxLine,
              ),
            ),
            _buildStarWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildStarWidget() {
    return Row(
      children: [
        OtaStarRating(
          starRating: getRating(model.rating),
          forceToOne: true,
          otaStarRatingController: OtaStarRatingController(),
        ),
        const SizedBox(
          width: _kPaddingHorizontal,
        ),
        Expanded(
          child: Text(
            model.locationName ?? "",
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
      alignment: AlignmentDirectional.topEnd,
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
            key: const Key(_kPlaylistCardImageKey),
            borderRadius: const BorderRadius.all(
                Radius.circular(_kImageCardBorderRadius)),
            child: CachedNetworkImage(
                imageUrl: model.imageUrl ?? "",
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorWidget: (context, url, error) => getDefaultImages(),
                placeholder: (context, url) => getDefaultImages()),
          ),
        ),
        if (model.promotionTextLine1?.isNotEmpty ?? false) _buildPromoImage(),
      ],
    );
  }

  Widget getDefaultImages() {
    return SvgPicture.asset(_kIconPlaceholder,
        fit: isInHorizontalScroll ? BoxFit.fitHeight : BoxFit.fitWidth);
  }

  Widget _buildPromoImage() {
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
          margin: const EdgeInsets.only(right: kSize7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (model.promotionTextLine1 != null &&
                  model.promotionTextLine1!.isNotEmpty)
                Transform(
                  transform: Matrix4.translationValues(kSize0, -kSize2, kSize0),
                  child: Text(
                    model.promotionTextLine1!,
                    overflow: TextOverflow.clip,
                    maxLines: _kMaxLine,
                    style: AppTheme.kofferPercentageNumber
                        .copyWith(color: AppColors.kTrueWhite),
                    textAlign: TextAlign.right,
                  ),
                ),
              if (model.promotionTextLine2 != null &&
                  model.promotionTextLine2!.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(left: kSize20),
                  child: Transform(
                    transform:
                        Matrix4.translationValues(kSize0, -kSize10, kSize0),
                    child: Text(
                      model.promotionTextLine2!,
                      overflow: TextOverflow.clip,
                      maxLines: _kMaxLine,
                      style: AppTheme.kofferPercentageFooter
                          .copyWith(color: AppColors.kTrueWhite),
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

  int getRating(int? rating) {
    if (rating != null && rating != 0) {
      return rating;
    } else {
      return _kDefaultRating;
    }
  }

  List<String> getAmenitiesList(
      List<HotelVerticalCardPromotions> cardPromotions) {
    List<String> amenities = [];
    for (HotelVerticalCardPromotions promotion in cardPromotions) {
      if (promotion.name != null) {
        amenities.add(promotion.name!);
      }
    }
    return amenities;
  }
}
