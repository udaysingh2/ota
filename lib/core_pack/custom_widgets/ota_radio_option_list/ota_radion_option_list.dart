import 'package:flutter/material.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_option_list/ota_radio_option_list_bloc.dart';

import '../ota_radio_button/ota_radio_button.dart';

class OtaRadioButtonList extends StatelessWidget {
  final List<String> labelList;
  final int? changedIndexOption;
  final OtaRadioOptionListBloc otaRadioOptionListBloc =
      OtaRadioOptionListBloc();
  final List<Widget>? textWidget;
  final bool circledRadio;
  final bool isCenteredAlign;
  final bool isTextFontRegular;
  final double iconSize;
  final double horizontalPadding;
  final double verticalPadding;
  final Widget? selectedWidget;
  final Widget? unSelectedWidget;
  final Widget? disabledWidget;
  final CrossAxisAlignment? crossAxisAlignment;
  final Function(OtaRadioOptionListBloc otaRadioOptionListBloc)?
      onWidgetStateReady;
  final Function(String)? onPressed;

  OtaRadioButtonList({
    Key? key,
    required this.labelList,
    this.changedIndexOption,
    this.textWidget,
    this.circledRadio = false,
    this.isCenteredAlign = false,
    this.isTextFontRegular = false,
    this.onPressed,
    this.iconSize = kSize20,
    this.horizontalPadding = kSize24,
    this.verticalPadding = kSize12,
    this.selectedWidget,
    this.unSelectedWidget,
    this.disabledWidget,
    this.onWidgetStateReady,
    this.crossAxisAlignment,
  }) : super(key: key) {
    otaRadioOptionListBloc.createRadioButtonList(labelList);
    if (onWidgetStateReady != null) {
      onWidgetStateReady!(otaRadioOptionListBloc);
    }
  }

  Widget _otaButton(
    BuildContext context,
    int index,
  ) {
    return BlocBuilder(
        bloc: otaRadioOptionListBloc,
        builder: () {
          return OtaRadioButton(
            textWidget: textWidget?[index],
            label: labelList[index],
            circledRadio: circledRadio,
            isCenteredAlign: isCenteredAlign,
            isTextFontRegular: isTextFontRegular,
            iconSize: iconSize,
            horizontalPadding: horizontalPadding,
            verticalPadding: verticalPadding,
            disabledWidget: disabledWidget,
            selectedWidget: selectedWidget,
            unSelectedWidget: unSelectedWidget,
            variableCrossAxisAlignment: crossAxisAlignment,
            onClicked: () {
              otaRadioOptionListBloc.onRadioButtonClicked(index);
              onPressed!(labelList[index]);
            },
            isSelected: otaRadioOptionListBloc
                    .state.otaRadioButtonControllers?[index]
                    .isSelected() ??
                true,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: labelList.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return _otaButton(context, index);
      },
    );
  }
}
