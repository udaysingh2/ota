import 'package:flutter/material.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_option_list/ota_radio_option_list_bloc.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_drop_off_widget.dart/radio_widget.dart';

class RadioWidgetList extends StatelessWidget {
  final List<String> labelList;
  final int selectedIndexOption;
  final OtaRadioOptionListBloc otaRadioOptionListBloc =
      OtaRadioOptionListBloc();
  final Function(OtaRadioOptionListBloc otaRadioOptionListBloc)?
      onWidgetStateReady;
  final Function(int)? onPressed;

  RadioWidgetList({
    Key? key,
    required this.labelList,
    required this.selectedIndexOption,
    this.onPressed,
    this.onWidgetStateReady,
  }) : super(key: key) {
    otaRadioOptionListBloc.createRadioButtonList(labelList);
    otaRadioOptionListBloc.state.otaRadioButtonControllers?[selectedIndexOption]
        .setSelected();
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
          return RadioWidget(
            label: labelList[index],
            onClicked: () {
              otaRadioOptionListBloc.onRadioButtonClicked(index);
              onPressed!(index);
            },
            isSelected: (otaRadioOptionListBloc
                    .state.otaRadioButtonControllers?[index]
                    .isSelected() ??
                true),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: labelList.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return _otaButton(context, index);
        },
      ),
    );
  }
}
