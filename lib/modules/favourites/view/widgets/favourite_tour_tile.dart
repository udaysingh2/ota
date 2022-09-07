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
import 'package:ota/modules/favourites/view/widgets/favourites_options/favourites_options_model.dart';
import 'package:ota/modules/favourites/view_model/favourite_tour_view_model.dart';

const _kTourIconPlaceholder =
    'assets/images/icons/suggetion_card_palceholder.svg';
const _kTourIcon = 'assets/images/icons/tour_icon.svg';
const _kTicketIcon = 'assets/images/icons/uil_ticket.svg';
const _kSize92 = 92.0;
const _kSize45 = 45.0;
const _k0Point5 = 0.5;
const _kSize3 = 3.0;
const _kHeartIconPlaceholder = "assets/images/icons/heart_selected.svg";
const _kDividerColor = Color(0xFFF0F0F0);
const _kTourNameLine = 2;
const _kAccommodationNameLine = 1;
const String _kHeartIconButtonKey = 'heart_icon_button_key';
const String _favouriteCardImageKey = 'favourite_card_image';
const _kIconBottomOffer = 'assets/images/icons/bg_discount_bottom.svg';
const double _kMargin = 7;
const double _kTextTop = 6;
const double _kBottomOfferImageWidth = 77;
const double _kBottomOfferImageHeight = 27;
const double _kTopOfferImageHeight = 43;
const double _kTopOfferImageWidth = 121;
const double _kZero = 0;
const _kIconTopOffer = 'assets/images/icons/bg_offer_top.svg';

//Refactor it while integrating Promotion to the screen
const String _topOfferText = ""; //"ทุกทัวร์";
const String _topOfferPercent = ""; //"ลด 8%";
const String _bottomOfferPercent = ""; //"ลด 100";
const String _bottomOfferText = ""; //"รับ";

class FavouriteTourTile extends StatelessWidget {
  final FavouritesTourViewModel favouritesTour;
  final Function()? onTap;

  const FavouriteTourTile({
    Key? key,
    required this.favouritesTour,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            favouritesTour.tourName,
                            style: AppTheme.kSmallMedium,
                            maxLines: _kTourNameLine,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        _buildFavouriteButton(),
                      ],
                    ),
                    if (favouritesTour.location != null)
                      const SizedBox(height: kSize4),
                    if (favouritesTour.location != null)
                      Text(
                        favouritesTour.location!,
                        maxLines: _kAccommodationNameLine,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.kSmallRegular
                            .copyWith(color: AppColors.kGrey50),
                      ),
                    const SizedBox(height: kSize4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (favouritesTour.serviceName != null)
                          _getAccomodationIconSvg(favouritesTour.serviceName!),
                        if (favouritesTour.serviceName != null)
                          const SizedBox(
                            width: _kSize3,
                          ),
                        if (favouritesTour.category != null)
                          Expanded(
                            child: Text(
                              getTranslated(
                                context,
                                FavouriteHelper.getServiceTypeString(
                                  favouritesTour.serviceName!,
                                ),
                              ),
                              maxLines: _kAccommodationNameLine,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.kSmallRegular
                                  .copyWith(color: AppColors.kGrey50),
                            ),
                          ),
                      ],
                    )
                  ],
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
          child: favouritesTour.imageUrl != null
              ? CachedNetworkImage(
                  imageUrl: favouritesTour.imageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorWidget: (context, url, error) => _getDefaultImages(),
                  placeholder: (context, url) => _getDefaultImages(),
                )
              : _getDefaultImages(),
        ),
        Visibility(
          visible: (_topOfferText != "") || (_topOfferText != ""),
          child: Container(
              alignment: Alignment.topRight,
              child: _buildTopPromoImage(
                  context: context,
                  offerText: _topOfferText,
                  offerPercent: _topOfferPercent)),
        ),
        Visibility(
          visible: (_bottomOfferText != "") || (_bottomOfferText != ""),
          child: Positioned(
              bottom: kSize0,
              child: _buildBottomPromoImage(
                  context: context,
                  offerPercent: _bottomOfferPercent,
                  offerText: _bottomOfferText)),
        ),
      ],
    );
  }

  Widget _buildTopPromoImage(
      {BuildContext? context, String? offerText, String? offerPercent}) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        SvgPicture.asset(
          _kIconTopOffer,
          fit: BoxFit.cover,
          height: _kTopOfferImageHeight,
        ),
        Container(
          width: _kTopOfferImageWidth,
          margin: const EdgeInsets.only(right: _kMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Transform(
                transform: Matrix4.translationValues(_kZero, -kSize2, _kZero),
                child: Text(
                  offerPercent ?? "",
                  style: AppTheme.kofferPercentageNumber,
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(_kZero, -kSize10, _kZero),
                child: Text(
                  offerText ?? "",
                  style: AppTheme.kofferPercentageFooter,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomPromoImage(
      {BuildContext? context, String? offerText, String? offerPercent}) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        SvgPicture.asset(
          _kIconBottomOffer,
          fit: BoxFit.cover,
          height: _kBottomOfferImageHeight,
        ),
        Container(
          width: _kBottomOfferImageWidth,
          margin: const EdgeInsets.only(left: _kMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Transform(
                transform: Matrix4.translationValues(_kZero, _kTextTop, _kZero),
                child: Text(
                  offerText ?? "",
                  style: AppTheme.kofferDiscountHeader,
                ),
              ),
              Text(
                offerPercent ?? "",
                style: AppTheme.kofferDiscountFooter,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getDefaultImages() {
    return SvgPicture.asset(
      _kTourIconPlaceholder,
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

  Widget _getAccomodationIconSvg(String serviceName) {
    switch (FavouriteHelper.getServiceTypeKey(serviceName)) {
      case FavouriteService.tickets:
        return SvgPicture.asset(
          _kTicketIcon,
          height: kSize16,
          width: kSize16,
          fit: BoxFit.contain,
          color: AppColors.kGrey20,
        );
      default:
        return SvgPicture.asset(
          _kTourIcon,
          height: kSize16,
          width: kSize16,
          fit: BoxFit.contain,
          color: AppColors.kGrey20,
        );
    }
  }
}
