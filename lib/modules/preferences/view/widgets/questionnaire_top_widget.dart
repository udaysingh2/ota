import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/preferences/view/widgets/progress_indicator_widget.dart';

const int _kOpacityDuration = 100;

class QuestionnaireTopWidget extends StatelessWidget {
  final int progress;
  final int limit;
  final String? question;
  final String? questionDescription;
  final bool showProgressIndicator;

  const QuestionnaireTopWidget({
    Key? key,
    required this.progress,
    required this.limit,
    this.question,
    this.questionDescription,
    this.showProgressIndicator = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progressWidth = (MediaQuery.of(context).size.width - 2 * kSize24);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslated(context, AppLocalizationsStrings.tellUs),
          style: AppTheme.kSmall1.copyWith(color: AppColors.kGrey70),
        ),
        Text(
          question ?? '',
          style: AppTheme.kHeading3,
        ),
        Text(
          questionDescription ?? '',
          style: AppTheme.kSmall2.copyWith(color: AppColors.kGrey70),
        ),
        const SizedBox(height: kSize11),
        AnimatedOpacity(
          duration: const Duration(milliseconds: _kOpacityDuration),
          opacity: showProgressIndicator ? kSize1 : kSize0,
          child: ProgressIndicatorWidget(
            progress: progress,
            limit: limit,
            width: progressWidth,
          ),
        ),
        const SizedBox(height: kSize19),
      ],
    );
  }
}
