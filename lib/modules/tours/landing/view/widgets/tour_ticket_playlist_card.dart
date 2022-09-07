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
import 'package:ota/modules/tours/playlist/view_model/playlist_type.dart';

const int _kMaxLine = 1;
const double _kPromoImageHeight = 50;
const double _kDiscountWidth = 80;
const _kVerticalAspectRatio = 2.15;
const _kHorizontalAspectRatio = 1.59;

const String _kIconOffer = 'assets/images/icons/bg_offer_top.svg';
const String _kIconPlaceholder =
    'assets/images/icons/suggetion_card_palceholder.svg';
const String _kTourIcon = 'assets/images/icons/tour_icon.svg';
const String _kTicketIcon = 'assets/images/icons/ticket_icon.svg';
const String _kPlaylistCardImageKey = 'playlist_card_image';

class TourTicketPlaylistCard extends StatelessWidget {
  final String? name;
  final String? imageUrl;
  final String? promotionTextTop;
  final String? promotionTextBottom;
  final String? location;
  final String? cityName;
  final String? category;
  final double? price;
  final String? currency;
  final PlaylistType? playlistType;
  final bool isInHorizontalScroll;
  final List<String>? amentities;
  final int? maxLines;
  final Function()? onPress;

  const TourTicketPlaylistCard({
    Key? key,
    this.name,
    this.imageUrl,
    this.promotionTextTop,
    this.promotionTextBottom,
    this.location,
    this.cityName,
    this.category,
    this.price,
    this.currency,
    this.playlistType = PlaylistType.tour,
    this.isInHorizontalScroll = true,
    this.onPress,
    this.amentities,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(kSize8),
      onTap: onPress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: isInHorizontalScroll
                ? _kHorizontalAspectRatio
                : _kVerticalAspectRatio,
            child: _buildImageCard(),
          ),
          (amentities != null && amentities!.isNotEmpty)
              ? KeyAmenitiesWidget(amentities!)
              : const SizedBox(height: kSize4),
          _buildName(),
          _buildCategoryLocationWidget(),
          const SizedBox(height: kSize8),
          if (price != null) _buildPriceDetailWidget(context),
        ],
      ),
    );
  }

  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSize2),
      child: Text(
        name ?? "",
        style: AppTheme.kBodyMedium,
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines,
      ),
    );
  }

  Widget _buildImageCard() {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        ClipRRect(
          key: const Key(_kPlaylistCardImageKey),
          borderRadius: const BorderRadius.all(Radius.circular(kSize8)),
          child: imageUrl != null && imageUrl!.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: imageUrl!,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  errorWidget: (context, url, error) => _getDefaultImages(),
                  placeholder: (context, url) => _getDefaultImages())
              : _getDefaultImages(),
        ),
        if (promotionTextTop?.isNotEmpty ?? false) _buildPromoImage(),
      ],
    );
  }

  Widget _getDefaultImages() {
    return SvgPicture.asset(
      _kIconPlaceholder,
      fit: BoxFit.cover,
      width: double.infinity,
    );
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
              if (promotionTextTop != null && promotionTextTop!.isNotEmpty)
                Transform(
                  transform: Matrix4.translationValues(kSize0, -kSize2, kSize0),
                  child: Text(
                    promotionTextTop!,
                    overflow: TextOverflow.clip,
                    maxLines: _kMaxLine,
                    style: AppTheme.kofferPercentageNumber
                        .copyWith(color: AppColors.kTrueWhite),
                    textAlign: TextAlign.right,
                  ),
                ),
              if (promotionTextBottom != null &&
                  promotionTextBottom!.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(left: kSize20),
                  child: Transform(
                    transform:
                        Matrix4.translationValues(kSize0, -kSize10, kSize0),
                    child: Text(
                      promotionTextBottom!,
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
        if (isNotNullEmpty(category)) _getIcon(),
        if (isNotNullEmpty(category)) const SizedBox(width: kSize4),
        if (_categoryLocation != null) _getTextView(_categoryLocation!),
      ],
    );
  }

  String? get _categoryLocation {
    String? text;
    String? locationCity = _locationCity;
    if (isNotNullEmpty(category) && locationCity != null) {
      text = category!.addTrailingDot() + locationCity;
    } else if (isNotNullEmpty(category)) {
      text = category;
    } else if (locationCity != null) {
      text = locationCity;
    }
    return text;
  }

  String? get _locationCity {
    String? text;
    if (isNotNullEmpty(location) && isNotNullEmpty(cityName)) {
      text = "${location!}, ${cityName!}";
    } else if (isNotNullEmpty(location)) {
      text = location;
    } else if (isNotNullEmpty(cityName)) {
      text = cityName;
    }
    return text;
  }

  Widget _getIcon() {
    return SvgPicture.asset(
      playlistType == PlaylistType.tour ? _kTourIcon : _kTicketIcon,
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

  Widget _buildPriceDetailWidget(BuildContext context) {
    CurrencyUtil currencyUtil = CurrencyUtil(currency: currency);
    String priceText = currencyUtil.getFormattedPrice(price ?? 0);
    return Align(
      alignment:
          isInHorizontalScroll ? Alignment.bottomLeft : Alignment.bottomRight,
      child: RichText(
        maxLines: _kMaxLine,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          children: [
            TextSpan(
                text: getTranslated(context, AppLocalizationsStrings.startAt),
                style: AppTheme.kRichTextStyle(
                    AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50))),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kSize4),
                child: Text(priceText,
                    style: AppTheme.kRichTextStyle(AppTheme.kBodyMedium)),
              ),
            ),
            TextSpan(
              text: getTranslated(
                context,
                playlistType == PlaylistType.tour
                    ? AppLocalizationsStrings.pax
                    : AppLocalizationsStrings.perTicketPriceLabel,
              ).addLeadingSlash(),
              style: AppTheme.kRichTextStyle(
                  AppTheme.kBodyRegular.copyWith(color: AppColors.kGrey50)),
            ),
          ],
        ),
      ),
    );
  }

  bool isNotNullEmpty(String? value) => value != null && value.isNotEmpty;
}
