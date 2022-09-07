import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/modules/landing/view_model/service_card_view_model.dart';

const double _kDefaultBorderRadius = 12.0;
const double _kDefaultImageHeight = 109;
const double _kSize160 = 160;
const double _kTextPadding = 4;
const _kSizeMinus3 = -3.0;

class ServiceCardWidget extends StatelessWidget {
  final double height;
  final double width;
  final String headerText;
  final String footerText;
  final String imageUrl;
  final ServiceViewModelService serviceViewModelService;

  final Function()? onTap;
  const ServiceCardWidget(
      {Key? key,
      this.height = _kSize160,
      required this.width,
      required this.headerText,
      required this.footerText,
      required this.serviceViewModelService,
      this.onTap,
      required this.imageUrl})
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
                  imageUrl: imageUrl,
                  errorWidget: (context, string, dyn) {
                    return _getPlaceholderImage();
                  },
                  placeholder: (context, str) {
                    return _getPlaceholderImage();
                  },
                  imageBuilder: (context, imageProvider) {
                    return Image(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      height: _kDefaultImageHeight,
                      width: width,
                    );
                  },
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: _kTextPadding, right: kSize2, left: kSize2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    headerText,
                    style: AppTheme.kBodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: kSize4,
                  ),
                  Container(
                    transform:
                        Matrix4.translationValues(kSize0, _kSizeMinus3, kSize0),
                    width: width,
                    child: Text(
                      footerText,
                      style: AppTheme.kSmallRegular
                          .copyWith(color: AppColors.kGrey50),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getPlaceholderImage() {
    return SizedBox(
      width: width,
      child: SvgPicture.asset(
        serviceViewModelService.placeeholderImage(),
        fit: BoxFit.cover,
        height: _kDefaultImageHeight,
        width: width,
      ),
    );
  }
}
