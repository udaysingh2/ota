import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/custom_widgets/ota_amentities_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_rental_vertical_palylist/view_model/car_rental_vertical_view_model.dart';

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

class CarVerticalStaticPlaylistCard extends StatelessWidget {
  final CarVerticalList model;
  final bool isInHorizontalScroll;
  final Function()? onPress;

  const CarVerticalStaticPlaylistCard({
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
                (model.brandName ?? '').addTrailingSpace() +
                    (model.modelName ?? ''),
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
                imageUrl: model.images?.thumb ?? "",
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorWidget: (context, url, error) => getDefaultImages(),
                placeholder: (context, url) => getDefaultImages()),
          ),
        ),
        if (model.overlayPromotion?.adminPromotionLine1?.isNotEmpty ?? false)
          _buildPromoImage(),
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
              if (model.overlayPromotion!.adminPromotionLine1!.isNotEmpty)
                Transform(
                  transform: Matrix4.translationValues(kSize0, -kSize2, kSize0),
                  child: Text(
                    model.overlayPromotion!.adminPromotionLine1!,
                    overflow: TextOverflow.clip,
                    maxLines: _kMaxLine,
                    style: AppTheme.kofferPercentageNumber,
                    textAlign: TextAlign.right,
                  ),
                ),
              if (model.overlayPromotion!.adminPromotionLine2!.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(left: kSize20),
                  child: Transform(
                    transform:
                        Matrix4.translationValues(kSize0, -kSize10, kSize0),
                    child: Text(
                      model.overlayPromotion!.adminPromotionLine2!,
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

  _setOrSimilar(BuildContext context, String text) {
    String similar = getTranslated(context, AppLocalizationsStrings.orSimilar);
    if (text.contains(similar)) {
      return text;
    } else {
      return text.trim() + similar.addLeadingSpace();
    }
  }

  Widget _buildCategoryLocationWidget(BuildContext context) {
    return Row(
      children: [
        _getIcon(),
        const SizedBox(width: kSize2),
        if (isNotNullEmpty(model.carInfo?.carTypeName ?? ''))
          _getTextView(
              _setOrSimilar(context, model.carInfo?.carTypeName ?? '')),
        if (isNotNullEmpty(model.carInfo?.carTypeName ?? ''))
          const SizedBox(width: kSize2),
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

  List<String> getAmenitiesList(List<CapsulePromotionModel> cardPromotions) {
    List<String> amenities = [];
    for (CapsulePromotionModel promotion in cardPromotions) {
      if (promotion.name != null) {
        amenities.add(promotion.name!);
      }
    }
    return amenities;
  }
}
