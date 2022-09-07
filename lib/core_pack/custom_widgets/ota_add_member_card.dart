import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

class OtaAddMemberCard extends StatelessWidget {
  final String hintText;
  final bool isEditingEnabled;
  final TextEditingController textController;
  final Color color;
  final FocusNode? focusNode;
  final int? characterCount;
  final int? maxLines;
  final String textFormatter;
  final String invalidFormatter;
  final double padding;

  const OtaAddMemberCard({
    Key? key,
    required this.hintText,
    required this.textController,
    required this.textFormatter,
    required this.invalidFormatter,
    this.isEditingEnabled = true,
    this.color = AppColors.kGrey20,
    this.focusNode,
    this.characterCount,
    this.padding = kSize24,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: padding),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(kSize8)),
          color: AppColors.kGrey4,
        ),
        child: _buildTextField());
  }

  Widget _buildTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSize12),
      child: TextFormField(
        controller: textController,
        enabled: isEditingEnabled,
        keyboardType: TextInputType.multiline,
        focusNode: focusNode,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: AppTheme.kBodyRegular.copyWith(color: color),
            fillColor: AppColors.kGrey4,
            hintText: hintText),
        maxLines: maxLines,
        inputFormatters: [
          if (characterCount != null)
            LengthLimitingTextInputFormatter(characterCount),
          FilteringTextInputFormatter.allow(
            RegExp(textFormatter),
          ),
          FilteringTextInputFormatter.deny(
            RegExp(invalidFormatter),
          )
        ],
        style: AppTheme.kBodyRegular,
      ),
    );
  }
}
