import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

enum ServiceType {
  tour,
  ticket,
  location,
}

const _kLocationSuggestionIcon = 'assets/images/icons/location_suggestion.svg';
const _kTourSuggestionIcon = 'assets/images/icons/tour_suggestion.svg';
const _kTicketSuggestionIcon = 'assets/images/icons/ticket_suggestion.svg';
const int _kDefaultMaxLine = 2;
const double _kLineHeight = 1.25;

class TourSearchSuggestionTileWidget extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final ServiceType? serviceType;
  final Function()? onSearchSuggestionTap;

  const TourSearchSuggestionTileWidget({
    Key? key,
    required this.title,
    this.imageUrl,
    required this.serviceType,
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
            _getSuggestionImagePlaceholder(),
            const SizedBox(width: kSize12),
            Flexible(
              child: Text(
                title,
                style: AppTheme.kBodyRegular.copyWith(height: _kLineHeight),
                maxLines: _kDefaultMaxLine,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
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
          serviceType == ServiceType.tour
              ? _kTourSuggestionIcon
              : serviceType == ServiceType.ticket
                  ? _kTicketSuggestionIcon
                  : _kLocationSuggestionIcon,
        ),
      ),
    );
  }
}
