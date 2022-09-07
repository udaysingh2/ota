import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ota/common/utils/consts.dart';

const double _kWidth = 240;
const double _kHeight = 275;
const double _kSeparatorWidth = 12;

class OtaPlayListAmenities extends StatefulWidget {
  const OtaPlayListAmenities(
      {Key? key,
      required this.builder,
      required this.length,
      this.width,
      this.listViewPadding = const EdgeInsets.symmetric(horizontal: kSize24)})
      : super(key: key);
  final Widget Function(int) builder;
  final int length;
  final double? width;
  final EdgeInsetsGeometry? listViewPadding;

  @override
  PlayListWidgetState createState() => PlayListWidgetState();
}

class PlayListWidgetState extends State<OtaPlayListAmenities> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _kHeight,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.length,
        padding: widget.listViewPadding,
        itemBuilder: (context, index) {
          return Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: widget.width ?? _kWidth,
              child: widget.builder(index),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: _kSeparatorWidth,
          );
        },
      ),
    );
  }
}
