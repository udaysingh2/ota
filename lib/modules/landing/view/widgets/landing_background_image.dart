import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

const String _kPlaceholderImage =
    "assets/images/illustrations/default_bg_image.png";

class LandingBackgroundImage extends StatelessWidget {
  final String landingImageUrl;
  const LandingBackgroundImage(this.landingImageUrl, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return landingImageUrl.isNotEmpty? _getImage() : _getDefaultPlaceholder();
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
    return Image.asset(
      _kPlaceholderImage,
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
    );
  }
}
