import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const _kMaxLines = 1;

class PopUpRadioButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function()? onClicked;

  const PopUpRadioButton(
      {Key? key, required this.label, this.isSelected = false, this.onClicked})
      : super(key: key);

  Widget _getButton(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: kSize24, vertical: kSize12),
      child: Ink(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_getIcon(context), _getText(context)],
        ),
      ),
    );
  }

  Widget _getText(BuildContext context) {
    return Ink(
        padding: const EdgeInsets.only(left: kSize10),
        child: Text(
          label,
          style: AppTheme.kBodyRegular,
          maxLines: _kMaxLines,
          overflow: TextOverflow.ellipsis,
        ));
  }

  Widget _getIcon(BuildContext context) {
    return isSelected
        ? Ink(
            height: kSize20,
            width: kSize20,
            child: const Icon(
              Icons.radio_button_checked,
              color: AppColors.kSecondary,
              size: kSize20,
            ),
          )
        : Ink(
            height: kSize20,
            width: kSize20,
            child: const Icon(
              Icons.radio_button_off,
              color: AppColors.kUnselectedRadioButton,
              size: kSize20,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onClicked, child: _getButton(context));
  }
}
