import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const _kPlaceholderImage = 'assets/images/icons/insurance_card_placeholder.svg';
const _kMaxLines = 3;
const _kNameMaxLines = 1;
const double _kPromotionTextWidth = 50;
const double _kZero = 0;
const double _kPromoImageHeight = 32;
const double _kTopOfferImageWidth = 90;
const String _kIconOffer = 'assets/images/icons/bg_offer_top.svg';

class InsuranceListWidget extends StatelessWidget {
  final int? insuranceId;
  final String? insuranceName;
  final String? imageUrl;
  final String? insuranceSubtext;
  final String? offerText;
  final Function()? onTap;

  const InsuranceListWidget({
    Key? key,
    this.onTap,
    this.insuranceId,
    this.insuranceName,
    this.imageUrl,
    this.insuranceSubtext,
    this.offerText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: kSize100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: kSize100,
              child: _buildImageCard(),
            ),
            const SizedBox(width: kSize16),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (insuranceName != null)
                  Text(
                    insuranceName!,
                    style: AppTheme.kBodyMedium,
                    maxLines: _kNameMaxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (insuranceSubtext != null)
                  const SizedBox(
                    height: kSize4,
                  ),
                if (insuranceSubtext != null)
                  Text(
                    insuranceSubtext!,
                    maxLines: _kMaxLines,
                    style: AppTheme.kSmallRegular
                        .copyWith(color: AppColors.kGrey50),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard() {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        ClipRRect(
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
        if (offerText?.isNotEmpty ?? false) _buildPromoImage(),
      ],
    );
  }

  Widget _getDefaultImages() {
    return SvgPicture.asset(
      _kPlaceholderImage,
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.topCenter,
      fit: BoxFit.cover,
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
          width: _kTopOfferImageWidth,
          margin: const EdgeInsets.only(top: kSize8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (offerText!.isNotEmpty)
                Transform(
                  transform: Matrix4.translationValues(_kZero, -kSize2, _kZero),
                  child: SizedBox(
                    width: _kPromotionTextWidth,
                    height: kSize20,
                    child: Text(
                      offerText!,
                      maxLines: _kNameMaxLines,
                      overflow: TextOverflow.clip,
                      style: AppTheme.kSmallerMedium
                          .copyWith(color: AppColors.kWhiteColor),
                      textAlign: TextAlign.center,
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
