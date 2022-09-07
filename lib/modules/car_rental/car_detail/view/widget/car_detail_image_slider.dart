import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';

const _kDefauldImagePlacehlder =
    'assets/images/illustrations/car_detail_defalut_image.png';

class CarDetailImageSlider extends StatelessWidget {
  final double sliderHeight;
  final List<String> imageUrl;
  final PageController? pageController;

  const CarDetailImageSlider({
    Key? key,
    required this.sliderHeight,
    required this.imageUrl,
    this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.kLight100,
      height: sliderHeight,
      child: PageView(
        controller: pageController,
        children: imageUrl.map((img) => _getSliderItem(imageUrl: img)).toList(),
      ),
    );
  }

  Widget _getSliderItem({String imageUrl = ""}) {
    return imageUrl.isEmpty
        ? _getDefaultPlaceholder()
        : CachedNetworkImage(
            errorWidget: (context, url, error) => _getDefaultPlaceholder(),
            placeholder: (context, url) => _getDefaultPlaceholder(),
            imageUrl: imageUrl,
            fit: BoxFit.contain,
          );
  }

  Widget _getDefaultPlaceholder() {
    return Image.asset(
      _kDefauldImagePlacehlder,
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
    );
  }
}
