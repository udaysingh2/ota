import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const _kMapIcon = 'assets/images/icons/map_marker.svg';
const _kFilterIcon = 'assets/images/icons/icon_filter.svg';
const _kFilterKey = 'filterKey';
const _kDateKey = 'dateFilterKey';
const _kMaxLines = 1;

class TourSearchResultAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String locationName;
  final String selectDateText;
  final Function()? onFilterTap;
  final Function() onSelectDateTextTap;
  final void Function()? onBackTap;

  const TourSearchResultAppBar({
    Key? key,
    required this.locationName,
    required this.selectDateText,
    this.onFilterTap,
    required this.onSelectDateTextTap,
    this.onBackTap,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      margin: EdgeInsets.only(top: statusBarHeight),
      height: kToolbarHeight,
      padding: const EdgeInsets.only(left: kSize10, right: kSize24),
      child: Row(
        children: <Widget>[
          _buildBackIcon(context),
          _buildMapLocation(context),
          _buildFilterText(),
          _buildFilterIcon(),
        ],
      ),
    );
  }

  Widget _buildBackIcon(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        color: AppColors.kGrey70,
        onPressed: onBackTap ?? () => Navigator.of(context).pop(),
      );

  Widget _buildMapIcon() => Padding(
        padding: const EdgeInsets.only(right: kSize4),
        child: SvgPicture.asset(
          _kMapIcon,
          height: kSize20,
          width: kSize20,
          color: AppColors.kGrey70,
        ),
      );

  Widget _buildLocationName() => Expanded(
        child: Text(
          locationName,
          maxLines: _kMaxLines,
          overflow: TextOverflow.ellipsis,
          style: AppTheme.kBodyMedium,
        ),
      );

  Widget _buildFilterText() => InkWell(
        child: Padding(
          key: const Key(_kDateKey),
          padding: const EdgeInsets.symmetric(horizontal: kSize8),
          child: Text(selectDateText,
              style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50)),
        ),
        onTap: () {
          onSelectDateTextTap();
        },
      );

  Widget _buildMapLocation(BuildContext context) => Expanded(
        child: InkWell(
          onTap: onBackTap ?? () => Navigator.of(context).pop(),
          child: Row(
            children: [
              _buildMapIcon(),
              _buildLocationName(),
            ],
          ),
        ),
      );

  Widget _buildFilterIcon() => IconButton(
        key: const Key(_kFilterKey),
        icon: SvgPicture.asset(_kFilterIcon),
        color: AppColors.kGrey70,
        onPressed: onFilterTap,
      );
}
