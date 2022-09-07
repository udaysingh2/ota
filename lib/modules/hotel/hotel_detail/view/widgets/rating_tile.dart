import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';

const double _kPadding = 4;

class RatingTile extends StatelessWidget {
  final String text;
  const RatingTile({Key? key, this.text = "0.0"}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_kPadding),
        gradient: const LinearGradient(
          colors: [AppColors.kGradientStart, AppColors.kGradientEnd],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: _kPadding,
          right: _kPadding,
        ),
        child: Text(text,
            style: AppTheme.kSmall1.copyWith(
              color: AppColors.kLight100,
            )),
      ),
    );
  }
}
