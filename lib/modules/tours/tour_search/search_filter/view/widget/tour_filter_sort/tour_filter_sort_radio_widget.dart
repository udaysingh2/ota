import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button.dart';

class TourFilterSortRadioWidget extends StatelessWidget {
  final String label;
  final Function()? onClicked;
  final bool isSelected;
  const TourFilterSortRadioWidget({
    Key? key,
    required this.label,
    this.onClicked,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OtaRadioButton(
      isCenteredAlign: true,
      onClicked: onClicked,
      label: label,
      horizontalPadding: kSize36,
      unSelectedWidget: Ink(
        height: kSize20,
        width: kSize20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.kPurpleOutline),
        ),
      ),
      verticalPadding: kSize8,
      isSelected: isSelected,
      isTextFontRegular: true,
    );
  }
}
