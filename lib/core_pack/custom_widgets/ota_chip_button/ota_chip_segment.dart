import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_chip_button/ota_chip_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const _flexValue = 1;
const _kContainerHeight = 45.0;

class ChipData {
  final String title;
  final Widget widget;
  final int flex;

  ChipData({
    required this.title,
    required this.widget,
    this.flex = _flexValue,
  });
}

class OtaChipSegment extends StatefulWidget {
  final List<ChipData> chipData;
  final double verticalPadding;
  final double horizontalPadding;
  final double spaceBetweenTabs;
  final MainAxisAlignment mainAxisAlignment;

  /*
  * Adding new parameter MainAxisAlignment to set the
  * alignment of chip button in respect of horizontal
  * order, like START, END, CENTER.
  */
  final Function(int index)? onChipSelected;

  /*
  * Adding new parameter onChipSelected to get the
  * callback with selected index, when user selects any chip button.
  */

  const OtaChipSegment(
      {Key? key,
      required this.chipData,
      this.verticalPadding = kSize8,
      this.horizontalPadding = kSize24,
      this.spaceBetweenTabs = kSize8,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.onChipSelected})
      : super(key: key);

  @override
  State<OtaChipSegment> createState() => _OtaChipSegmentState();
}

class _OtaChipSegmentState extends State<OtaChipSegment> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double horizontalPadding;
    if (widget.horizontalPadding >= widget.spaceBetweenTabs) {
      horizontalPadding =
          widget.horizontalPadding - (widget.spaceBetweenTabs / 2);
    } else {
      horizontalPadding =
          (widget.spaceBetweenTabs / 2) - widget.horizontalPadding;
    }

    ///Replacing Row from ListView to make the chip segment scrollable
    /// in horizontal direction.

    ///Adding * [Container] height fix to 45.0 to prevent the infinite expansion
    /// of the container.
    return Column(
      children: [
        Container(
          height: _kContainerHeight,
          padding: EdgeInsets.symmetric(
            vertical: widget.verticalPadding,
          ),
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
            ),
            scrollDirection: Axis.horizontal,
            children: List.generate(widget.chipData.length, (index) {
              return _buildButton(context, index);
            }),
          ),
        ),
        widget.chipData.elementAt(currentIndex).widget
      ],
    );
  }

  _buildButton(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: (widget.spaceBetweenTabs / 2)),
      child: OtaChipButton(
        title: getTranslated(context, widget.chipData.elementAt(index).title),
        isSelected: currentIndex == index,
        onPressed: () {
          setState(
            () {
              currentIndex = index;
              if (widget.onChipSelected != null) {
                widget.onChipSelected!(index);
              }
            },
          );
        },
        isLighterGreyColor: true,
      ),
    );
  }
}
