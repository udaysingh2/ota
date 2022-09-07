import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

//@Todo we are using ServiceCardWidget class instead of this class (can remove this class after testing done)
const double _kDefaultBorderRadius = 12.0;
const double _kDefaultImageHeight = 109;
const double _kDefaultImageWidth = 100;
const double _kSize160 = 160;
const String _kServiceCardPlaceholder =
    "assets/images/icons/service_card_placeholder.svg";

class HotelSuccessPaymentServiceCardWidget extends StatelessWidget {
  final double height;
  final double? width;
  final String? headerText;
  final String? footerText;
  final String? imageUrl;
  final Function()? onTap;
  const HotelSuccessPaymentServiceCardWidget(
      {Key? key,
      this.height = _kSize160,
      this.width,
      this.headerText,
      this.footerText,
      this.onTap,
      this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(_kDefaultBorderRadius),
              child: SizedBox(
                height: _kDefaultImageHeight,
                child: CachedNetworkImage(
                  imageUrl: imageUrl ?? "",
                  errorWidget: (context, string, dyn) {
                    return SvgPicture.asset(
                      _kServiceCardPlaceholder,
                      fit: BoxFit.cover,
                      height: _kDefaultImageHeight,
                      width: width,
                    );
                  },
                  placeholder: (context, str) {
                    return SvgPicture.asset(
                      _kServiceCardPlaceholder,
                      fit: BoxFit.cover,
                      height: _kDefaultImageHeight,
                      width: width,
                    );
                  },
                  imageBuilder: (context, imageProvider) {
                    return Image(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      height: _kDefaultImageHeight,
                      width: width,
                    );
                  },
                  fit: BoxFit.cover,
                  height: _kDefaultImageHeight,
                  width: _kDefaultImageWidth,
                ),
              ),
            ),
            const SizedBox(
              height: kSize4,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width,
                  child: Text(
                    headerText ?? "",
                    style: AppTheme.kSmallMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: width,
                  child: Text(
                    footerText ?? "",
                    style: AppTheme.kSmallRegular
                        .copyWith(color: AppColors.kGrey50),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
