import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

enum SuggestionTileType {
  hotelCityRecommendation,
  hotelSuggestion,
  locationSuggestion,
}

const _kIconPlaceholder = 'assets/images/icons/service_card_placeholder.svg';
const _kLocationSuggestionIcon = 'assets/images/icons/location_suggestion.svg';
const _kHotelSuggestionIcon = 'assets/images/icons/hotel_suggestion.svg';

class OtaSuggestionTileWidget extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final SuggestionTileType searchTileType;
  final Function()? onSearchSuggestionTap;

  const OtaSuggestionTileWidget({
    Key? key,
    required this.title,
    this.imageUrl,
    required this.searchTileType,
    this.onSearchSuggestionTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSearchSuggestionTap,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: kSize24, vertical: kSize8),
        child: Row(
          children: [
            searchTileType == SuggestionTileType.hotelCityRecommendation
                ? _getRecommendationImageView()
                : _getSuggestionImagePlaceholder(),
            const SizedBox(width: kSize12),
            Flexible(
              child: Text(
                title,
                style: AppTheme.kBodyRegular,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getRecommendationImageView() {
    return (imageUrl ?? '').isEmpty
        ? _getRecommendationImagePlaceholder()
        : CachedNetworkImage(
            width: kSize40,
            height: kSize40,
            imageUrl: imageUrl ?? '',
            placeholder: (context, url) => _getRecommendationImagePlaceholder(),
            errorWidget: (context, url, error) =>
                _getRecommendationImagePlaceholder(),
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(kSize8)),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
  }

  Widget _getRecommendationImagePlaceholder() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(kSize8)),
      child: SvgPicture.asset(
        _kIconPlaceholder,
        fit: BoxFit.cover,
        width: kSize40,
        height: kSize40,
      ),
    );
  }

  Widget _getSuggestionImagePlaceholder() {
    return Container(
      width: kSize40,
      height: kSize40,
      decoration: const BoxDecoration(
        color: AppColors.kGrey4,
        borderRadius: BorderRadius.all(Radius.circular(kSize8)),
      ),
      child: Center(
        child: SvgPicture.asset(
          searchTileType == SuggestionTileType.locationSuggestion
              ? _kLocationSuggestionIcon
              : _kHotelSuggestionIcon,
          height: kSize20,
          width: kSize20,
          color: AppColors.kGrey50,
        ),
      ),
    );
  }
}
