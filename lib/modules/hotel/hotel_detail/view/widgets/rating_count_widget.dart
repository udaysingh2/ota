import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const _kTotalReview = 10;

class RatingCountWidget extends StatelessWidget {
  final int? rating;
  const RatingCountWidget({Key? key, this.rating = 0}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kPaddingHori4,
      decoration: const BoxDecoration(
          gradient: AppColors.gradient1,
          borderRadius: BorderRadius.all(
            Radius.circular(kSize4),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$rating',
            style: AppTheme.kSmall1.copyWith(color: AppColors.kLight100),
          ),
          Text(
            '/$_kTotalReview',
            style: AppTheme.kSmall1.copyWith(color: AppColors.kPrimary73),
          ),
        ],
      ),
    );
  }
}
