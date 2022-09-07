import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/consts.dart';

const String _kSearchIconPath = "assets/images/icons/feather_search.svg";

const double _kRightPadding = 5.6;

class HotelLandingSearchIcon extends StatelessWidget {
  const HotelLandingSearchIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildSearchIcon();
  }

  Widget buildSearchIcon() {
    return Padding(
      padding: const EdgeInsets.only(right: _kRightPadding),
      child: SvgPicture.asset(
        _kSearchIconPath,
        height: kSize20,
        width: kSize16,
        color: AppColors.kGrey20,
      ),
    );
  }
}
