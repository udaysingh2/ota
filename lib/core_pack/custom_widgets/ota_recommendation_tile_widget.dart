import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const String _kPlaceHolderIcon =
    'assets/images/icons/service_card_placeholder.svg';

class OtaRecommendationTileWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final bool isCarRental;
  final Function()? onRecommendationTap;
  const OtaRecommendationTileWidget({
    Key? key,
    required this.title,
    required this.imageUrl,
    this.isCarRental = false,
    this.onRecommendationTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onRecommendationTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: kSize24),
      horizontalTitleGap: kSize12,
      leading: ClipRRect(
          borderRadius: BorderRadius.circular(kSize8),
          child: CachedNetworkImage(
            height: kSize40,
            width: kSize40,
            imageUrl: imageUrl,
            placeholder: (context, url) => SvgPicture.asset(
              _kPlaceHolderIcon,
            ),
            errorWidget: (context, url, error) => SvgPicture.asset(
              _kPlaceHolderIcon,
            ),
            fit: BoxFit.cover,
          )),
      title: Text(
        title,
        style: isCarRental
            ? AppTheme.kBody.copyWith(color: AppColors.kGrey2)
            : AppTheme.kBodyRegular,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
