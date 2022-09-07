import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const String _kPlaceholderImage =
    "assets/images/icons/insurance_background_image_placeholder.svg";

class BackgroundImage extends StatelessWidget {
  final String landingImageUrl;
  const BackgroundImage(this.landingImageUrl, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return landingImageUrl.isNotEmpty ? _getImage() : _getDefaultPlaceholder();
  }

  Widget _getImage() {
    return CachedNetworkImage(
      errorWidget: (context, url, error) => _getDefaultPlaceholder(),
      placeholder: (context, url) => _getDefaultPlaceholder(),
      imageUrl: landingImageUrl,
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
    );
  }

  Widget _getDefaultPlaceholder() {
    return SvgPicture.asset(
      _kPlaceholderImage,
      alignment: Alignment.topCenter,
      fit: BoxFit.cover,
    );
  }
}
