import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_amentities_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/playlist/view_model/car_vertical_card_view_model.dart';

const int _kMaxLine = 1;
const double _kHeight = 152;
const String _kIconOffer = 'assets/images/icons/bg_offer_top.svg';
const String _kIconPlaceholder =
    'assets/images/illustrations/car_list_placeholder.png';
const String _kCarIcon = 'assets/images/icons/car_sideview.svg';
const double _kPromoImageHeight = 50;
const double _kDiscountWidth = 121;
const String _kPlaylistCardImageKey = 'playlist_card_image';

const double _kImageCardBorderRadius = 10.0;
const int _kDefaultRating = 1;
const _kAspectRatio = 2.15;

const double _kBorderRadius = 1.0;

class CarStaticPlaylistCard extends StatelessWidget {
  final CarVerticalCardViewModel model;
  final bool isInHorizontalScroll;
  final Function()? onPress;

  const CarStaticPlaylistCard({
    Key? key,
    required this.model,
    this.isInHorizontalScroll = true,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: const Key(_kPlaylistCardImageKey),
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
                model.name ?? '',
                style: AppTheme.kBodyMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: _kMaxLine,
              ),
            ),
            _buildCategoryLocationWidget(context),
          ],
        ),
      ),
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
                color: Colors.transparent,
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
        if (model.promotionTextLineOne?.isNotEmpty ?? false) _buildPromoImage(),
      ],
    );
  }

  Widget getDefaultImages() {
    return Image.asset(_kIconPlaceholder,
        fit: isInHorizontalScroll ? BoxFit.fitHeight : BoxFit.fitWidth);
  }

  Widget _buildPromoImage() {
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
              if (model.promotionTextLineOne!.isNotEmpty)
                Transform(
                  transform: Matrix4.translationValues(kSize0, -kSize2, kSize0),
                  child: Text(
                    model.promotionTextLineOne!,
                    overflow: TextOverflow.clip,
                    maxLines: _kMaxLine,
                    style: AppTheme.kofferPercentageNumber,
                    textAlign: TextAlign.right,
                  ),
                ),
              if (model.promotionTextLineTwo!.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(left: kSize20),
                  child: Transform(
                    transform:
                        Matrix4.translationValues(kSize0, -kSize10, kSize0),
                    child: Text(
                      model.promotionTextLineTwo!,
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

  Widget _buildCategoryLocationWidget(BuildContext context) {
    return Row(
      children: [
        _getIcon(),
        const SizedBox(width: kSize4),
        if (isNotNullEmpty(model.craftType))
          _getTextView(model.craftType?.trim() ?? ''),
        if (isNotNullEmpty(model.craftType)) const SizedBox(width: kSize2),
        if (isNotNullEmpty(model.craftType))
          _getTextView(
            getTranslated(context, AppLocalizationsStrings.orSimilar),
          ),
      ],
    );
  }

  Widget _getIcon() {
    return SvgPicture.asset(
      _kCarIcon,
      height: kSize16,
      width: kSize16,
      fit: BoxFit.contain,
      color: AppColors.kGrey50,
    );
  }

  Widget _getTextView(String text) {
    return Text(
      text,
      style: AppTheme.kSmall1,
      maxLines: _kMaxLine,
      overflow: TextOverflow.ellipsis,
    );
  }

  bool isNotNullEmpty(String? value) => value != null && value.isNotEmpty;

  int getRating(int? rating) {
    if (rating != null && rating != 0) {
      return rating;
    } else {
      return _kDefaultRating;
    }
  }

  List<String> getAmenitiesList(
      List<CarVerticalCardPromotions> cardPromotions) {
    List<String> amenities = [];
    for (CarVerticalCardPromotions promotion in cardPromotions) {
      if (promotion.name != null) {
        amenities.add(promotion.name!);
      }
    }
    return amenities;
  }
}
