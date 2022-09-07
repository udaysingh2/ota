import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const double _kHeight = 80;

class OtaCancellationTextField extends StatelessWidget {
  final String hintText;
  final bool isEditingEnabled;
  final Color color;
  final TextEditingController textEditingController;
  final FocusNode? focusNode;
  final int? characterCount;
  final int? maxLines;
  final String textFormatter;
  final double boxMargin;

  const OtaCancellationTextField({
    Key? key,
    required this.hintText,
    required this.textFormatter,
    required this.textEditingController,
    this.isEditingEnabled = true,
    this.color = AppColors.kGrey20,
    this.focusNode,
    this.characterCount,
    this.maxLines,
    this.boxMargin = kSize24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: _kHeight,
        margin: EdgeInsets.symmetric(horizontal: boxMargin),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(kSize8)),
          color: AppColors.kGrey4,
        ),
        child: _buildTextField());
  }

  Widget _buildTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: kSize12, right: kSize11),
      child: TextFormField(
        controller: textEditingController,
        enabled: isEditingEnabled,
        keyboardType: TextInputType.multiline,
        focusNode: focusNode,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: AppTheme.kBodyGrey50.copyWith(color: color),
            fillColor: AppColors.kGrey4,
            hintText: hintText),
        maxLines: maxLines,
        inputFormatters: [
          if (characterCount != null)
            LengthLimitingTextInputFormatter(characterCount),
          FilteringTextInputFormatter.allow(
            RegExp(textFormatter),
          ),
        ],
        style: AppTheme.kBody,
      ),
    );
  }
}
