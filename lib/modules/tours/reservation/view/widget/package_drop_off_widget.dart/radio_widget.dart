import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button.dart';

class RadioWidget extends StatelessWidget {
  final String label;
  final double horizontalPadding;
  final Function()? onClicked;
  final bool isSelected;
  const RadioWidget({
    Key? key,
    required this.label,
    this.horizontalPadding = kSize24,
    this.onClicked,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OtaRadioButton(
          onClicked: onClicked,
          label: label,
          horizontalPadding: kSize36,
          unSelectedWidget: Ink(
            height: kSize20,
            width: kSize20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.kPurpleOutline,
              ),
            ),
          ),
          verticalPadding: kSize16,
          isSelected: isSelected,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        )
      ],
    );
  }
}
