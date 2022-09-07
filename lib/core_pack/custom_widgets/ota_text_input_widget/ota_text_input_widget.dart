import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_model.dart';

class OtaTextInputWidget extends StatelessWidget {
  final String? label;
  final String? errorLabel;
  final String? placeHolder;
  final String? errorText;
  final EdgeInsetsGeometry padding;
  final TextEditingController? textEditingController;
  final OtaTextInputState state;
  final List<TextInputFormatter>? textInputFormatter;
  final Function(String)? onChanged;
  final Color backgroundColor;
  final bool isEnabled;
  final bool showCrossIcon;
  final FocusNode? focusNode;
  final bool autofocus;
  final Function()? onClearClick;
  final int? maxLines;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final TextCapitalization textCapitalization;
  final TextInputType? textInputType;
  const OtaTextInputWidget({
    Key? key,
    this.label,
    this.placeHolder,
    this.errorText,
    this.textEditingController,
    this.state = OtaTextInputState.valid,
    this.padding = const EdgeInsets.only(left: kSize30, right: kSize34),
    this.errorLabel,
    this.textInputFormatter,
    this.onChanged,
    this.backgroundColor = AppColors.kGrey4,
    this.isEnabled = true,
    this.showCrossIcon = false,
    this.focusNode,
    this.onClearClick,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
    this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    textEditingController?.selection = TextSelection.fromPosition(
        TextPosition(offset: textEditingController!.text.length));

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            keyboardType: textInputType,
            focusNode: focusNode,
            enabled: isEnabled,
            controller: textEditingController,
            maxLines: maxLines,
            autofocus: autofocus,
            onChanged: onChanged,
            style: AppTheme.kBodyRegular.copyWith(color: AppColors.kGrey70),
            inputFormatters: textInputFormatter,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                  vertical: kSize9, horizontal: kSize12),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kSize8),
                borderSide: BorderSide(
                  color: state == OtaTextInputState.error
                      ? AppColors.kSystemWrong
                      : Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kSize8),
                borderSide: BorderSide(
                  color: state == OtaTextInputState.error
                      ? AppColors.kSystemWrong
                      : Colors.transparent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kSize8),
                borderSide: BorderSide(
                  color: state == OtaTextInputState.error
                      ? AppColors.kSystemWrong
                      : Colors.transparent,
                ),
              ),
              suffixIcon: suffixIcon ??
                  ((state == OtaTextInputState.error &&
                          textEditingController != null &&
                          textEditingController!.text.isNotEmpty &&
                          showCrossIcon)
                      ? IconButton(
                          icon: const Icon(Icons.clear_outlined),
                          iconSize: kSize16,
                          color: AppColors.kSystemWrong,
                          onPressed: onClearClick,
                        )
                      : null),
              filled: true,
              fillColor: backgroundColor,
              hintText: placeHolder,
              hintStyle: AppTheme.kBodyRegular.copyWith(
                color: AppColors.kGrey20,
              ),
              label: state == OtaTextInputState.error
                  ? Text(errorLabel ?? label ?? "",
                      style: AppTheme.kHeading4.copyWith(
                        color: AppColors.kSystemWrong,
                      ))
                  : Text(
                      label ?? "",
                      style: AppTheme.kHeading4.copyWith(
                        color: AppColors.kGrey20,
                        fontSize: kSize18,
                      ),
                    ),
              alignLabelWithHint: true,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            textCapitalization: textCapitalization,
          ),
          Offstage(
              offstage: !(state == OtaTextInputState.error &&
                  errorText != null &&
                  errorText!.isNotEmpty),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kSize18,
                ),
                child: Text(
                  errorText ?? "",
                  style: AppTheme.kSmallerRegular.copyWith(
                    color: AppColors.kSystemWrong,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
