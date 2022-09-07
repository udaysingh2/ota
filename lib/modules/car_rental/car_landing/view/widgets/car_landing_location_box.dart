import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const int _kMaxLines = 1;
const String _kSearchIconPath = "assets/images/icons/feather_search.svg";

class CarLandingLocationBox extends StatelessWidget {
  const CarLandingLocationBox({
    Key? key,
    required this.placeholderText,
    required this.headerText,
    required this.onTap,
    this.locationText,
  }) : super(key: key);
  final String placeholderText;
  final String headerText;
  final Function() onTap;
  final String? locationText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: kSize24),
        Text(
          headerText,
          overflow: TextOverflow.ellipsis,
          maxLines: _kMaxLines,
          style: AppTheme.kHeading1Medium,
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: kSize8),
        _getSearchBar(context),
      ],
    );
  }

  Widget _getSearchBar(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kSize8),
          color: AppColors.kGrey4,
        ),
        padding: const EdgeInsets.symmetric(horizontal: kSize14),
        height: kSize40,
        child: Row(
          children: [
            Expanded(
              child: Text(
                locationText ?? placeholderText,
                style: AppTheme.kBodyRegular.copyWith(
                    color: locationText == null
                        ? AppColors.kGrey20
                        : AppColors.kGrey70),
                maxLines: _kMaxLines,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: kSize6),
            SvgPicture.asset(
              _kSearchIconPath,
              height: kSize20,
              width: kSize16,
              color: AppColors.kGrey20,
            ),
          ],
        ),
      ),
    );
  }
}
