import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';

const double _kExpandableMaxHeight = 420;
const _kBgImage = 'assets/images/illustrations/default_bg_image.png';

class OtaCoverImage extends StatelessWidget {
  final String? imageUrl;
  const OtaCoverImage({Key? key, this.imageUrl}):super(key: key);
  @override
  Widget build(BuildContext context) {
    var sliderHeight = _kExpandableMaxHeight + kToolbarHeight;
    return Container(
        color: AppColors.kLight100,
        height: sliderHeight,
        child: imageUrl != null
            ? getCoverImage(imageUrl!)
            : getDefaultPlaceholder());
  }

  Widget getCoverImage(String imageUrl) {
    return CachedNetworkImage(
      errorWidget: (context, url, error) => getDefaultPlaceholder(),
      placeholder: (context, url) => getDefaultPlaceholder(),
      imageUrl: imageUrl,
      fit: BoxFit.fitHeight,
    );
  }

  Widget getDefaultPlaceholder() {
    return Image.asset(
      _kBgImage,
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
    );
  }
}
