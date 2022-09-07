import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';

const double _kDefaultImageRadius = 8.0;

class OtaRoundedCornerImage extends StatelessWidget {
  final double width;
  final double height;
  final double cornerRadius;
  final String imageUrl;
  final Function()? onPressed;
  final Function()? onError;
  final Widget? errorWidget;
  final Widget? placeholer;

  const OtaRoundedCornerImage({
    Key? key,
    required this.width,
    required this.height,
    this.cornerRadius = _kDefaultImageRadius,
    this.onPressed,
    this.onError,
    this.errorWidget,
    this.placeholer,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: imageUrl,
      placeholder: (context, url) => placeholer ?? _buildPlaceholderView(),
      errorWidget: (context, url, error) {
        if (error != null && onError != null) onError!();
        return errorWidget ?? _buildPlaceholderView();
      },
      imageBuilder: (context, imageProvider) {
        return InkWell(
          borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
          onTap: onPressed,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlaceholderView() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kGalleryPlaceholder,
        borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
      ),
    );
  }
}
