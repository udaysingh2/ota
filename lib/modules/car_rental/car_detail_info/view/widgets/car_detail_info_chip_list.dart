import 'package:flutter/material.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_chip_button/ota_chip_button.dart';

class CarDetailInfoChipList extends StatelessWidget {
  final List<String> chipButtonList;
  final Function(int index)? onTap;
  final int selectedIndex;
  const CarDetailInfoChipList({
    Key? key,
    required this.chipButtonList,
    this.onTap,
    this.selectedIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getCarListWidget();
  }

  Widget _getCarListWidget() {
    return Container(
      height: kSize30,
      margin: const EdgeInsets.only(left: kSize24, right: kSize24, top: kSize8),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return OtaChipButton(
            title: chipButtonList.elementAt(index),
            isSelected: selectedIndex == index ? true : false,
            onPressed: onTap == null
                ? null
                : () {
                    onTap!(index);
                  },
            isLighterGreyColor: true,
          );
        },
        itemCount: chipButtonList.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: kSize8,
          );
        },
      ),
    );
  }
}
