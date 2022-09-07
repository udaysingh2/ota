import 'package:flutter/material.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_chip_button/ota_chip_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_option_list/ota_radio_option_list_bloc.dart';

class OtaChipButtonList extends StatelessWidget {
  final List<String>? labelList;
  final int? changedIndexOption;
  final OtaRadioOptionListBloc otaRadioOptionListBloc =
      OtaRadioOptionListBloc();
  final List<Widget>? textWidget;
  final Function() onTap;

  OtaChipButtonList({
    Key? key,
    required this.labelList,
    this.changedIndexOption,
    this.textWidget,
    required this.onTap,
  }) : super(key: key);

  Widget _otaChipButton(int index, OtaRadioButtonController controller) {
    return Padding(
      padding: const EdgeInsets.only(right: kSize16),
      child: OtaChipButton(
          titleWidget: textWidget?[index],
          title: labelList?[index] ?? "",
          onPressed: () {
            otaRadioOptionListBloc.unSelect();
            controller.setSelected();
            otaRadioOptionListBloc.setSelected(index, controller);
            onTap();
          },
          isSelected: OtaRadioButtonState.selected ==
              controller.state.otaRadioButtonState),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kSize24,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: textWidget == null ? labelList?.length : textWidget?.length,
        physics: const ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final OtaRadioButtonController otaRadioButtonController =
              OtaRadioButtonController();
          return BlocBuilder(
              bloc: otaRadioButtonController,
              builder: () {
                return _otaChipButton(index, otaRadioButtonController);
              });
        },
      ),
    );
  }
}
