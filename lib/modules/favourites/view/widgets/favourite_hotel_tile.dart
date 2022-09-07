import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/favourites/view_model/favourite_hotel_view_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/icon_text_widget.dart';

const _kHotelIconPlaceholder =
    'assets/images/icons/suggetion_card_palceholder.svg';

const _kHeartIconPlaceholder = "assets/images/icons/heart_selected.svg";
const _kDividerColor = Color(0xFFF0F0F0);
const _kMaxHotelNameLine = 2;
const String _kHeartIconButtonKey = 'heart_icon_button_key';
const double _kMargine7 = 7;
const double _kPromoImageHeight = 50;
const double _kDiscountWidth = 80;
const int _kMaxLine = 1;
const double _kZero = 0;
const _kIconOffer = 'assets/images/icons/bg_offer_top.svg';
const _kLocationIconAsset = "assets/images/icons/travel_location_company.svg";
const double _kImageWidth = 165;

class FavouriteHotelTile extends StatelessWidget {
  final FavouritesHotelViewModel? favouritesHotel;
  final String serviceNameType;
  final Function()? onTap;

  const FavouriteHotelTile({
    Key? key,
    this.favouritesHotel,
    required this.serviceNameType,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return favouritesHotel == null ||
            favouritesHotel?.hotelId == null ||
            favouritesHotel?.hotelName == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: kSize15),
            child: Column(
              children: [
                const SizedBox(height: kSize15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: kSize100,
                      width: _kImageWidth,
                      child: _buildImageCard(context),
                    ),
                    const SizedBox(width: kSize12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  (favouritesHotel?.hotelName ?? ''),
                                  style: AppTheme.kSmallMedium,
                                  maxLines: _kMaxHotelNameLine,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              _buildFavouriteButton(),
                            ],
                          ),
                          Text(
                            favouritesHotel?.location ?? '',
                            style: AppTheme.kSmallRegular.copyWith(
                              color: AppColors.kGrey50,
                            ),
                          ),
                          const SizedBox(height: kSize4),
                          IconTextWidget(
                            text: getTranslated(context, serviceNameType),
                            iconName: _kLocationIconAsset,
                            iconTextGutter: kSize4,
                            textStyle: AppTheme.kSmallRegular
                                .copyWith(color: AppColors.kGrey50),
                            variableAlignment: CrossAxisAlignment.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kSize15),
                const OtaHorizontalDivider(
                  dividerColor: _kDividerColor,
                ),
              ],
            ),
          );
  }

  Widget _buildImageCard(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(kSize10),
          child: CachedNetworkImage(
            width: _kImageWidth,
            imageUrl: favouritesHotel?.imageUrl ?? '',
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => _getDefaultImages(),
            placeholder: (context, url) => _getDefaultImages(),
          ),
        ),
        if (favouritesHotel?.promotionListLine1 != null &&
            favouritesHotel!.promotionListLine1.isNotEmpty)
          Positioned(
            top: 0,
            right: 0,
            child: _buildPromoImage(
                context,
                favouritesHotel?.promotionListLine1 ?? '',
                favouritesHotel?.promotionListLine2 ?? ''),
          ),
      ],
    );
  }

  Widget _getDefaultImages() {
    return SvgPicture.asset(
      _kHotelIconPlaceholder,
      fit: BoxFit.cover,
    );
  }

  Widget _buildFavouriteButton() {
    return OtaIconButton(
      key: const Key(_kHeartIconButtonKey),
      icon: _getHeartIconSvg(),
      onTap: onTap,
    );
  }

  Widget _getHeartIconSvg() {
    return Center(
      child: SvgPicture.asset(
        _kHeartIconPlaceholder,
        height: kSize14,
        width: kSize16,
        fit: BoxFit.cover,
      ),
    );
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
}
