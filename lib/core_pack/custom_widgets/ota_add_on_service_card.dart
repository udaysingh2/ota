import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';

const double _kImageCardBorderRadius = 12;
const _kIconPlaceholder = 'assets/images/icons/addon_service_placeholder.svg';
const double _kContainerWidth = 151;
const double _kContainerHeight = 148;

class OtaAddOnServiceCard extends StatelessWidget {
  final String? hotelServiceName;
  final String? currency;
  final double? price;
  final String? imageUrl;
  final bool isInHorizonalScroll;
  final double containerWidth;
  final double containerHeight;
  final Function()? onPress;

  const OtaAddOnServiceCard({
    Key? key,
    required this.hotelServiceName,
    this.currency,
    required this.price,
    required this.imageUrl,
    this.isInHorizonalScroll = true,
    this.containerWidth = _kContainerWidth,
    this.containerHeight = _kContainerHeight,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius:
          const BorderRadius.all(Radius.circular(_kImageCardBorderRadius)),
      onTap: onPress,
      child: Container(
        width: containerWidth,
        height: containerHeight,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.kGrey4, width: kSize1),
          borderRadius: BorderRadius.circular(_kImageCardBorderRadius),
        ),
        padding: const EdgeInsets.all(kSize6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isInHorizonalScroll
                ? Expanded(
                    child: _buildImageCard(context),
                  )
                : _buildImageCard(context),
            _getTextFields(),
          ],
        ),
      ),
    );
  }

  Widget _getTextFields() {
    CurrencyUtil currencyUtil =
        CurrencyUtil(currency: currency, decimalDigits: 2);
    return Padding(
      padding: const EdgeInsets.only(left: kSize10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              hotelServiceName ?? '',
              style: AppTheme.kBodyRegular,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              currencyUtil.getFormattedPrice(price ?? 0),
              style: AppTheme.kBodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCard(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          key: const Key("add_on_service_card"),
          borderRadius:
              const BorderRadius.all(Radius.circular(_kImageCardBorderRadius)),
          child: CachedNetworkImage(
              imageUrl: imageUrl ?? '',
              fit: BoxFit.fitWidth,
              width: double.infinity,
              errorWidget: (context, url, error) => getDefaultImages(),
              placeholder: (context, url) => getDefaultImages()),
        ),
      ],
    );
  }

  Widget getDefaultImages() {
    return SvgPicture.asset(_kIconPlaceholder,
        fit: isInHorizonalScroll ? BoxFit.fitHeight : BoxFit.fitWidth);
  }
}
