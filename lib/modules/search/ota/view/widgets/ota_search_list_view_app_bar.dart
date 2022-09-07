import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/back_button.dart';

const _kAnimationDuration = 200;
const double _kGuestImageSize = 14;
const double _kFilterImageSize = 24;
const double _kDotImageSize = 4;
const int _kMaxLines = 1;
const String _kDotImage = "assets/images/icons/dot.svg";
const String _kGuestImage = "assets/images/icons/guest.svg";
const String _kIconFilter = "assets/images/icons/icon_filter.svg";
const String _kMapIcon = "assets/images/icons/map_marker.svg";

class HotelListViewAppBar extends StatelessWidget {
  final String title;
  final bool isFromOTASearch;
  final String searchFilterText;
  final String totalNumOfPeople;
  final Function()? onTapFilter;
  final Function() onTapSearch;
  final void Function()? onBackClicked;

  const HotelListViewAppBar({
    Key? key,
    required this.title,
    required this.searchFilterText,
    required this.totalNumOfPeople,
    this.isFromOTASearch = false,
    this.onTapFilter,
    required this.onTapSearch,
    this.onBackClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        _buildBackButton(context),
        SvgPicture.asset(_kMapIcon),
        const SizedBox(width: kSize4),
        _getTitle(),
        const SizedBox(width: kSize4),
        if (!isFromOTASearch) _buildNoOfRoomsGuestsWidget(),
        if (!isFromOTASearch) _buildFilterIcon(),
      ],
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: _kAnimationDuration),
      child: BackNavigationButton(
        onClicked: onBackClicked ??
            () {
              Navigator.of(context).pop();
            },
        removeOval: true,
      ),
    );
  }

  Widget _getTitle() {
    return Expanded(
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: AppTheme.kBodyMedium,
      ),
    );
  }

  Widget _buildFilterIcon() {
    return IconButton(
      splashRadius: _kFilterImageSize,
      icon: SvgPicture.asset(
        _kIconFilter,
        width: _kFilterImageSize,
        height: _kFilterImageSize,
        color: AppColors.kGrey70,
      ),
      onPressed: onTapFilter,
    );
  }

  Widget _buildNoOfRoomsGuestsWidget() {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: GestureDetector(
        onTap: onTapSearch,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              searchFilterText,
              style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
              textAlign: TextAlign.right,
              maxLines: _kMaxLines,
            ),
            const SizedBox(width: kSize4),
            SvgPicture.asset(
              _kDotImage,
              width: _kDotImageSize,
              height: _kDotImageSize,
              color: AppColors.kGrey50,
            ),
            const SizedBox(width: kSize4),
            Text(
              totalNumOfPeople,
              style: AppTheme.kSmallRegular.copyWith(
                color: AppColors.kGrey50,
              ),
            ),
            const SizedBox(width: kSize2),
            SvgPicture.asset(
              _kGuestImage,
              width: _kGuestImageSize,
              height: _kGuestImageSize,
              color: AppColors.kGrey50,
            ),
          ],
        ),
      ),
    );
  }
}
