import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_add_member_card.dart';

class MemberTextWidget extends StatelessWidget {
  final String headerText;
  final String subText;
  final TextEditingController textController;
  final int? characterCount;
  final int? maxLines;
  final String textFormatter;
  final String hintMemberText;
  final String invalidFormatter;
  final double padding;

  const MemberTextWidget({
    Key? key,
    required this.headerText,
    required this.subText,
    required this.textController,
    required this.characterCount,
    required this.textFormatter,
    required this.hintMemberText,
    required this.invalidFormatter,
    this.padding = kSize24,
    this.maxLines,
  }) : super(key: key);

  Widget _getHeading(BuildContext context, double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Text(
        headerText,
        style: AppTheme.kHeading1Medium,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _getSubHeading(BuildContext context, double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padding,
      ),
      child: Text(
        subText,
        style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getHeading(context, padding),
        _getSubHeading(context, padding),
        Padding(
          padding: const EdgeInsets.only(top: kSize16),
          child: OtaAddMemberCard(
            hintText: hintMemberText,
            textController: textController,
            characterCount: characterCount,
            maxLines: maxLines,
            textFormatter: textFormatter,
            padding: padding,
            invalidFormatter: invalidFormatter,
          ),
        )
      ],
    );
  }
}
