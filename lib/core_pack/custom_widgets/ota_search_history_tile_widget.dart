import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const String _kPlaceHolderIcon = 'assets/images/icons/clock-four.svg';

class OtaSearchHistoryTileWidget extends StatelessWidget {
  final String title;
  final String? date;
  final bool isCarRental;
  final Function()? onTap;

  const OtaSearchHistoryTileWidget({
    Key? key,
    required this.title,
    this.onTap,
    this.isCarRental = false,
    this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: kSize24),
      horizontalTitleGap: kSize12,
      leading: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kSize8),
          color: AppColors.kGrey40,
        ),
        width: kSize40,
        height: kSize40,
        child: Center(
          child: SvgPicture.asset(
            _kPlaceHolderIcon,
            width: kSize24,
            height: kSize24,
            color: isCarRental ? AppColors.kGrey20 : AppColors.kGrey50,
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: isCarRental
                ? AppTheme.kBody.copyWith(color: AppColors.kGrey2)
                : AppTheme.kBodyRegular.copyWith(color: AppColors.kGrey2),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (date != null && date!.isNotEmpty)
            Text(
              date!,
              style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}
