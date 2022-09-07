import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const int _kProgressDuration = 600;

class ProgressIndicatorWidget extends StatelessWidget {
  final double width;
  final int progress;
  final int limit;

  const ProgressIndicatorWidget({
    Key? key,
    required this.width,
    required this.progress,
    required this.limit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progressWidth = progress * (width / limit);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$progress/$limit',
          style: AppTheme.kSmall1.copyWith(color: AppColors.kGrey20),
        ),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: _kProgressDuration),
              height: kSize8,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.kPrimary24,
                borderRadius: BorderRadius.circular(kSize8),
              ),
            ),
            Container(
              width: progressWidth,
              height: kSize8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kSize8),
                gradient: AppColors.kPurpleGradient,
              ),
            )
          ],
        ),
      ],
    );
  }
}
