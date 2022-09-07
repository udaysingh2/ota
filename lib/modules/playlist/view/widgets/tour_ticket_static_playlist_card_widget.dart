import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/custom_widgets/ota_amentities_widget.dart';
import 'package:ota/modules/playlist/view_model/static_playlist_type.dart';
import 'package:ota/modules/playlist/view_model/tour_vertical_card_view_model.dart';

const int _kMaxLine = 1;
const double _kHeight = 152;
const double _kPromoImageHeight = 50;
const String _kIconOffer = 'assets/images/icons/bg_offer_top.svg';
const String _kIconPlaceholder =
    'assets/images/icons/suggetion_card_palceholder.svg';
const String _kTourIcon = 'assets/images/icons/tour_icon.svg';
const String _kTicketIcon = 'assets/images/icons/ticket_icon.svg';
const String _kPlaylistCardImageKey = 'playlist_card_image';

const double _kImageCardBorderRadius = 10.0;
const double _kDiscountWidth = 80.0;
const int _kDefaultRating = 1;
const _kAspectRatio = 2.15;
const double _kBorderRadius = 1.0;

class TourTicketStaticPlaylistCard extends StatelessWidget {
  final TourVerticalCardViewModel model;
  final StaticPlaylistType? playlistType;
  final bool isInHorizontalScroll;
  final Function()? onPress;

  const TourTicketStaticPlaylistCard({
    Key? key,
    required this.model,
    required this.playlistType,
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
                model.name!,
                style: AppTheme.kBodyMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: _kMaxLine,
              ),
            ),
            _buildCategoryLocationWidget(),
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
        if (model.promotionTextLineOne?.isNotEmpty ?? false) _buildPromoImage(),
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
              if (model.promotionTextLineOne != null &&
                  model.promotionTextLineOne!.isNotEmpty)
                Transform(
                  transform: Matrix4.translationValues(kSize0, -kSize2, kSize0),
                  child: Text(
                    model.promotionTextLineOne!,
                    overflow: TextOverflow.clip,
                    maxLines: _kMaxLine,
                    style: AppTheme.kofferPercentageNumber
                        .copyWith(color: AppColors.kTrueWhite),
                    textAlign: TextAlign.right,
                  ),
                ),
              if (model.promotionTextLineTwo != null &&
                  model.promotionTextLineTwo!.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(left: kSize20),
                  child: Transform(
                    transform:
                        Matrix4.translationValues(kSize0, -kSize10, kSize0),
                    child: Text(
                      model.promotionTextLineTwo!,
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

  Widget _buildCategoryLocationWidget() {
    return Row(
      children: [
        if (isNotNullEmpty(model.styleName)) _getIcon(),
        if (isNotNullEmpty(model.styleName)) const SizedBox(width: kSize4),
        if (_categoryLocation != null) _getTextView(_categoryLocation!),
      ],
    );
  }

  String? get _categoryLocation {
    String? text = "";
    String? locationCity = _locationCity;
    if (isNotNullEmpty(model.styleName) && isNotNullEmpty(locationCity)) {
      text = model.styleName!.addTrailingDot() + locationCity!;
    } else if (isNotNullEmpty(model.styleName)) {
      text = model.styleName;
    } else if (locationCity != null) {
      text = locationCity;
    }
    return text;
  }

  String? get _locationCity {
    String? text = "";
    if (isNotNullEmpty(model.locationName) && isNotNullEmpty(model.cityName)) {
      text = "${model.locationName!}, ${model.cityName!}";
    } else if (isNotNullEmpty(model.locationName)) {
      text = model.locationName;
    } else if (isNotNullEmpty(model.cityName)) {
      text = model.cityName;
    }
    return text;
  }

  Widget _getIcon() {
    return SvgPicture.asset(
      playlistType == StaticPlaylistType.tour ? _kTourIcon : _kTicketIcon,
      height: kSize16,
      width: kSize16,
      fit: BoxFit.contain,
      color: AppColors.kGrey50,
    );
  }

  Widget _getTextView(String text) {
    return Expanded(
      child: Text(
        text,
        style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
        maxLines: _kMaxLine,
        overflow: TextOverflow.ellipsis,
      ),
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
      List<TourVerticalCardPromotions> cardPromotions) {
    List<String> amenities = [];
    for (TourVerticalCardPromotions promotion in cardPromotions) {
      if (promotion.name != null) {
        amenities.add(promotion.name!);
      }
    }
    return amenities;
  }
}
