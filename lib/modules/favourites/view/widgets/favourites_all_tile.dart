import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/favourites/helper/favourite_helper.dart';
import 'package:ota/modules/favourites/view_model/favourite_all_view_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/icon_text_widget.dart';

const _kHotelIconPlaceholder =
    'assets/images/icons/suggetion_card_palceholder.svg';
const _kCarRentalIconPlaceholder =
    'assets/images/illustrations/car_rental_default.png';
const _kIconOffer = 'assets/images/icons/bg_offer_top.svg';
const _kHeartIconPlaceholder = "assets/images/icons/heart_selected.svg";

const double _kPromoImageHeight = 50;
const double _kDiscountWidth = 80;
const _kSize92 = 92.0;
const _kSize45 = 45.0;
const _k0Point5 = 0.5;
const _kDividerColor = Color(0xFFF0F0F0);
const _kTourNameLine = 2;
const _kAccommodationNameLine = 1;
const String _kHeartIconButtonKey = 'heart_icon_button_key';
const String _favouriteCardImageKey = 'favourite_card_image';
const int _kMaxLine = 1;
const double _kZero = 0;
const double _kMargine7 = 7;
const _kCarRental = "CARRENTAL";

class FavouriteAllTile extends StatelessWidget {
  final FavouritesAllViewModel favouritesAll;
  final Function()? onTap;

  const FavouriteAllTile({
    Key? key,
    required this.favouritesAll,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kSize16, vertical: kSize19),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: _kSize92,
                width:
                    (MediaQuery.of(context).size.width * _k0Point5) - _kSize45,
                child: _buildImageCard(context),
              ),
              const SizedBox(width: kSize16),
              Expanded(
                child: SizedBox(
                  height: _kSize92,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              favouritesAll.name,
                              style: AppTheme.kSmallMedium,
                              maxLines: _kTourNameLine,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          _buildFavouriteButton(),
                        ],
                      ),
                      const SizedBox(height: kSize4),
                      if (favouritesAll.location.isNotEmpty)
                        Text(
                          favouritesAll.location,
                          maxLines: _kAccommodationNameLine,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.kSmallRegular
                              .copyWith(color: AppColors.kGrey50),
                        ),
                      const SizedBox(height: kSize4),
                      IconTextWidget(
                        text: getTranslated(
                          context,
                          FavouriteHelper.getServiceTypeString(
                            favouritesAll.serviceName,
                          ),
                        ),
                        iconName: FavouriteHelper.getSvg(
                          favouritesAll.serviceName,
                        ),
                        iconTextGutter: kSize4,
                        textStyle: AppTheme.kSmallRegular
                            .copyWith(color: AppColors.kGrey50),
                        variableAlignment: CrossAxisAlignment.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: kSize16),
          child: OtaHorizontalDivider(
            dividerColor: _kDividerColor,
          ),
        ),
      ],
    );
  }

  Widget _buildImageCard(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          key: const Key(_favouriteCardImageKey),
          borderRadius: BorderRadius.circular(kSize8),
          child: favouritesAll.imageUrl.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: favouritesAll.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorWidget: (context, url, error) =>
                      _getDefaultImages(favouritesAll.serviceName),
                  placeholder: (context, url) =>
                      _getDefaultImages(favouritesAll.serviceName),
                )
              : _getDefaultImages(favouritesAll.serviceName),
        ),
        if (favouritesAll.promotionListLine1.isNotEmpty)
          Positioned(
            top: 0,
            right: 0,
            child: _buildPromoImage(
              context,
              favouritesAll.promotionListLine1,
              favouritesAll.promotionListLine2,
            ),
          ),
      ],
    );
  }

  _getDefaultImages(String serviceName) {
    switch (serviceName) {
      case _kCarRental:
        return Image.asset(
          _kCarRentalIconPlaceholder,
          fit: BoxFit.cover,
        );
      default:
        return SvgPicture.asset(
          _kHotelIconPlaceholder,
          fit: BoxFit.cover,
        );
    }
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
