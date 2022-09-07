import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';

class HotelImageSlider extends StatelessWidget {
  final double sliderHeight;
  final PageController? pageController;
  final List<String> imageUrl;
  const HotelImageSlider(
      {Key? key,
      required this.sliderHeight,
      this.pageController,
      required this.imageUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.kLight100,
      height: sliderHeight,
      child: PageView(
        controller: pageController,
        children: imageUrl.map((e) => getSliderItem(imageUrl: e)).toList(),
      ),
    );
  }

  Widget getSliderItem({String imageUrl = ""}) {
    return CachedNetworkImage(
      errorWidget: (context, url, error) => getDefaultPlaceholder(),
      placeholder: (context, url) => getDefaultPlaceholder(),
      imageUrl: imageUrl,
      fit: BoxFit.fitHeight,
    );
  }

  Widget getDefaultPlaceholder() {
    return Image.asset(
      'assets/images/illustrations/default_bg_image.png',
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
    );
  }
}
